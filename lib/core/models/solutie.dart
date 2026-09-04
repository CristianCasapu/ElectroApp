import 'dart:convert';

import '../calc/echipamente.dart';
import '../calc/materiale.dart';
import '../calc/pv_estimare.dart';
import '../calc/verdict.dart';

/// Serializarea unei estimări (intrări + rezultat + necesar) pentru tabela
/// `solutii`: revizia se poate reciti și documentele regenerate identic, chiar
/// dacă între timp s-au schimbat catalogul sau prețurile.
class SolutieSnapshot {
  final IntrariSolutie intrari;
  final RezultatSolutie rezultat;

  const SolutieSnapshot({required this.intrari, required this.rezultat});

  String get titluScurt =>
      '${rezultat.kWp.toStringAsFixed(2)} kWp · ${rezultat.invertor}'
      '${rezultat.stocareKwh > 0 ? ' · ${rezultat.stocareKwh.toStringAsFixed(1)} kWh' : ''}';
}

/// Intrările estimării în formă serializabilă (fără obiecte de catalog).
class IntrariSolutie {
  final double consumAnualKwh;
  final String profil; // ProfilConsum.cod
  final int faze;
  final double? putereAprobataKva;
  final String judet;
  final double azimutGrade;
  final double inclinareGrade;
  final double suprafataUtilaM2;
  final double acoperire;
  final String stocare; // ModStocare.cod
  final double autonomieBackupOre;
  final double pAcMaxDoritaKw;
  final String modulModel;
  final double tMinC;
  final double pretCumparareKwh;
  final double pretInjectareKwh;
  final double lungimeDcM;
  final double lungimeAcM;
  final double lungimeTeg2ContorM;
  final bool prizaPamantNoua;
  final bool acoperisTabla;
  final bool terasa;
  final double distantaKm;

  const IntrariSolutie({
    required this.consumAnualKwh,
    required this.profil,
    required this.faze,
    required this.putereAprobataKva,
    required this.judet,
    required this.azimutGrade,
    required this.inclinareGrade,
    required this.suprafataUtilaM2,
    required this.acoperire,
    required this.stocare,
    required this.autonomieBackupOre,
    required this.pAcMaxDoritaKw,
    required this.modulModel,
    required this.tMinC,
    required this.pretCumparareKwh,
    required this.pretInjectareKwh,
    required this.lungimeDcM,
    required this.lungimeAcM,
    required this.lungimeTeg2ContorM,
    required this.prizaPamantNoua,
    required this.acoperisTabla,
    required this.terasa,
    required this.distantaKm,
  });

  ProfilConsum get profilEnum => ProfilConsum.values.firstWhere(
    (p) => p.cod == profil,
    orElse: () => ProfilConsum.casnic,
  );
  ModStocare get stocareEnum => ModStocare.values.firstWhere(
    (m) => m.cod == stocare,
    orElse: () => ModStocare.fara,
  );

  ModulPV get modul => CatalogImplicit.module.firstWhere(
    (m) => m.model == modulModel,
    orElse: () => CatalogImplicit.module.first,
  );

  IntrariEstimare laEstimare() => IntrariEstimare(
    consumAnualKwh: consumAnualKwh,
    profil: profilEnum,
    faze: faze,
    putereAprobataKva: putereAprobataKva,
    judet: judet,
    azimutGrade: azimutGrade,
    inclinareGrade: inclinareGrade,
    suprafataUtilaM2: suprafataUtilaM2,
    acoperire: acoperire,
    stocare: stocareEnum,
    autonomieBackupOre: autonomieBackupOre,
    pAcMaxDoritaKw: pAcMaxDoritaKw,
    modul: modul,
    tMinC: tMinC,
    pretCumparareKwh: pretCumparareKwh,
    pretInjectareKwh: pretInjectareKwh,
  );

  Map<String, dynamic> toJson() => {
    'consumAnualKwh': consumAnualKwh,
    'profil': profil,
    'faze': faze,
    'putereAprobataKva': putereAprobataKva,
    'judet': judet,
    'azimutGrade': azimutGrade,
    'inclinareGrade': inclinareGrade,
    'suprafataUtilaM2': suprafataUtilaM2,
    'acoperire': acoperire,
    'stocare': stocare,
    'autonomieBackupOre': autonomieBackupOre,
    'pAcMaxDoritaKw': pAcMaxDoritaKw,
    'modulModel': modulModel,
    'tMinC': tMinC,
    'pretCumparareKwh': pretCumparareKwh,
    'pretInjectareKwh': pretInjectareKwh,
    'lungimeDcM': lungimeDcM,
    'lungimeAcM': lungimeAcM,
    'lungimeTeg2ContorM': lungimeTeg2ContorM,
    'prizaPamantNoua': prizaPamantNoua,
    'acoperisTabla': acoperisTabla,
    'terasa': terasa,
    'distantaKm': distantaKm,
  };

  factory IntrariSolutie.fromJson(Map<String, dynamic> j) => IntrariSolutie(
    consumAnualKwh: (j['consumAnualKwh'] as num).toDouble(),
    profil: j['profil'] as String,
    faze: j['faze'] as int,
    putereAprobataKva: (j['putereAprobataKva'] as num?)?.toDouble(),
    judet: j['judet'] as String,
    azimutGrade: (j['azimutGrade'] as num).toDouble(),
    inclinareGrade: (j['inclinareGrade'] as num).toDouble(),
    suprafataUtilaM2: (j['suprafataUtilaM2'] as num).toDouble(),
    acoperire: (j['acoperire'] as num).toDouble(),
    stocare: j['stocare'] as String,
    autonomieBackupOre: (j['autonomieBackupOre'] as num).toDouble(),
    pAcMaxDoritaKw: (j['pAcMaxDoritaKw'] as num).toDouble(),
    modulModel: j['modulModel'] as String,
    tMinC: (j['tMinC'] as num).toDouble(),
    pretCumparareKwh: (j['pretCumparareKwh'] as num).toDouble(),
    pretInjectareKwh: (j['pretInjectareKwh'] as num).toDouble(),
    lungimeDcM: (j['lungimeDcM'] as num).toDouble(),
    lungimeAcM: (j['lungimeAcM'] as num).toDouble(),
    lungimeTeg2ContorM: (j['lungimeTeg2ContorM'] as num).toDouble(),
    prizaPamantNoua: j['prizaPamantNoua'] as bool,
    acoperisTabla: j['acoperisTabla'] as bool,
    terasa: j['terasa'] as bool,
    distantaKm: (j['distantaKm'] as num).toDouble(),
  );

  String encode() => jsonEncode(toJson());
  static IntrariSolutie decode(String s) =>
      IntrariSolutie.fromJson(jsonDecode(s) as Map<String, dynamic>);
}

class LinieSnapshot {
  final String categorie;
  final String denumire;
  final double cantitate;
  final String um;
  final double pretUnitarRon;
  final String? nota;

  const LinieSnapshot({
    required this.categorie,
    required this.denumire,
    required this.cantitate,
    required this.um,
    required this.pretUnitarRon,
    this.nota,
  });

  double get valoareRon => cantitate * pretUnitarRon;

  Map<String, dynamic> toJson() => {
    'categorie': categorie,
    'denumire': denumire,
    'cantitate': cantitate,
    'um': um,
    'pretUnitarRon': pretUnitarRon,
    'nota': nota,
  };

  factory LinieSnapshot.fromJson(Map<String, dynamic> j) => LinieSnapshot(
    categorie: j['categorie'] as String,
    denumire: j['denumire'] as String,
    cantitate: (j['cantitate'] as num).toDouble(),
    um: j['um'] as String,
    pretUnitarRon: (j['pretUnitarRon'] as num).toDouble(),
    nota: j['nota'] as String?,
  );
}

class VerdictSnapshot {
  final String cod;
  final String titlu;
  final String nivel;
  final String detaliu;
  final String referinta;

  const VerdictSnapshot({
    required this.cod,
    required this.titlu,
    required this.nivel,
    required this.detaliu,
    required this.referinta,
  });

  NivelVerdict get nivelEnum => NivelVerdict.values.firstWhere(
    (n) => n.name == nivel,
    orElse: () => NivelVerdict.informativ,
  );

  Map<String, dynamic> toJson() => {
    'cod': cod,
    'titlu': titlu,
    'nivel': nivel,
    'detaliu': detaliu,
    'referinta': referinta,
  };

  factory VerdictSnapshot.fromJson(Map<String, dynamic> j) => VerdictSnapshot(
    cod: j['cod'] as String,
    titlu: j['titlu'] as String,
    nivel: j['nivel'] as String,
    detaliu: j['detaliu'] as String,
    referinta: j['referinta'] as String,
  );
}

/// Rezultatul estimării înghețat: numerele care apar în documente.
class RezultatSolutie {
  final double kWp;
  final int nrModule;
  final String modul;
  final int ns;
  final int nrStringuri;
  final double vocTmin;
  final double vmpTmax;
  final String invertor;
  final String tipInvertor;
  final int faze;
  final double pAcKw;
  final String? baterie;
  final int nrBaterii;
  final double stocareKwh;
  final double productieSpecifica;
  final double productieAnualaKwh;
  final List<double> productieLunaraKwh;
  final double fractieAutoconsum;
  final double energieAutoconsumataKwh;
  final double energieInjectataKwh;
  final double economieAnualaRon;
  final String regimProsumator;
  final List<VerdictSnapshot> verdicte;
  final List<String> limitari;
  final List<LinieSnapshot> materiale;
  final List<LinieSnapshot> manopera;
  final double sectiuneAcMm2;
  final int disjunctorAcA;
  final String tipDdr;

  const RezultatSolutie({
    required this.kWp,
    required this.nrModule,
    required this.modul,
    required this.ns,
    required this.nrStringuri,
    required this.vocTmin,
    required this.vmpTmax,
    required this.invertor,
    required this.tipInvertor,
    required this.faze,
    required this.pAcKw,
    required this.baterie,
    required this.nrBaterii,
    required this.stocareKwh,
    required this.productieSpecifica,
    required this.productieAnualaKwh,
    required this.productieLunaraKwh,
    required this.fractieAutoconsum,
    required this.energieAutoconsumataKwh,
    required this.energieInjectataKwh,
    required this.economieAnualaRon,
    required this.regimProsumator,
    required this.verdicte,
    required this.limitari,
    required this.materiale,
    required this.manopera,
    required this.sectiuneAcMm2,
    required this.disjunctorAcA,
    required this.tipDdr,
  });

  double get totalMaterialeRon => materiale.fold(0, (s, l) => s + l.valoareRon);
  double get totalManoperaRon => manopera.fold(0, (s, l) => s + l.valoareRon);
  double get totalRon => totalMaterialeRon + totalManoperaRon;
  double get paybackAni =>
      economieAnualaRon <= 0 ? double.infinity : totalRon / economieAnualaRon;

  factory RezultatSolutie.din(EstimareSistem e, NecesarMateriale n) =>
      RezultatSolutie(
        kWp: e.kWp,
        nrModule: e.nrModule,
        modul: e.intrari.modul.denumire,
        ns: e.config.ns,
        nrStringuri: e.config.nrStringuri,
        vocTmin: e.config.vocLaTmin,
        vmpTmax: e.config.vmpLaTmax,
        invertor: e.invertor.denumire,
        tipInvertor: e.invertor.tip.eticheta,
        faze: e.invertor.faze,
        pAcKw: e.invertor.pAcNomKw,
        baterie: e.baterie?.denumire,
        nrBaterii: e.nrBaterii,
        stocareKwh: e.stocareKwh,
        productieSpecifica: e.productieSpecifica,
        productieAnualaKwh: e.productieAnualaKwh,
        productieLunaraKwh: e.productieLunaraKwh,
        fractieAutoconsum: e.fractieAutoconsum,
        energieAutoconsumataKwh: e.energieAutoconsumataKwh,
        energieInjectataKwh: e.energieInjectataKwh,
        economieAnualaRon: e.economieAnualaRon,
        regimProsumator: e.regimProsumator,
        verdicte: [
          for (final v in e.verdicte)
            VerdictSnapshot(
              cod: v.cod,
              titlu: v.titlu,
              nivel: v.nivel.name,
              detaliu: v.detaliu,
              referinta: v.referinta,
            ),
        ],
        limitari: e.limitari,
        materiale: [
          for (final l in n.materiale)
            LinieSnapshot(
              categorie: l.categorie.eticheta,
              denumire: l.denumire,
              cantitate: l.cantitate,
              um: l.um,
              pretUnitarRon: l.pretUnitarRon,
              nota: l.nota,
            ),
        ],
        manopera: [
          for (final l in n.manopera)
            LinieSnapshot(
              categorie: 'Manoperă',
              denumire: l.denumire,
              cantitate: l.cantitate,
              um: l.um,
              pretUnitarRon: l.pretUnitarRon,
            ),
        ],
        sectiuneAcMm2: n.sectiuneAcMm2,
        disjunctorAcA: n.disjunctorAcA,
        tipDdr: n.tipDdr,
      );

  Map<String, dynamic> toJson() => {
    'kWp': kWp,
    'nrModule': nrModule,
    'modul': modul,
    'ns': ns,
    'nrStringuri': nrStringuri,
    'vocTmin': vocTmin,
    'vmpTmax': vmpTmax,
    'invertor': invertor,
    'tipInvertor': tipInvertor,
    'faze': faze,
    'pAcKw': pAcKw,
    'baterie': baterie,
    'nrBaterii': nrBaterii,
    'stocareKwh': stocareKwh,
    'productieSpecifica': productieSpecifica,
    'productieAnualaKwh': productieAnualaKwh,
    'productieLunaraKwh': productieLunaraKwh,
    'fractieAutoconsum': fractieAutoconsum,
    'energieAutoconsumataKwh': energieAutoconsumataKwh,
    'energieInjectataKwh': energieInjectataKwh,
    'economieAnualaRon': economieAnualaRon,
    'regimProsumator': regimProsumator,
    'verdicte': verdicte.map((v) => v.toJson()).toList(),
    'limitari': limitari,
    'materiale': materiale.map((l) => l.toJson()).toList(),
    'manopera': manopera.map((l) => l.toJson()).toList(),
    'sectiuneAcMm2': sectiuneAcMm2,
    'disjunctorAcA': disjunctorAcA,
    'tipDdr': tipDdr,
  };

  factory RezultatSolutie.fromJson(Map<String, dynamic> j) => RezultatSolutie(
    kWp: (j['kWp'] as num).toDouble(),
    nrModule: j['nrModule'] as int,
    modul: j['modul'] as String,
    ns: j['ns'] as int,
    nrStringuri: j['nrStringuri'] as int,
    vocTmin: (j['vocTmin'] as num).toDouble(),
    vmpTmax: (j['vmpTmax'] as num).toDouble(),
    invertor: j['invertor'] as String,
    tipInvertor: j['tipInvertor'] as String,
    faze: j['faze'] as int,
    pAcKw: (j['pAcKw'] as num).toDouble(),
    baterie: j['baterie'] as String?,
    nrBaterii: j['nrBaterii'] as int,
    stocareKwh: (j['stocareKwh'] as num).toDouble(),
    productieSpecifica: (j['productieSpecifica'] as num).toDouble(),
    productieAnualaKwh: (j['productieAnualaKwh'] as num).toDouble(),
    productieLunaraKwh: (j['productieLunaraKwh'] as List<dynamic>)
        .map((x) => (x as num).toDouble())
        .toList(),
    fractieAutoconsum: (j['fractieAutoconsum'] as num).toDouble(),
    energieAutoconsumataKwh: (j['energieAutoconsumataKwh'] as num).toDouble(),
    energieInjectataKwh: (j['energieInjectataKwh'] as num).toDouble(),
    economieAnualaRon: (j['economieAnualaRon'] as num).toDouble(),
    regimProsumator: j['regimProsumator'] as String,
    verdicte: (j['verdicte'] as List<dynamic>)
        .map((x) => VerdictSnapshot.fromJson(x as Map<String, dynamic>))
        .toList(),
    limitari: (j['limitari'] as List<dynamic>).cast<String>(),
    materiale: (j['materiale'] as List<dynamic>)
        .map((x) => LinieSnapshot.fromJson(x as Map<String, dynamic>))
        .toList(),
    manopera: (j['manopera'] as List<dynamic>)
        .map((x) => LinieSnapshot.fromJson(x as Map<String, dynamic>))
        .toList(),
    sectiuneAcMm2: (j['sectiuneAcMm2'] as num).toDouble(),
    disjunctorAcA: j['disjunctorAcA'] as int,
    tipDdr: j['tipDdr'] as String,
  );

  String encode() => jsonEncode(toJson());
  static RezultatSolutie decode(String s) =>
      RezultatSolutie.fromJson(jsonDecode(s) as Map<String, dynamic>);
}

/// Tipurile de documente emise dintr-o soluție.
enum TipDocument {
  fisaSistem('fisa_sistem', 'Fișa sistemului fotovoltaic'),
  ofertaMateriale('oferta_materiale', 'Ofertă materiale'),
  ofertaManopera('oferta_manopera', 'Ofertă manoperă'),
  ofertaCompleta('oferta_completa', 'Ofertă completă (materiale + manoperă)');

  const TipDocument(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static TipDocument dinCod(String? cod) =>
      values.firstWhere((t) => t.cod == cod, orElse: () => fisaSistem);
}
