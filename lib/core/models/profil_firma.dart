/// Profilul firmei executante și al electricianului semnatar — datele care
/// apar pe documentele emise (§6.2 A). Persistat în tabela `setari` sub
/// chei cu prefixul `firma.` / `electrician.`.
class ProfilFirma {
  final String denumire;
  final String cui;
  final String regCom;
  final String adresa;
  final String telefon;
  final String email;
  final String atestatTip; // ex. "B", "Bi", "C1A+C2A"
  final String atestatNr;
  final String atestatValabil; // dd.MM.yyyy, text liber
  final String electricianNume;
  final String electricianGrad; // ex. "IIB", "IIIA"
  final String electricianLegitimatie;
  final String electricianValabil;

  const ProfilFirma({
    this.denumire = '',
    this.cui = '',
    this.regCom = '',
    this.adresa = '',
    this.telefon = '',
    this.email = '',
    this.atestatTip = '',
    this.atestatNr = '',
    this.atestatValabil = '',
    this.electricianNume = '',
    this.electricianGrad = '',
    this.electricianLegitimatie = '',
    this.electricianValabil = '',
  });

  bool get esteCompletat => denumire.isNotEmpty || electricianNume.isNotEmpty;

  Map<String, String> toMap() => {
    'firma.denumire': denumire,
    'firma.cui': cui,
    'firma.regCom': regCom,
    'firma.adresa': adresa,
    'firma.telefon': telefon,
    'firma.email': email,
    'firma.atestatTip': atestatTip,
    'firma.atestatNr': atestatNr,
    'firma.atestatValabil': atestatValabil,
    'electrician.nume': electricianNume,
    'electrician.grad': electricianGrad,
    'electrician.legitimatie': electricianLegitimatie,
    'electrician.valabil': electricianValabil,
  };

  factory ProfilFirma.fromMap(Map<String, String> m) => ProfilFirma(
    denumire: m['firma.denumire'] ?? '',
    cui: m['firma.cui'] ?? '',
    regCom: m['firma.regCom'] ?? '',
    adresa: m['firma.adresa'] ?? '',
    telefon: m['firma.telefon'] ?? '',
    email: m['firma.email'] ?? '',
    atestatTip: m['firma.atestatTip'] ?? '',
    atestatNr: m['firma.atestatNr'] ?? '',
    atestatValabil: m['firma.atestatValabil'] ?? '',
    electricianNume: m['electrician.nume'] ?? '',
    electricianGrad: m['electrician.grad'] ?? '',
    electricianLegitimatie: m['electrician.legitimatie'] ?? '',
    electricianValabil: m['electrician.valabil'] ?? '',
  );

  ProfilFirma copyWith({
    String? denumire,
    String? cui,
    String? regCom,
    String? adresa,
    String? telefon,
    String? email,
    String? atestatTip,
    String? atestatNr,
    String? atestatValabil,
    String? electricianNume,
    String? electricianGrad,
    String? electricianLegitimatie,
    String? electricianValabil,
  }) => ProfilFirma(
    denumire: denumire ?? this.denumire,
    cui: cui ?? this.cui,
    regCom: regCom ?? this.regCom,
    adresa: adresa ?? this.adresa,
    telefon: telefon ?? this.telefon,
    email: email ?? this.email,
    atestatTip: atestatTip ?? this.atestatTip,
    atestatNr: atestatNr ?? this.atestatNr,
    atestatValabil: atestatValabil ?? this.atestatValabil,
    electricianNume: electricianNume ?? this.electricianNume,
    electricianGrad: electricianGrad ?? this.electricianGrad,
    electricianLegitimatie:
        electricianLegitimatie ?? this.electricianLegitimatie,
    electricianValabil: electricianValabil ?? this.electricianValabil,
  );
}
