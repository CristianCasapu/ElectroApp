import 'package:drift/drift.dart';

/// Coloanele comune tuturor entităților (docs/CERCETARE.md §6.4): identificator
/// UUID, audit temporal, ștergere logică și versiune pentru sincronizare.
mixin EntitateComuna on Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
  IntColumn get version => integer().withDefault(const Constant(1))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Beneficiarul lucrării (§6.2 B). CNP-ul nu se stochează.
class Clienti extends Table with EntitateComuna {
  TextColumn get tip => text()(); // TipClient.cod
  TextColumn get denumire => text()();
  TextColumn get telefon => text().withDefault(const Constant(''))();
  TextColumn get email => text().withDefault(const Constant(''))();
  TextColumn get adresaCorespondenta =>
      text().withDefault(const Constant(''))();
  TextColumn get cui => text().withDefault(const Constant(''))();
  TextColumn get regCom => text().withDefault(const Constant(''))();
  TextColumn get reprezentantLegal => text().withDefault(const Constant(''))();
  TextColumn get furnizorEnergie => text().withDefault(const Constant(''))();
  TextColumn get codClientFurnizor => text().withDefault(const Constant(''))();
  // v2: POD-ul locului de consum principal al clientului (dacă îl știe)
  TextColumn get codPod => text().withDefault(const Constant(''))();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Fișa de lucrare (§6.2 A).
class Lucrari extends Table with EntitateComuna {
  TextColumn get nrInregistrare => text().unique()();
  TextColumn get clientId => text().references(Clienti, #id)();
  TextColumn get rolClient => text()(); // RolClient.cod
  TextColumn get tipLucrare => text()(); // TipLucrare.cod
  TextColumn get stare => text()(); // StareLucrare.cod
  TextColumn get titlu => text().withDefault(const Constant(''))();
  TextColumn get observatii => text().withDefault(const Constant(''))();
  DateTimeColumn get deschisaLa => dateTime()();
}

/// Jurnalul tranzițiilor de stare (audit, append-only).
class LucrariStari extends Table {
  TextColumn get id => text()();
  TextColumn get lucrareId => text().references(Lucrari, #id)();
  TextColumn get stareDin => text().nullable()();
  TextColumn get stareIn => text()();
  DateTimeColumn get la => dateTime()();
  TextColumn get deCatre => text().withDefault(const Constant(''))();
  TextColumn get observatie => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Locul de consum și amplasamentul (§6.2 C). O fișă are exact un loc de consum.
class LocuriConsum extends Table with EntitateComuna {
  TextColumn get lucrareId => text().references(Lucrari, #id).unique()();
  TextColumn get adresa => text().withDefault(const Constant(''))();
  TextColumn get judet => text().withDefault(const Constant(''))();
  TextColumn get localitate => text().withDefault(const Constant(''))();
  RealColumn get lat => real().nullable()();
  RealColumn get lon => real().nullable()();
  TextColumn get operatorDistributie => text()(); // OperatorDistributie.cod
  TextColumn get codPod => text().withDefault(const Constant(''))();
  // v2: furnizorul și codul de client sunt ale locului de consum, nu ale
  // persoanei — un client poate avea mai multe locuri, cu furnizori diferiți
  TextColumn get furnizorEnergie => text().withDefault(const Constant(''))();
  TextColumn get codClientFurnizor => text().withDefault(const Constant(''))();
  TextColumn get nivelTensiune => text()(); // NivelTensiune.cod
  TextColumn get bransament => text()(); // TipBransament.cod
  RealColumn get putereAprobataKva => real().nullable()();
  RealColumn get putereContractataKw => real().nullable()();
  IntColumn get disjunctorGeneralA => integer().nullable()();
  TextColumn get schemaLegarePamant => text()(); // SchemaLegarePamant.cod
  BoolColumn get prizaPamantProprie =>
      boolean().withDefault(const Constant(false))();
  TextColumn get contorTip => text()(); // TipContor.cod
  TextColumn get contorSerie => text().withDefault(const Constant(''))();
  BoolColumn get contorBidirectional =>
      boolean().withDefault(const Constant(false))();
  TextColumn get destinatieCladire => text()(); // DestinatieCladire.cod
  IntColumn get anConstructie => integer().nullable()();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Furnizorii de energie (v2): lista predefinită a marilor furnizori din
/// România plus cei adăugați de utilizator. Valoarea specială pentru
/// consumatorii fără racord este [furnizorOffGrid].
class Furnizori extends Table {
  TextColumn get id => text()();
  TextColumn get denumire => text().unique()();
  BoolColumn get predefinit => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get deletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

const furnizorOffGrid = 'Off-grid (fără racord la rețea)';

/// Marii furnizori de energie electrică din România (2026). Se inserează o
/// singură dată; utilizatorul poate adăuga alții.
const furnizoriPredefiniti = [
  'Hidroelectrica',
  'PPC Energie (fost Enel Energie)',
  'PPC Energie Muntenia',
  'Electrica Furnizare',
  'E.ON Energie România',
  'Engie România',
  'Premier Energy (fost CEZ Vânzare)',
  'Tinmar Energy',
  'Restart Energy',
  'Nova Power & Gas',
  'MET România Energy',
  'CIGA Energy',
];

/// Soluția tehnică adoptată (§6.2 F), pe revizii imutabile (R1, R2, …): datele
/// de intrare și rezultatul estimării se păstrează ca JSON, ca documentele
/// emise dintr-o revizie să poată fi regenerate identic mai târziu.
class Solutii extends Table {
  TextColumn get id => text()();
  TextColumn get lucrareId => text().references(Lucrari, #id)();
  IntColumn get revizie => integer()();
  DateTimeColumn get creataLa => dateTime()();
  TextColumn get intrariJson => text()();
  TextColumn get rezultatJson => text()();
  TextColumn get observatii => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Documentele emise (§6.2 H): imutabile, cu versiune, hash și cale locală.
class Documente extends Table {
  TextColumn get id => text()();
  TextColumn get lucrareId => text().references(Lucrari, #id)();
  TextColumn get solutieId => text().nullable()();
  TextColumn get tip => text()(); // TipDocument.cod
  IntColumn get versiune => integer()();
  DateTimeColumn get emisLa => dateTime()();
  TextColumn get cale => text()();
  TextColumn get sha256 => text()();
  IntColumn get marimeBytes => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Releveul tehnic de șantier (§6.2 D): o fișă are cel mult un releveu, cu
/// planele de montaj, obstacolele, tabloul existent și traseele lui.
class Relevee extends Table with EntitateComuna {
  TextColumn get lucrareId => text().references(Lucrari, #id).unique()();
  DateTimeColumn get data => dateTime()();
  TextColumn get operator => text().withDefault(const Constant(''))();
  RealColumn get temperaturaAmbientaC => real().nullable()();
  // zonele climatice din CR 1-1-3 (zăpadă, kN/m²) și CR 1-1-4 (vânt, kPa)
  RealColumn get zapadaSkKnM2 => real().nullable()();
  RealColumn get vantQbKpa => real().nullable()();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Un plan de montaj: acoperiș înclinat, terasă, fațadă, sol sau carport.
class PlaneMontaj extends Table with EntitateComuna {
  TextColumn get releveuId => text().references(Relevee, #id)();
  TextColumn get denumire => text()();
  TextColumn get tip => text()(); // TipPlanMontaj.cod
  TextColumn get invelitoare => text()(); // TipInvelitoare.cod
  RealColumn get inclinareGrade => real().withDefault(const Constant(30))();
  RealColumn get azimutGrade => real().withDefault(const Constant(0))();
  RealColumn get lungimeM => real().withDefault(const Constant(0))();
  RealColumn get latimeM => real().withDefault(const Constant(0))();
  RealColumn get inaltimeStreasinaM => real().nullable()();
  // structura de rezistență: secțiunea căpriorilor și distanța dintre ei
  TextColumn get capriorSectiune => text().withDefault(const Constant(''))();
  RealColumn get capriorInteraxCm => real().nullable()();
  TextColumn get stare => text()(); // StarePlan.cod
  RealColumn get factorUmbrire => real().withDefault(const Constant(1))();
  TextColumn get observatii => text().withDefault(const Constant(''))();
  IntColumn get ordine => integer().withDefault(const Constant(0))();
}

/// Obstacol pe un plan (coș, aerisire, luminator) sau umbrire din exterior.
class Obstacole extends Table with EntitateComuna {
  TextColumn get planId => text().references(PlaneMontaj, #id)();
  TextColumn get tip => text()(); // TipObstacol.cod
  RealColumn get inaltimeM => real().withDefault(const Constant(0))();
  RealColumn get distantaM => real().withDefault(const Constant(0))();
  RealColumn get azimutGrade => real().nullable()();
  RealColumn get latimeM => real().nullable()();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Tabloul electric general găsit pe teren (§6.2 D).
class TablouriExistente extends Table with EntitateComuna {
  TextColumn get releveuId => text().references(Relevee, #id).unique()();
  IntColumn get pozitiiLibere => integer().nullable()();
  IntColumn get disjunctorGeneralA => integer().nullable()();
  TextColumn get disjunctorCurba => text().withDefault(const Constant(''))();
  RealColumn get icuKa => real().nullable()();
  TextColumn get ddrExistent => text()(); // TipDdr.cod
  IntColumn get ddrIdnMa => integer().nullable()();
  BoolColumn get spdExistent => boolean().withDefault(const Constant(false))();
  BoolColumn get baraPeSeparata =>
      boolean().withDefault(const Constant(false))();
  RealColumn get sectiuneColoanaMm2 => real().nullable()();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Traseele de cablu măsurate pe teren (DC, AC, până la contor).
class Trasee extends Table with EntitateComuna {
  TextColumn get releveuId => text().references(Relevee, #id)();
  TextColumn get segment => text()(); // SegmentTraseu.cod
  RealColumn get lungimeM => real().withDefault(const Constant(0))();
  TextColumn get modPozare => text().withDefault(const Constant('B1'))();
  RealColumn get temperaturaMaximaC => real().nullable()();
  TextColumn get observatii => text().withDefault(const Constant(''))();
}

/// Setări cheie-valoare (profil firmă, preferințe), ca în ElectroCalc.
class Setari extends Table {
  TextColumn get cheie => text()();
  TextColumn get valoare => text()();

  @override
  Set<Column> get primaryKey => {cheie};
}
