/// Vocabularul de domeniu al fișei de lucrare (vezi docs/CERCETARE.md §6).
/// Valorile `cod` sunt cele persistate în baza de date — nu se redenumesc.
library;

enum TipClient {
  persoanaFizica('pf', 'Persoană fizică'),
  persoanaJuridica('pj', 'Persoană juridică'),
  asociatie('asociatie', 'Asociație'),
  institutie('institutie', 'Instituție publică');

  const TipClient(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static TipClient dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => persoanaFizica);
}

enum RolClient {
  proprietar('proprietar', 'Proprietar'),
  chirias('chirias', 'Chiriaș'),
  imputernicit('imputernicit', 'Împuternicit');

  const RolClient(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static RolClient dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => proprietar);
}

enum TipLucrare {
  instalareNoua('instalare_noua', 'Instalare nouă'),
  extindere('extindere', 'Extindere putere'),
  adaugareStocare('adaugare_stocare', 'Adăugare stocare'),
  service('service', 'Service / depanare'),
  revizie('revizie', 'Revizie periodică'),
  expertiza('expertiza', 'Expertiză instalație existentă');

  const TipLucrare(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static TipLucrare dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => instalareNoua);
}

/// Fluxul de stări al unei fișe de lucrare. Ordinea enumerării este ordinea
/// naturală a fluxului; `urmatoare` definește tranzițiile permise.
enum StareLucrare {
  lead('lead', 'Lead'),
  releveu('releveu', 'Releveu'),
  dimensionare('dimensionare', 'Dimensionare'),
  oferta('oferta', 'Ofertă'),
  atr('atr', 'ATR'),
  executie('executie', 'Execuție'),
  pif('pif', 'PIF / Recepție'),
  certificat('certificat', 'Certificat de racordare'),
  exploatare('exploatare', 'Exploatare'),
  arhivat('arhivat', 'Arhivat'),
  anulat('anulat', 'Anulat');

  const StareLucrare(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static StareLucrare dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => lead);

  bool get esteActiva => this != arhivat && this != anulat;

  /// Tranzițiile permise din starea curentă: pasul următor din flux, un pas
  /// înapoi (corecție), plus arhivare/anulare din orice stare activă.
  List<StareLucrare> get urmatoare {
    if (!esteActiva) return const [];
    final flux = values.where((s) => s.esteActiva).toList();
    final idx = flux.indexOf(this);
    return [
      if (idx + 1 < flux.length) flux[idx + 1],
      if (idx > 0) flux[idx - 1],
      arhivat,
      anulat,
    ];
  }
}

enum OperatorDistributie {
  ppc('ppc', 'PPC Rețele Electrice (fost E-Distribuție)'),
  deer('deer', 'DEER — Distribuție Energie Electrică România (Electrica)'),
  delgaz('delgaz', 'Delgaz Grid'),
  oltenia('oltenia', 'Distribuție Oltenia'),
  altul('altul', 'Alt operator');

  const OperatorDistributie(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static OperatorDistributie dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => altul);
}

enum TipBransament {
  monofazat('mono', 'Monofazat'),
  trifazat('tri', 'Trifazat');

  const TipBransament(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static TipBransament dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => monofazat);
}

enum NivelTensiune {
  jt('jt', 'JT — 0,4 kV'),
  mt('mt', 'MT — 6–20 kV'),
  it('it', 'ÎT — 110 kV');

  const NivelTensiune(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static NivelTensiune dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => jt);
}

enum SchemaLegarePamant {
  necunoscuta('necunoscuta', 'Necunoscută'),
  tnC('tn_c', 'TN-C'),
  tnCS('tn_c_s', 'TN-C-S'),
  tnS('tn_s', 'TN-S'),
  tt('tt', 'TT'),
  it('it', 'IT');

  const SchemaLegarePamant(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static SchemaLegarePamant dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => necunoscuta);
}

enum TipContor {
  necunoscut('necunoscut', 'Necunoscut'),
  electromecanic('electromecanic', 'Electromecanic'),
  electronic('electronic', 'Electronic'),
  smart('smart', 'Smart (telecitire)');

  const TipContor(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static TipContor dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => necunoscut);
}

enum DestinatieCladire {
  rezidential('rezidential', 'Rezidențial'),
  comercial('comercial', 'Comercial'),
  industrial('industrial', 'Industrial'),
  agricol('agricol', 'Agricol'),
  public('public', 'Public / instituție');

  const DestinatieCladire(this.cod, this.eticheta);
  final String cod;
  final String eticheta;

  static DestinatieCladire dinCod(String? cod) =>
      values.firstWhere((e) => e.cod == cod, orElse: () => rezidential);
}
