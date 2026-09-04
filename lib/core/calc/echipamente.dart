/// Modelele de echipamente folosite de motorul de calcul (E1) și catalogul
/// implicit, orientativ — valorile de fișă tehnică se verifică întotdeauna cu
/// documentația producătorului (docs/CERCETARE.md §3.2).
library;

enum TipInvertor {
  string('string', 'Invertor string (on-grid)'),
  hibrid('hibrid', 'Invertor hibrid (cu stocare)'),
  micro('micro', 'Microinvertor');

  const TipInvertor(this.cod, this.eticheta);
  final String cod;
  final String eticheta;
}

/// Modul fotovoltaic — parametrii STC din fișa tehnică.
class ModulPV {
  final String producator;
  final String model;
  final double pmaxW;
  final double vocV;
  final double iscA;
  final double vmpV;
  final double impA;

  /// Coeficienți de temperatură, %/K (β Voc și γ Pmax sunt negativi).
  final double betaVocPctK;
  final double gammaPmaxPctK;
  final double alfaIscPctK;
  final double noctC;
  final double lungimeMm;
  final double latimeMm;
  final double greutateKg;

  /// Curentul maxim al siguranței în serie (IEC 62548 cl. 7.5).
  final double sigurantaMaxA;
  final double tensiuneSistemMaxV;
  final double pretRon;

  const ModulPV({
    required this.producator,
    required this.model,
    required this.pmaxW,
    required this.vocV,
    required this.iscA,
    required this.vmpV,
    required this.impA,
    this.betaVocPctK = -0.26,
    this.gammaPmaxPctK = -0.30,
    this.alfaIscPctK = 0.045,
    this.noctC = 45,
    this.lungimeMm = 1762,
    this.latimeMm = 1134,
    this.greutateKg = 21.5,
    this.sigurantaMaxA = 25,
    this.tensiuneSistemMaxV = 1500,
    this.pretRon = 450,
  });

  String get denumire => '$producator $model';
  double get suprafataM2 => lungimeMm * latimeMm / 1e6;
}

/// Invertor — limitele electrice relevante pentru dimensionarea string-urilor.
class InvertorPV {
  final String producator;
  final String model;
  final TipInvertor tip;
  final int faze; // 1 sau 3
  final double pAcNomKw;
  final double pDcMaxKw;
  final double vDcMaxV;
  final double vMpptMinV;
  final double vMpptMaxV;
  final double vStartV;
  final int nrMppt;
  final int stringuriPerMppt;
  final double iMpptMaxA;
  final double iScMaxA;

  /// Doar la hibride: puterea maximă de încărcare/descărcare și clasa bateriei.
  final double pBaterieMaxKw;
  final bool baterieHv;
  final double pretRon;

  const InvertorPV({
    required this.producator,
    required this.model,
    required this.tip,
    required this.faze,
    required this.pAcNomKw,
    required this.pDcMaxKw,
    required this.vDcMaxV,
    required this.vMpptMinV,
    required this.vMpptMaxV,
    required this.vStartV,
    required this.nrMppt,
    required this.stringuriPerMppt,
    required this.iMpptMaxA,
    required this.iScMaxA,
    this.pBaterieMaxKw = 0,
    this.baterieHv = false,
    this.pretRon = 5000,
  });

  String get denumire => '$producator $model';
  bool get esteHibrid => tip == TipInvertor.hibrid;
  int get stringuriMax => nrMppt * stringuriPerMppt;
}

/// Modul de baterie LFP.
class BateriePV {
  final String producator;
  final String model;
  final double capacitateKwh;
  final double dod; // 0..1
  final double randamentRt; // dus-întors
  final double pMaxKw;
  final bool hv;
  final int cicluri;
  final double pretRon;

  const BateriePV({
    required this.producator,
    required this.model,
    required this.capacitateKwh,
    this.dod = 0.9,
    this.randamentRt = 0.92,
    this.pMaxKw = 2.5,
    this.hv = false,
    this.cicluri = 6000,
    this.pretRon = 8500,
  });

  String get denumire => '$producator $model';
  double get utilizabilaKwh => capacitateKwh * dod;
}

/// Catalog implicit (E1). Valori tipice 2025–2026, orientative; catalogul
/// editabil vine în E4.
class CatalogImplicit {
  CatalogImplicit._();

  static const module = <ModulPV>[
    ModulPV(
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
    ModulPV(
      producator: 'LONGi',
      model: 'Hi-MO 6 430 W (108 cel.)',
      pmaxW: 430,
      vocV: 38.9,
      iscA: 14.0,
      vmpV: 32.6,
      impA: 13.2,
      betaVocPctK: -0.23,
      gammaPmaxPctK: -0.29,
      pretRon: 440,
    ),
    ModulPV(
      producator: 'Trina',
      model: 'Vertex S+ 450 W (N-type, 108 cel.)',
      pmaxW: 450,
      vocV: 40.1,
      iscA: 14.2,
      vmpV: 33.7,
      impA: 13.4,
      betaVocPctK: -0.22,
      gammaPmaxPctK: -0.29,
      pretRon: 480,
    ),
    ModulPV(
      producator: 'Canadian Solar',
      model: 'HiKu7 590 W (144 cel., comercial)',
      pmaxW: 590,
      vocV: 52.1,
      iscA: 14.3,
      vmpV: 44.0,
      impA: 13.4,
      betaVocPctK: -0.26,
      gammaPmaxPctK: -0.30,
      lungimeMm: 2278,
      greutateKg: 29,
      sigurantaMaxA: 30,
      pretRon: 620,
    ),
  ];

  static const invertoare = <InvertorPV>[
    InvertorPV(
      producator: 'Huawei',
      model: 'SUN2000-3KTL-L1',
      tip: TipInvertor.hibrid,
      faze: 1,
      pAcNomKw: 3,
      pDcMaxKw: 4.5,
      vDcMaxV: 600,
      vMpptMinV: 90,
      vMpptMaxV: 560,
      vStartV: 100,
      nrMppt: 2,
      stringuriPerMppt: 1,
      iMpptMaxA: 12.5,
      iScMaxA: 18,
      pBaterieMaxKw: 2.5,
      baterieHv: true,
      pretRon: 4800,
    ),
    InvertorPV(
      producator: 'Deye',
      model: 'SUN-5K-SG04LP1-EU',
      tip: TipInvertor.hibrid,
      faze: 1,
      pAcNomKw: 5,
      pDcMaxKw: 6.5,
      vDcMaxV: 500,
      vMpptMinV: 125,
      vMpptMaxV: 425,
      vStartV: 125,
      nrMppt: 2,
      stringuriPerMppt: 1,
      iMpptMaxA: 13,
      iScMaxA: 17,
      pBaterieMaxKw: 5,
      baterieHv: false,
      pretRon: 6200,
    ),
    InvertorPV(
      producator: 'Fronius',
      model: 'Primo GEN24 5.0 (mono)',
      tip: TipInvertor.string,
      faze: 1,
      pAcNomKw: 5,
      pDcMaxKw: 7.5,
      vDcMaxV: 600,
      vMpptMinV: 65,
      vMpptMaxV: 530,
      vStartV: 80,
      nrMppt: 2,
      stringuriPerMppt: 2,
      iMpptMaxA: 22,
      iScMaxA: 33,
      pretRon: 7900,
    ),
    InvertorPV(
      producator: 'Huawei',
      model: 'SUN2000-10KTL-M1',
      tip: TipInvertor.string,
      faze: 3,
      pAcNomKw: 10,
      pDcMaxKw: 15,
      vDcMaxV: 1100,
      vMpptMinV: 160,
      vMpptMaxV: 950,
      vStartV: 200,
      nrMppt: 2,
      stringuriPerMppt: 2,
      iMpptMaxA: 22,
      iScMaxA: 30,
      pretRon: 7200,
    ),
    InvertorPV(
      producator: 'Deye',
      model: 'SUN-10K-SG04LP3-EU (tri)',
      tip: TipInvertor.hibrid,
      faze: 3,
      pAcNomKw: 10,
      pDcMaxKw: 13,
      vDcMaxV: 800,
      vMpptMinV: 160,
      vMpptMaxV: 650,
      vStartV: 160,
      nrMppt: 2,
      stringuriPerMppt: 2,
      iMpptMaxA: 26,
      iScMaxA: 34,
      pBaterieMaxKw: 10,
      baterieHv: false,
      pretRon: 11500,
    ),
    InvertorPV(
      producator: 'Huawei',
      model: 'SUN2000-20KTL-M2',
      tip: TipInvertor.string,
      faze: 3,
      pAcNomKw: 20,
      pDcMaxKw: 30,
      vDcMaxV: 1100,
      vMpptMinV: 160,
      vMpptMaxV: 950,
      vStartV: 200,
      nrMppt: 2,
      stringuriPerMppt: 2,
      iMpptMaxA: 30,
      iScMaxA: 40,
      pretRon: 10500,
    ),
    InvertorPV(
      producator: 'Sungrow',
      model: 'SG50CX-P2',
      tip: TipInvertor.string,
      faze: 3,
      pAcNomKw: 50,
      pDcMaxKw: 75,
      vDcMaxV: 1100,
      vMpptMinV: 200,
      vMpptMaxV: 1000,
      vStartV: 250,
      nrMppt: 5,
      stringuriPerMppt: 2,
      iMpptMaxA: 30,
      iScMaxA: 50,
      pretRon: 24000,
    ),
  ];

  static const baterii = <BateriePV>[
    BateriePV(
      producator: 'Pylontech',
      model: 'US5000 (48 V, 4,8 kWh)',
      capacitateKwh: 4.8,
      dod: 0.95,
      pMaxKw: 2.4,
      pretRon: 7900,
    ),
    BateriePV(
      producator: 'Deye',
      model: 'SE-G5.1 Pro (48 V, 5,12 kWh)',
      capacitateKwh: 5.12,
      dod: 0.9,
      pMaxKw: 5.0,
      pretRon: 7500,
    ),
    BateriePV(
      producator: 'Huawei',
      model: 'LUNA2000-5-E0 (HV, 5 kWh)',
      capacitateKwh: 5,
      dod: 1.0,
      pMaxKw: 2.5,
      hv: true,
      pretRon: 10500,
    ),
  ];
}
