import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../calc/masuratori.dart';
import '../calc/verdict.dart';
import '../db/database.dart';
import '../db/repositories.dart';
import '../models/enums.dart';
import '../models/profil_firma.dart';
import '../models/solutie.dart';
import '../utils/format.dart';
import 'log_service.dart';

/// Documentele PDF emise dintr-o soluție tehnică (E1/E3): fișa sistemului
/// fotovoltaic și ofertele (materiale, manoperă, completă). Fonturi Roboto
/// incluse în aplicație — diacriticele funcționează offline.
class RaportPdfService {
  pw.Font? _regular;
  pw.Font? _bold;
  pw.Font? _italic;

  Future<void> _fonturi() async {
    if (_regular != null) return;
    _regular = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto-Regular.ttf'),
    );
    _bold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));
    _italic = pw.Font.ttf(
      await rootBundle.load('assets/fonts/Roboto-Italic.ttf'),
    );
  }

  pw.ThemeData get _tema => pw.ThemeData.withFont(
    base: _regular,
    bold: _bold,
    italic: _italic,
  ).copyWith(defaultTextStyle: const pw.TextStyle(fontSize: 9.5));

  static const _albastru = PdfColor.fromInt(0xFF1259C3);
  static const _gri = PdfColor.fromInt(0xFF666666);
  static const _griDeschis = PdfColor.fromInt(0xFFF4F4F4);

  /// Contextul comun: cine emite, pentru cine, pentru ce fișă.
  Future<pw.Document> _document({
    required ProfilFirma profil,
    required FisaLucrare fisa,
    required String titlu,
    required String subtitlu,
    required List<pw.Widget> continut,
  }) async {
    await _fonturi();
    final doc = pw.Document(
      title: '$titlu — ${fisa.lucrare.nrInregistrare}',
      author: profil.denumire.isNotEmpty
          ? profil.denumire
          : profil.electricianNume,
      creator: 'ElectroApp',
      theme: _tema,
    );
    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.fromLTRB(36, 30, 36, 30),
        header: (ctx) =>
            _antet(profil, titlu, subtitlu, fisa, ctx.pageNumber == 1),
        footer: (ctx) => _subsol(profil, ctx),
        build: (ctx) => continut,
      ),
    );
    return doc;
  }

  pw.Widget _antet(
    ProfilFirma p,
    String titlu,
    String subtitlu,
    FisaLucrare fisa,
    bool prima,
  ) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  p.denumire.isNotEmpty ? p.denumire : p.electricianNume,
                  style: pw.TextStyle(
                    fontSize: 13,
                    fontWeight: pw.FontWeight.bold,
                    color: _albastru,
                  ),
                ),
                if (p.cui.isNotEmpty)
                  pw.Text(
                    'CUI ${p.cui}${p.regCom.isNotEmpty ? ' · ${p.regCom}' : ''}',
                    style: const pw.TextStyle(color: _gri, fontSize: 8.5),
                  ),
                if (p.adresa.isNotEmpty)
                  pw.Text(
                    p.adresa,
                    style: const pw.TextStyle(color: _gri, fontSize: 8.5),
                  ),
                if (p.telefon.isNotEmpty || p.email.isNotEmpty)
                  pw.Text(
                    [p.telefon, p.email].where((s) => s.isNotEmpty).join(' · '),
                    style: const pw.TextStyle(color: _gri, fontSize: 8.5),
                  ),
                if (p.atestatTip.isNotEmpty || p.atestatNr.isNotEmpty)
                  pw.Text(
                    'Atestat ANRE ${p.atestatTip} ${p.atestatNr}${p.atestatValabil.isNotEmpty ? ' (valabil până la ${p.atestatValabil})' : ''}',
                    style: const pw.TextStyle(color: _gri, fontSize: 8.5),
                  ),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.end,
              children: [
                pw.Text(
                  titlu,
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  subtitlu,
                  style: const pw.TextStyle(color: _gri, fontSize: 9),
                ),
                pw.Text(
                  'Fișa ${fisa.lucrare.nrInregistrare} · ${formatData(DateTime.now())}',
                  style: const pw.TextStyle(color: _gri, fontSize: 9),
                ),
              ],
            ),
          ],
        ),
        pw.SizedBox(height: 6),
        pw.Divider(color: _albastru, thickness: 1.2),
        pw.SizedBox(height: prima ? 4 : 8),
      ],
    );
  }

  pw.Widget _subsol(ProfilFirma p, pw.Context ctx) {
    final semnatar = [
      if (p.electricianNume.isNotEmpty) p.electricianNume,
      if (p.electricianGrad.isNotEmpty)
        'electrician autorizat ANRE gradul ${p.electricianGrad}',
      if (p.electricianLegitimatie.isNotEmpty)
        'legitimația ${p.electricianLegitimatie}',
    ].join(', ');
    return pw.Column(
      children: [
        pw.Divider(color: _griDeschis, thickness: 0.8),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Expanded(
              child: pw.Text(
                semnatar,
                style: const pw.TextStyle(fontSize: 8, color: _gri),
              ),
            ),
            pw.Text(
              'Pagina ${ctx.pageNumber} / ${ctx.pagesCount}',
              style: const pw.TextStyle(fontSize: 8, color: _gri),
            ),
          ],
        ),
        pw.Text(
          'Estimare orientativă generată cu ElectroApp. Valorile de producție sunt medii multianuale; prețurile pot varia la data achiziției.',
          style: pw.TextStyle(
            fontSize: 7.5,
            color: _gri,
            fontStyle: pw.FontStyle.italic,
          ),
        ),
      ],
    );
  }

  pw.Widget _sectiune(String titlu) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
    child: pw.Text(
      titlu.toUpperCase(),
      style: pw.TextStyle(
        fontSize: 9,
        fontWeight: pw.FontWeight.bold,
        color: _albastru,
        letterSpacing: 0.8,
      ),
    ),
  );

  pw.Widget _perechi(List<(String, String)> randuri) => pw.Table(
    columnWidths: const {0: pw.FixedColumnWidth(150), 1: pw.FlexColumnWidth()},
    children: [
      for (final r in randuri)
        if (r.$2.isNotEmpty)
          pw.TableRow(
            children: [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
                child: pw.Text(r.$1, style: const pw.TextStyle(color: _gri)),
              ),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
                child: pw.Text(r.$2),
              ),
            ],
          ),
    ],
  );

  pw.Widget _tabel(
    List<String> antet,
    List<List<String>> randuri, {
    List<int>? dreapta,
    List<pw.TableColumnWidth>? latimi,
  }) {
    final aliniere = {
      for (var i = 0; i < antet.length; i++)
        i: (dreapta ?? const []).contains(i)
            ? pw.Alignment.centerRight
            : pw.Alignment.centerLeft,
    };
    return pw.TableHelper.fromTextArray(
      headers: antet,
      data: randuri,
      headerStyle: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 8.5,
        color: PdfColors.white,
      ),
      headerDecoration: const pw.BoxDecoration(color: _albastru),
      cellStyle: const pw.TextStyle(fontSize: 8.5),
      cellAlignments: aliniere,
      headerAlignments: aliniere,
      cellPadding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 2.5),
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.4),
      oddRowDecoration: const pw.BoxDecoration(color: _griDeschis),
      columnWidths: latimi == null
          ? null
          : {for (var i = 0; i < latimi.length; i++) i: latimi[i]},
    );
  }

  List<pw.Widget> _beneficiarSiLoc(FisaLucrare fisa) {
    final c = fisa.client;
    final lc = fisa.locConsum;
    return [
      _sectiune('Beneficiar'),
      _perechi([
        ('Denumire', c?.denumire ?? ''),
        ('Tip', c == null ? '' : TipClient.dinCod(c.tip).eticheta),
        ('CUI', c?.cui ?? ''),
        (
          'Telefon / e-mail',
          [
            c?.telefon ?? '',
            c?.email ?? '',
          ].where((s) => s.isNotEmpty).join(' · '),
        ),
        ('Adresă corespondență', c?.adresaCorespondenta ?? ''),
      ]),
      _sectiune('Loc de consum'),
      _perechi([
        (
          'Adresă',
          [
            lc?.adresa ?? '',
            fisa.amplasament,
          ].where((s) => s.isNotEmpty).join(', '),
        ),
        (
          'Operator distribuție',
          lc == null
              ? ''
              : OperatorDistributie.dinCod(lc.operatorDistributie).eticheta,
        ),
        ('Cod POD', lc?.codPod ?? ''),
        (
          'Furnizor / cod client',
          [
            lc?.furnizorEnergie ?? '',
            lc?.codClientFurnizor ?? '',
          ].where((s) => s.isNotEmpty).join(' · '),
        ),
        (
          'Branșament',
          lc == null
              ? ''
              : '${TipBransament.dinCod(lc.bransament).eticheta}, ${NivelTensiune.dinCod(lc.nivelTensiune).eticheta}',
        ),
        (
          'Putere aprobată',
          lc?.putereAprobataKva == null
              ? ''
              : '${formatNumar(lc!.putereAprobataKva)} kVA',
        ),
        (
          'Schema legare la pământ',
          lc == null
              ? ''
              : SchemaLegarePamant.dinCod(lc.schemaLegarePamant).eticheta,
        ),
      ]),
    ];
  }

  List<pw.Widget> _rezumatSistem(RezultatSolutie r, IntrariSolutie i) => [
    _sectiune('Sistemul fotovoltaic propus'),
    _perechi([
      (
        'Putere instalată',
        '${r.kWp.toStringAsFixed(2)} kWp — ${r.nrModule} × ${r.modul}',
      ),
      (
        'Configurație',
        '${r.nrStringuri} string × ${r.ns} module în serie (Voc la ${i.tMinC.toStringAsFixed(0)} °C: ${r.vocTmin.toStringAsFixed(0)} V; Vmp la 70 °C: ${r.vmpTmax.toStringAsFixed(0)} V)',
      ),
      (
        'Invertor',
        '${r.invertor} — ${r.pAcKw} kW, ${r.faze == 1 ? 'monofazat' : 'trifazat'}, ${r.tipInvertor}',
      ),
      (
        'Stocare',
        r.nrBaterii > 0
            ? '${r.nrBaterii} × ${r.baterie} = ${r.stocareKwh.toStringAsFixed(1)} kWh'
            : 'fără',
      ),
      (
        'Protecții AC',
        'disjunctor ${r.disjunctorAcA} A curba B, DDR 30 mA tip ${r.tipDdr}, SPD tip 2; cablu AC ${formatNumar(r.sectiuneAcMm2)} mm²',
      ),
      (
        'Orientare',
        'azimut ${i.azimutGrade.toStringAsFixed(0)}° față de sud, înclinare ${i.inclinareGrade.toStringAsFixed(0)}°, județul ${i.judet}',
      ),
      ('Regim', r.regimProsumator),
    ]),
    _sectiune('Producție și consum'),
    _perechi([
      (
        'Consum anual declarat',
        '${formatNumar(i.consumAnualKwh, zecimale: 0)} kWh',
      ),
      (
        'Producție specifică',
        '${r.productieSpecifica.toStringAsFixed(0)} kWh/kWp/an',
      ),
      (
        'Producție anuală estimată',
        '${formatNumar(r.productieAnualaKwh, zecimale: 0)} kWh (${(r.productieAnualaKwh / (i.consumAnualKwh == 0 ? 1 : i.consumAnualKwh) * 100).toStringAsFixed(0)} % din consum)',
      ),
      (
        'Autoconsum estimat',
        '${(r.fractieAutoconsum * 100).toStringAsFixed(0)} %, adică ${formatNumar(r.energieAutoconsumataKwh, zecimale: 0)} kWh consumați direct, ${formatNumar(r.energieInjectataKwh, zecimale: 0)} kWh injectați',
      ),
      (
        'Economie anuală estimată',
        '${formatNumar(r.economieAnualaRon, zecimale: 0)} RON (la ${formatNumar(i.pretCumparareKwh)} RON/kWh cumpărare, ${formatNumar(i.pretInjectareKwh)} RON/kWh injectare)',
      ),
    ]),
    pw.SizedBox(height: 6),
    _tabel(
      const [
        'Ian',
        'Feb',
        'Mar',
        'Apr',
        'Mai',
        'Iun',
        'Iul',
        'Aug',
        'Sep',
        'Oct',
        'Noi',
        'Dec',
      ],
      [r.productieLunaraKwh.map((v) => v.toStringAsFixed(0)).toList()],
      dreapta: List.generate(12, (i) => i),
    ),
    pw.Padding(
      padding: const pw.EdgeInsets.only(top: 2),
      child: pw.Text(
        'Producție lunară estimată (kWh)',
        style: const pw.TextStyle(fontSize: 8, color: _gri),
      ),
    ),
  ];

  List<pw.Widget> _verdicte(RezultatSolutie r) => [
    _sectiune('Verificări de dimensionare'),
    _tabel(
      const ['Verificare', 'Rezultat', 'Detaliu', 'Referință'],
      [
        for (final v in r.verdicte)
          [v.titlu, _etichetaNivel(v.nivel), v.detaliu, v.referinta],
      ],
      latimi: const [
        pw.FlexColumnWidth(2),
        pw.FixedColumnWidth(55),
        pw.FlexColumnWidth(4),
        pw.FlexColumnWidth(2),
      ],
    ),
    if (r.limitari.isNotEmpty) ...[
      pw.SizedBox(height: 6),
      for (final l in r.limitari)
        pw.Bullet(text: l, style: const pw.TextStyle(fontSize: 8.5)),
    ],
  ];

  static String _etichetaNivel(String n) => switch (n) {
    'conform' => 'Conform',
    'atentie' => 'Atenție',
    'neconform' => 'NECONFORM',
    _ => 'Info',
  };

  List<pw.Widget> _tabelLinii(
    String titlu,
    List<LinieSnapshot> linii, {
    required bool cuPreturi,
  }) {
    final antet = cuPreturi
        ? ['#', 'Denumire', 'Cant.', 'UM', 'Preț unitar', 'Valoare']
        : ['#', 'Denumire', 'Cant.', 'UM'];
    var i = 0;
    String? categorie;
    final randuri = <List<String>>[];
    for (final l in linii) {
      if (l.categorie != categorie && l.categorie != 'Manoperă') {
        categorie = l.categorie;
        randuri.add([
          '',
          categorie.toUpperCase(),
          '',
          '',
          if (cuPreturi) '',
          if (cuPreturi) '',
        ]);
      }
      i++;
      randuri.add([
        '$i',
        l.nota == null ? l.denumire : '${l.denumire}\n${l.nota}',
        formatNumar(l.cantitate),
        l.um,
        if (cuPreturi) formatNumar(l.pretUnitarRon),
        if (cuPreturi) formatNumar(l.valoareRon),
      ]);
    }
    return [
      _sectiune(titlu),
      _tabel(
        antet,
        randuri,
        dreapta: cuPreturi ? const [2, 4, 5] : const [2],
        latimi: cuPreturi
            ? const [
                pw.FixedColumnWidth(18),
                pw.FlexColumnWidth(5),
                pw.FixedColumnWidth(40),
                pw.FixedColumnWidth(28),
                pw.FixedColumnWidth(60),
                pw.FixedColumnWidth(65),
              ]
            : const [
                pw.FixedColumnWidth(18),
                pw.FlexColumnWidth(5),
                pw.FixedColumnWidth(45),
                pw.FixedColumnWidth(30),
              ],
      ),
    ];
  }

  pw.Widget _totaluri(List<(String, double)> randuri, double tvaProcent) {
    final subtotal = randuri.fold<double>(0, (s, r) => s + r.$2);
    final tva = subtotal * tvaProcent / 100;
    pw.TableRow rand(String e, double v, {bool bold = false}) => pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Text(
            e,
            style: pw.TextStyle(fontWeight: bold ? pw.FontWeight.bold : null),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(vertical: 2),
          child: pw.Text(
            '${formatNumar(v)} RON',
            textAlign: pw.TextAlign.right,
            style: pw.TextStyle(
              fontWeight: bold ? pw.FontWeight.bold : null,
              fontSize: bold ? 11 : null,
            ),
          ),
        ),
      ],
    );
    return pw.Container(
      alignment: pw.Alignment.centerRight,
      padding: const pw.EdgeInsets.only(top: 8),
      child: pw.SizedBox(
        width: 260,
        child: pw.Table(
          columnWidths: const {
            0: pw.FlexColumnWidth(),
            1: pw.FixedColumnWidth(110),
          },
          children: [
            for (final r in randuri) rand(r.$1, r.$2),
            rand('Subtotal (fără TVA)', subtotal),
            rand('TVA ${formatNumar(tvaProcent)} %', tva),
            rand('TOTAL cu TVA', subtotal + tva, bold: true),
          ],
        ),
      ),
    );
  }

  // ── Documentele ───────────────────────────────────────────────────────────

  Future<Uint8List> fisaSistem({
    required ProfilFirma profil,
    required FisaLucrare fisa,
    required SolutieSnapshot s,
    required int revizie,
  }) async {
    final doc = await _document(
      profil: profil,
      fisa: fisa,
      titlu: 'Fișa sistemului fotovoltaic',
      subtitlu: 'Soluție tehnică — revizia R$revizie',
      continut: [
        ..._beneficiarSiLoc(fisa),
        ..._rezumatSistem(s.rezultat, s.intrari),
        ..._verdicte(s.rezultat),
        ..._tabelLinii(
          'Necesar de materiale (cantități)',
          s.rezultat.materiale,
          cuPreturi: false,
        ),
        _sectiune('Ipoteze'),
        pw.Bullet(
          text:
              'Producția specifică pe județ și factorul de orientare sunt medii statistice (PVGIS/SARAH3); umbrirea locală nu este inclusă decât prin factorul declarat.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Dimensionarea string-urilor: Voc la Tmin ${s.intrari.tMinC.toStringAsFixed(0)} °C, Vmp la 70 °C celulă (IEC 62548); protecțiile conform I7-2011 / IEC 60364-5-52.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Racordarea ca prosumator urmează Ord. ANRE 19/2022 și norma tehnică Ord. 228/2018; puterea evacuată se limitează la valoarea din ATR.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
      ],
    );
    return doc.save();
  }

  Future<Uint8List> oferta({
    required ProfilFirma profil,
    required FisaLucrare fisa,
    required SolutieSnapshot s,
    required int revizie,
    required TipDocument tip,
    double tvaProcent = 21,
    String observatii = '',
  }) async {
    final r = s.rezultat;
    final cuMateriale = tip != TipDocument.ofertaManopera;
    final cuManopera = tip != TipDocument.ofertaMateriale;
    final doc = await _document(
      profil: profil,
      fisa: fisa,
      titlu: tip.eticheta,
      subtitlu:
          'Sistem fotovoltaic ${r.kWp.toStringAsFixed(2)} kWp — revizia R$revizie',
      continut: [
        ..._beneficiarSiLoc(fisa),
        _sectiune('Obiectul ofertei'),
        pw.Text(
          'Sistem fotovoltaic ${r.faze == 1 ? 'monofazat' : 'trifazat'} de ${r.kWp.toStringAsFixed(2)} kWp '
          '(${r.nrModule} × ${r.modul}, invertor ${r.invertor}'
          '${r.nrBaterii > 0 ? ', stocare ${r.stocareKwh.toStringAsFixed(1)} kWh' : ''}), '
          'producție estimată ${formatNumar(r.productieAnualaKwh, zecimale: 0)} kWh/an, '
          'economie estimată ${formatNumar(r.economieAnualaRon, zecimale: 0)} RON/an.',
        ),
        if (cuMateriale)
          ..._tabelLinii(
            'Materiale și echipamente',
            r.materiale,
            cuPreturi: true,
          ),
        if (cuManopera)
          ..._tabelLinii('Manoperă și servicii', r.manopera, cuPreturi: true),
        _totaluri([
          if (cuMateriale) ('Materiale și echipamente', r.totalMaterialeRon),
          if (cuManopera) ('Manoperă și servicii', r.totalManoperaRon),
        ], tvaProcent),
        if (observatii.isNotEmpty) ...[
          _sectiune('Observații'),
          pw.Text(observatii),
        ],
        _sectiune('Condiții'),
        pw.Bullet(
          text:
              'Prețurile sunt orientative, valabile 30 de zile; echipamentele se confirmă la comandă în funcție de stoc.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Oferta nu include taxele operatorului de distribuție (ATR, racordare) și nici lucrări de consolidare a acoperișului.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Garanții conform producătorilor: module 12–25 ani, invertor 5–10 ani, baterii 10 ani; manoperă 2 ani.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.SizedBox(height: 24),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Ofertant',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 28),
                pw.Text('________________________'),
              ],
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  'Beneficiar',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                ),
                pw.SizedBox(height: 28),
                pw.Text('________________________'),
              ],
            ),
          ],
        ),
      ],
    );
    return doc.save();
  }

  /// Scrie PDF-ul în directorul aplicației (`documente/<nr fișă>/`) și
  /// întoarce calea, hash-ul și mărimea — imutabil, ca în §6.2 H.
  /// Buletinul de verificări la punerea în funcțiune (IEC 62446-1 categoria 1,
  /// plus măsurătorile de joasă tensiune cerute de I7-2011). Măsurătorile vin
  /// deja evaluate — documentul nu recalculează nimic, doar consemnează.
  Future<Uint8List> buletinPif({
    required ProfilFirma profil,
    required FisaLucrare fisa,
    required List<(MasuratoriData, Verdict)> masuratori,
    required List<InstrumenteData> instrumente,
    SolutieSnapshot? solutie,
    List<TipMasuratoare> lipsuri = const [],
    int nrFotografii = 0,
    String observatii = '',
  }) async {
    final neconforme = masuratori
        .where((r) => r.$2.nivel == NivelVerdict.neconform)
        .toList();
    final acum = DateTime.now();

    List<pw.Widget> grup(String titlu, bool Function(TipMasuratoare) filtru) {
      final randuri = masuratori
          .where((r) => filtru(TipMasuratoare.dinCod(r.$1.tip)))
          .toList();
      if (randuri.isEmpty) return const [];
      return [
        _sectiune(titlu),
        _tabel(
          const ['Verificare', 'Țintă', 'Valoare', 'Rezultat', 'Referință'],
          [
            for (final r in randuri)
              [
                TipMasuratoare.dinCod(r.$1.tip).eticheta,
                r.$1.tinta,
                r.$1.valoare == null
                    ? '—'
                    : '${formatNumar(r.$1.valoare!)} ${r.$1.unitate}'.trim(),
                _etichetaNivel(r.$2.nivel.name),
                TipMasuratoare.dinCod(r.$1.tip).referinta,
              ],
          ],
          dreapta: const [2],
          latimi: const [
            pw.FlexColumnWidth(3),
            pw.FixedColumnWidth(45),
            pw.FixedColumnWidth(70),
            pw.FixedColumnWidth(60),
            pw.FlexColumnWidth(2.2),
          ],
        ),
      ];
    }

    final doc = await _document(
      profil: profil,
      fisa: fisa,
      titlu: 'Buletin de verificări la punerea în funcțiune',
      subtitlu: solutie == null
          ? 'Instalație fotovoltaică — IEC 62446-1 categoria 1'
          : 'Sistem ${solutie.rezultat.kWp.toStringAsFixed(2)} kWp — IEC 62446-1 categoria 1',
      continut: [
        ..._beneficiarSiLoc(fisa),
        if (solutie != null) ...[
          _sectiune('Instalația verificată'),
          _perechi([
            ('Putere instalată', '${formatNumar(solutie.rezultat.kWp)} kWp'),
            ('Module', solutie.rezultat.modul),
            ('Invertor', solutie.rezultat.invertor),
            (
              'Configurație string',
              '${solutie.rezultat.nrStringuri} × ${solutie.rezultat.ns} module',
            ),
          ]),
        ],
        ...grup(
          'Verificări pe partea de curent continuu',
          (t) =>
              t == TipMasuratoare.continuitateEchipotential ||
              t == TipMasuratoare.polaritate ||
              t == TipMasuratoare.vocString ||
              t == TipMasuratoare.iscString ||
              t == TipMasuratoare.curentFunctionareString ||
              t == TipMasuratoare.izolatieDc,
        ),
        ...grup(
          'Verificări pe partea de curent alternativ',
          (t) =>
              t == TipMasuratoare.rezistentaPriza ||
              t == TipMasuratoare.impedantaBucla ||
              t == TipMasuratoare.continuitatePe ||
              t == TipMasuratoare.izolatieInstalatie ||
              t == TipMasuratoare.timpDeclansareDdr ||
              t == TipMasuratoare.curentDeclansareDdr ||
              t == TipMasuratoare.tensiuneFazaNul ||
              t == TipMasuratoare.tensiuneFazaFaza ||
              t == TipMasuratoare.dezechilibruFaze,
        ),
        ...grup(
          'Verificări funcționale',
          (t) =>
              t == TipMasuratoare.pornireInvertor ||
              t == TipMasuratoare.antiInsularizare ||
              t == TipMasuratoare.limitareExport ||
              t == TipMasuratoare.decuplarePompieri,
        ),
        if (instrumente.isNotEmpty) ...[
          _sectiune('Aparatura de măsură folosită'),
          _tabel(
            const ['Aparat', 'Serie', 'Etalonare valabilă până la'],
            [
              for (final i in instrumente)
                [
                  [
                    i.producator,
                    i.denumire,
                  ].where((x) => x.isNotEmpty).join(' '),
                  i.serie,
                  i.etalonareExpira == null
                      ? '—'
                      : formatData(i.etalonareExpira!),
                ],
            ],
            latimi: const [
              pw.FlexColumnWidth(3),
              pw.FlexColumnWidth(2),
              pw.FixedColumnWidth(120),
            ],
          ),
        ],
        _sectiune('Concluzie'),
        pw.Container(
          padding: const pw.EdgeInsets.all(8),
          decoration: pw.BoxDecoration(
            color: _griDeschis,
            border: pw.Border.all(color: PdfColors.grey400, width: 0.5),
          ),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                neconforme.isEmpty && lipsuri.isEmpty
                    ? 'Instalația a trecut toate verificările consemnate mai sus și poate fi pusă sub tensiune.'
                    : 'Instalația NU poate fi declarată conformă până la remedierea aspectelor de mai jos.',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              for (final n in neconforme)
                pw.Bullet(
                  text: '${n.$2.titlu}: ${n.$2.detaliu}',
                  style: const pw.TextStyle(fontSize: 8.5),
                ),
              if (lipsuri.isNotEmpty)
                pw.Bullet(
                  text:
                      'Verificări obligatorii nemăsurate: ${lipsuri.map((t) => t.eticheta).join(', ')}.',
                  style: const pw.TextStyle(fontSize: 8.5),
                ),
            ],
          ),
        ),
        if (observatii.isNotEmpty) ...[
          _sectiune('Observații'),
          pw.Text(observatii, style: const pw.TextStyle(fontSize: 9)),
        ],
        _sectiune('Mențiuni'),
        pw.Bullet(
          text:
              'Verificările corespund categoriei 1 din IEC 62446-1; curba I-V și termografia (categoria 2) nu fac obiectul acestui buletin.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Rezistența de izolație se măsoară cu tensiunea de test corespunzătoare tensiunii sistemului, cu limita de 1 MΩ peste 120 V.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        pw.Bullet(
          text:
              'Bateriile de acumulatori se verifică după procedura producătorului, în afara domeniului IEC 62446-1.',
          style: const pw.TextStyle(fontSize: 8.5),
        ),
        if (nrFotografii > 0)
          pw.Bullet(
            text:
                'La dosarul lucrării sunt atașate $nrFotografii fotografii de șantier.',
            style: const pw.TextStyle(fontSize: 8.5),
          ),
        pw.SizedBox(height: 24),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Electrician autorizat ANRE',
                    style: const pw.TextStyle(fontSize: 8.5, color: _gri),
                  ),
                  pw.SizedBox(height: 18),
                  pw.Text(
                    profil.electricianNume.isEmpty
                        ? '............................................'
                        : profil.electricianNume,
                  ),
                  pw.Text(
                    'Data ${formatData(acum)}',
                    style: const pw.TextStyle(fontSize: 8.5, color: _gri),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Beneficiar',
                    style: const pw.TextStyle(fontSize: 8.5, color: _gri),
                  ),
                  pw.SizedBox(height: 18),
                  pw.Text(fisa.client?.denumire ?? ""),
                  pw.Text(
                    'Semnătura ............................',
                    style: const pw.TextStyle(fontSize: 8.5, color: _gri),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
    return doc.save();
  }

  Future<({String cale, String sha256, int marime})> salveaza({
    required Uint8List bytes,
    required String nrInregistrare,
    required TipDocument tip,
    required int versiune,
  }) async {
    final baza = await getApplicationDocumentsDirectory();
    final dir = Directory(
      '${baza.path}${Platform.pathSeparator}documente${Platform.pathSeparator}${nrInregistrare.replaceAll('/', '-')}',
    );
    await dir.create(recursive: true);
    final nume = '${tip.cod}_v$versiune.pdf';
    final f = File('${dir.path}${Platform.pathSeparator}$nume');
    await f.writeAsBytes(bytes, flush: true);
    final hash = sha256.convert(bytes).toString();
    log.info('pdf', '${tip.eticheta} salvat', '$nume · ${bytes.length} octeți');
    return (cale: f.path, sha256: hash, marime: bytes.length);
  }

  static String hashPentru(List<int> bytes) => sha256.convert(bytes).toString();
  static String numeAfisat(DocumenteData d) =>
      '${TipDocument.dinCod(d.tip).eticheta} v${d.versiune}';
  static String jsonDebug(Object o) =>
      const JsonEncoder.withIndent('  ').convert(o);
}
