import 'dart:math';

import 'echipamente.dart';
import 'pv_randament.dart';
import 'pv_string.dart';
import '../services/log_service.dart';
import 'verdict.dart';

/// Regulile de racordare care limitează dimensionarea (docs/CERCETARE.md §3.1):
/// valori implicite editabile de utilizator, nu constante ascunse.
class ReguliRacordare {
  /// Putere AC maximă a unui invertor monofazat acceptată uzual de OD (kW).
  final double pMaxMonofazatKw;

  /// Ord. ANRE 228/2018 art. 12(3): diferența între curenții de fază ≤ 16 A.
  final double dezechilibruMaxA;

  /// Prag ≤ 30 kVA la JT: protecțiile interne ale invertorului sunt suficiente.
  final double pragReleuExternKva;

  /// Praguri de regim prosumator (Legea 160/2026).
  final double pragCompensareLunaraKw;
  final double pragRegularizareKw;
  final double pragProsumatorKw;

  const ReguliRacordare({
    this.pMaxMonofazatKw = 5,
    this.dezechilibruMaxA = 16,
    this.pragReleuExternKva = 30,
    this.pragCompensareLunaraKw = 27,
    this.pragRegularizareKw = 200,
    this.pragProsumatorKw = 400,
  });
}

enum ProfilConsum {
  casnic('casnic', 'Casnic (consum seara)'),
  diurn('diurn', 'Firmă / birou (consum ziua)');

  const ProfilConsum(this.cod, this.eticheta);
  final String cod;
  final String eticheta;
}

enum ModStocare {
  fara('fara', 'Fără stocare'),
  autoconsum('autoconsum', 'Autoconsum (seara/noaptea)'),
  backup('backup', 'Autoconsum + rezervă la pană');

  const ModStocare(this.cod, this.eticheta);
  final String cod;
  final String eticheta;
}

/// Datele de intrare ale estimării — ce știe electricianul după releveu.
class IntrariEstimare {
  final double consumAnualKwh;
  final ProfilConsum profil;
  final int faze; // 1 sau 3
  final double? putereAprobataKva;
  final String judet;
  final double azimutGrade;
  final double inclinareGrade;
  final double suprafataUtilaM2;
  final double factorUmbrire;

  /// Fracția din consum pe care vrem s-o acoperim cu producția anuală.
  final double acoperire;
  final ModStocare stocare;
  final double autonomieBackupOre;
  final double pAcMaxDoritaKw; // 0 = fără limită suplimentară
  final ModulPV modul;
  final List<InvertorPV> invertoare;
  final List<BateriePV> baterii;
  final ReguliRacordare reguli;
  final double tMinC;

  /// Prețuri pentru economie (RON/kWh).
  final double pretCumparareKwh;
  final double pretInjectareKwh;

  const IntrariEstimare({
    required this.consumAnualKwh,
    required this.profil,
    required this.faze,
    required this.judet,
    this.putereAprobataKva,
    this.azimutGrade = 0,
    this.inclinareGrade = 30,
    this.suprafataUtilaM2 = 0,
    this.factorUmbrire = 1.0,
    this.acoperire = 1.0,
    this.stocare = ModStocare.fara,
    this.autonomieBackupOre = 8,
    this.pAcMaxDoritaKw = 0,
    this.modul = const ModulPV(
      producator: 'Jinko',
      model: 'Tiger Neo 440 W (N-type, 108 cel.)',
      pmaxW: 440,
      vocV: 39.6,
      iscA: 14.0,
      vmpV: 33.2,
      impA: 13.3,
      betaVocPctK: -0.25,
      gammaPmaxPctK: -0.29,
      pretRon: 460,
    ),
    this.invertoare = CatalogImplicit.invertoare,
    this.baterii = CatalogImplicit.baterii,
    this.reguli = const ReguliRacordare(),
    this.tMinC = -25,
    this.pretCumparareKwh = 1.3,
    this.pretInjectareKwh = 0.65,
  });

  double get consumZilnicKwh => consumAnualKwh / 365;
}

/// Rezultatul estimării: sistemul propus, producția, autoconsumul, economia.
class EstimareSistem {
  final IntrariEstimare intrari;
  final ConfigString config;
  final InvertorPV invertor;
  final BateriePV? baterie;
  final int nrBaterii;
  final double productieSpecifica; // kWh/kWp/an la amplasament
  final double productieAnualaKwh;
  final List<double> productieLunaraKwh;
  final double fractieAutoconsum;
  final List<Verdict> verdicte;
  final List<String> limitari;

  const EstimareSistem({
    required this.intrari,
    required this.config,
    required this.invertor,
    required this.baterie,
    required this.nrBaterii,
    required this.productieSpecifica,
    required this.productieAnualaKwh,
    required this.productieLunaraKwh,
    required this.fractieAutoconsum,
    required this.verdicte,
    required this.limitari,
  });

  double get kWp => config.kWp;
  int get nrModule => config.nrModule;
  double get stocareKwh => (baterie?.capacitateKwh ?? 0) * nrBaterii;
  double get stocareUtilaKwh => (baterie?.utilizabilaKwh ?? 0) * nrBaterii;
  double get energieAutoconsumataKwh =>
      min(productieAnualaKwh * fractieAutoconsum, intrari.consumAnualKwh);
  double get energieInjectataKwh =>
      productieAnualaKwh - energieAutoconsumataKwh;
  double get gradAcoperire => intrari.consumAnualKwh <= 0
      ? 0
      : productieAnualaKwh / intrari.consumAnualKwh;

  /// Economia anuală estimată (RON): energie neconsumată din rețea + surplus.
  double get economieAnualaRon =>
      energieAutoconsumataKwh * intrari.pretCumparareKwh +
      energieInjectataKwh * intrari.pretInjectareKwh;

  /// Regimul de prosumator după puterea instalată.
  String get regimProsumator {
    final r = intrari.reguli;
    String f(double v) => v.toStringAsFixed(0);
    if (kWp > r.pragProsumatorKw) {
      return 'Producător (peste ${f(r.pragProsumatorKw)} kW) — licență ANRE';
    }
    if (kWp > r.pragRegularizareKw) {
      return 'Prosumator ${f(r.pragRegularizareKw)}–${f(r.pragProsumatorKw)} kW — regularizare financiară (preț PZU)';
    }
    if (kWp > r.pragCompensareLunaraKw) {
      return 'Prosumator ${f(r.pragCompensareLunaraKw)}–${f(r.pragRegularizareKw)} kW — compensare cantitativă lunară';
    }
    return 'Prosumator ≤ ${f(r.pragCompensareLunaraKw)} kW — compensare cantitativă lunară 1:1';
  }
}

class EstimatorPV {
  EstimatorPV._();

  /// m² de acoperiș pe kWp, cu spații de montaj și retrageri (§3.2 Mecanic).
  static const m2PerKwpAcoperis = 5.0;

  static EstimareSistem estimeaza(IntrariEstimare i) {
    log.debug(
      'estimare',
      'Calcul sistem',
      'consum ${i.consumAnualKwh.toStringAsFixed(0)} kWh · ${i.faze} faze · '
          '${i.judet} · azimut ${i.azimutGrade.toStringAsFixed(0)}° · '
          'înclinare ${i.inclinareGrade.toStringAsFixed(0)}° · stocare ${i.stocare.cod}',
    );
    final limitari = <String>[];
    final r = i.reguli;
    final specific =
        RandamentPV.productieSpecifica(i.judet) *
        RandamentPV.factorOrientare(
          azimutGrade: i.azimutGrade,
          inclinareGrade: i.inclinareGrade,
        ) *
        i.factorUmbrire;

    // 1. Puterea țintă din consum și acoperire.
    var kWpTinta = i.consumAnualKwh * i.acoperire / specific;

    // 2. Limitări: acoperiș, fază, putere aprobată, dorință.
    if (i.suprafataUtilaM2 > 0) {
      final maxAcoperis = i.suprafataUtilaM2 / m2PerKwpAcoperis;
      if (kWpTinta > maxAcoperis) {
        limitari.add(
          'Suprafața de ${i.suprafataUtilaM2.toStringAsFixed(0)} m² permite ~${maxAcoperis.toStringAsFixed(1)} kWp (${m2PerKwpAcoperis.toStringAsFixed(0)} m²/kWp)',
        );
        kWpTinta = maxAcoperis;
      }
    }
    var pAcMax = i.faze == 1 ? r.pMaxMonofazatKw : double.infinity;
    if (i.faze == 1 && kWpTinta > r.pMaxMonofazatKw * 1.3) {
      limitari.add(
        'Branșament monofazat: invertor ≤ ${r.pMaxMonofazatKw.toStringAsFixed(0)} kW (OD) — pentru mai mult e nevoie de trifazat',
      );
    }
    if (i.putereAprobataKva != null && i.putereAprobataKva! > 0) {
      pAcMax = min(pAcMax, i.putereAprobataKva!);
      if (kWpTinta > i.putereAprobataKva! * 1.3) {
        limitari.add(
          'Putere aprobată ${i.putereAprobataKva!.toStringAsFixed(1)} kVA: invertorul nu poate evacua mai mult fără ATR nou',
        );
      }
    }
    if (i.pAcMaxDoritaKw > 0) pAcMax = min(pAcMax, i.pAcMaxDoritaKw);
    if (pAcMax.isFinite) kWpTinta = min(kWpTinta, pAcMax * 1.3);
    kWpTinta = max(kWpTinta, i.modul.pmaxW / 1000 * 4);

    // 3. Invertorul: pe faze, hibrid dacă e stocare, P_AC în jurul kWp/1,2.
    final vreaHibrid = i.stocare != ModStocare.fara;
    var candidati = i.invertoare
        .where((inv) => inv.faze == i.faze)
        .where((inv) => vreaHibrid ? inv.esteHibrid : true)
        .where((inv) => !pAcMax.isFinite || inv.pAcNomKw <= pAcMax + 0.01)
        .toList();
    if (candidati.isEmpty) {
      candidati = i.invertoare.where((inv) => inv.faze == i.faze).toList();
      if (vreaHibrid) {
        limitari.add(
          'Niciun invertor hibrid potrivit în catalog — propus invertor string',
        );
      }
    }
    if (candidati.isEmpty) candidati = i.invertoare.toList();
    InvertorPV invertor = candidati.first;
    var abatere = double.infinity;
    for (final inv in candidati) {
      final d = (inv.pAcNomKw - kWpTinta / 1.2).abs();
      if (d < abatere) {
        abatere = d;
        invertor = inv;
      }
    }

    // 4. Configurația de string-uri în jurul numărului de module dorit.
    final nrDorit = max(4, (kWpTinta * 1000 / i.modul.pmaxW).round());
    var config = ConfigString.propune(
      modul: i.modul,
      invertor: invertor,
      nrModuleDorit: nrDorit,
      tMinC: i.tMinC,
    );
    if (config == null) {
      // fără configurație conformă: cea mai apropiată, cu verdictele ei
      final ns = ConfigString.nsMax(
        i.modul,
        invertor,
        tMinC: i.tMinC,
      ).clamp(1, 40);
      config = ConfigString(
        modul: i.modul,
        invertor: invertor,
        ns: ns,
        nrStringuri: max(
          1,
          (nrDorit / ns).round().clamp(1, invertor.stringuriMax),
        ),
        tMinC: i.tMinC,
      );
      limitari.add(
        'Nu s-a găsit o configurație de string-uri complet conformă — verifică verdictele',
      );
    }

    // 5. Stocarea.
    BateriePV? baterie;
    var nrBaterii = 0;
    if (vreaHibrid) {
      final potrivite = i.baterii
          .where((b) => b.hv == invertor.baterieHv)
          .toList();
      baterie = potrivite.isEmpty ? i.baterii.first : potrivite.first;
      final zi = i.consumZilnicKwh;
      double necesar;
      if (i.stocare == ModStocare.backup) {
        // consum critic ~40 % din mediu, pe durata autonomiei, peste DoD
        necesar = max(
          0.5 * zi,
          0.4 * zi * i.autonomieBackupOre / 24 / baterie.dod + 0.5 * zi,
        );
      } else {
        necesar = 0.5 * zi; // energia serii + nopții
      }
      necesar = necesar.clamp(baterie.capacitateKwh, 6 * baterie.capacitateKwh);
      nrBaterii = (necesar / baterie.capacitateKwh).ceil();
    }

    // 6. Producție, autoconsum, verdicte.
    final productie = config.kWp * specific;
    final sc = RandamentPV.autoconsum(
      raport: i.consumAnualKwh <= 0 ? 1 : productie / i.consumAnualKwh,
      profilDiurn: i.profil == ProfilConsum.diurn,
      stocareKwh: (baterie?.utilizabilaKwh ?? 0) * nrBaterii,
      consumZilnicKwh: i.consumZilnicKwh,
    );
    final verdicte = [...config.verifica()];
    if (i.faze == 1) {
      final iAc = invertor.pAcNomKw * 1000 / 230;
      verdicte.add(
        Verdict(
          cod: 'monofazat',
          titlu: 'Injecție pe o fază',
          nivel: invertor.pAcNomKw <= r.pMaxMonofazatKw
              ? NivelVerdict.conform
              : NivelVerdict.atentie,
          detaliu:
              'Invertor ${invertor.pAcNomKw} kW ≈ ${iAc.toStringAsFixed(1)} A pe fază; OD acceptă uzual ≤ ${r.pMaxMonofazatKw.toStringAsFixed(0)} kW; pe branșament trifazat dezechilibrul ≤ ${r.dezechilibruMaxA.toStringAsFixed(0)} A',
          referinta: 'Ord. ANRE 228/2018 art. 12(3)',
        ),
      );
    }
    verdicte.add(
      Verdict(
        cod: 'releu_interfata',
        titlu: 'Protecție de interfață',
        nivel: NivelVerdict.informativ,
        detaliu: invertor.pAcNomKw <= r.pragReleuExternKva
            ? 'Sub ${r.pragReleuExternKva.toStringAsFixed(0)} kVA: protecțiile interne ale invertorului sunt suficiente'
            : 'Peste ${r.pragReleuExternKva.toStringAsFixed(0)} kVA: releu de interfață extern + întrerupător de interfață',
        referinta: 'Ord. ANRE 228/2018 art. 14(3)',
      ),
    );
    if (i.putereAprobataKva != null &&
        i.putereAprobataKva! > 0 &&
        invertor.pAcNomKw > i.putereAprobataKva!) {
      verdicte.add(
        Verdict(
          cod: 'sevac',
          titlu: 'Putere evacuată',
          nivel: NivelVerdict.atentie,
          detaliu:
              'Invertorul (${invertor.pAcNomKw} kW) depășește puterea aprobată ${i.putereAprobataKva!.toStringAsFixed(1)} kVA — se limitează software la Sevac sau se cere ATR nou',
          referinta: 'ATR · Ord. ANRE 19/2022',
        ),
      );
    }

    log.info(
      'estimare',
      'Sistem estimat',
      '${config.kWp.toStringAsFixed(2)} kWp (${config.nrModule} module, '
          '${config.nrStringuri}×${config.ns}) · ${invertor.denumire} · '
          '${nrBaterii > 0 ? '$nrBaterii baterii · ' : ''}'
          '${productie.toStringAsFixed(0)} kWh/an · '
          '${verdicte.where((v) => v.nivel == NivelVerdict.neconform).length} neconformități'
          '${limitari.isEmpty ? '' : ' · ${limitari.length} limitări'}',
    );
    return EstimareSistem(
      intrari: i,
      config: config,
      invertor: invertor,
      baterie: baterie,
      nrBaterii: nrBaterii,
      productieSpecifica: specific,
      productieAnualaKwh: productie,
      productieLunaraKwh: RandamentPV.productieLunara(productie),
      fractieAutoconsum: sc,
      verdicte: verdicte,
      limitari: limitari,
    );
  }
}
