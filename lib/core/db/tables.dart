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
  TextColumn get reprezentantLegal =>
      text().withDefault(const Constant(''))();
  TextColumn get furnizorEnergie => text().withDefault(const Constant(''))();
  TextColumn get codClientFurnizor =>
      text().withDefault(const Constant(''))();
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

/// Setări cheie-valoare (profil firmă, preferințe), ca în ElectroCalc.
class Setari extends Table {
  TextColumn get cheie => text()();
  TextColumn get valoare => text()();

  @override
  Set<Column> get primaryKey => {cheie};
}
