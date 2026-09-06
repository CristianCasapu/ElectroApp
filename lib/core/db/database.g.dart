// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientiTable extends Clienti with TableInfo<$ClientiTable, ClientiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _denumireMeta = const VerificationMeta(
    'denumire',
  );
  @override
  late final GeneratedColumn<String> denumire = GeneratedColumn<String>(
    'denumire',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonMeta = const VerificationMeta(
    'telefon',
  );
  @override
  late final GeneratedColumn<String> telefon = GeneratedColumn<String>(
    'telefon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _adresaCorespondentaMeta =
      const VerificationMeta('adresaCorespondenta');
  @override
  late final GeneratedColumn<String> adresaCorespondenta =
      GeneratedColumn<String>(
        'adresa_corespondenta',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _cuiMeta = const VerificationMeta('cui');
  @override
  late final GeneratedColumn<String> cui = GeneratedColumn<String>(
    'cui',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _regComMeta = const VerificationMeta('regCom');
  @override
  late final GeneratedColumn<String> regCom = GeneratedColumn<String>(
    'reg_com',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _reprezentantLegalMeta = const VerificationMeta(
    'reprezentantLegal',
  );
  @override
  late final GeneratedColumn<String> reprezentantLegal =
      GeneratedColumn<String>(
        'reprezentant_legal',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _furnizorEnergieMeta = const VerificationMeta(
    'furnizorEnergie',
  );
  @override
  late final GeneratedColumn<String> furnizorEnergie = GeneratedColumn<String>(
    'furnizor_energie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _codClientFurnizorMeta = const VerificationMeta(
    'codClientFurnizor',
  );
  @override
  late final GeneratedColumn<String> codClientFurnizor =
      GeneratedColumn<String>(
        'cod_client_furnizor',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _codPodMeta = const VerificationMeta('codPod');
  @override
  late final GeneratedColumn<String> codPod = GeneratedColumn<String>(
    'cod_pod',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    tip,
    denumire,
    telefon,
    email,
    adresaCorespondenta,
    cui,
    regCom,
    reprezentantLegal,
    furnizorEnergie,
    codClientFurnizor,
    codPod,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clienti';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClientiData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('denumire')) {
      context.handle(
        _denumireMeta,
        denumire.isAcceptableOrUnknown(data['denumire']!, _denumireMeta),
      );
    } else if (isInserting) {
      context.missing(_denumireMeta);
    }
    if (data.containsKey('telefon')) {
      context.handle(
        _telefonMeta,
        telefon.isAcceptableOrUnknown(data['telefon']!, _telefonMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('adresa_corespondenta')) {
      context.handle(
        _adresaCorespondentaMeta,
        adresaCorespondenta.isAcceptableOrUnknown(
          data['adresa_corespondenta']!,
          _adresaCorespondentaMeta,
        ),
      );
    }
    if (data.containsKey('cui')) {
      context.handle(
        _cuiMeta,
        cui.isAcceptableOrUnknown(data['cui']!, _cuiMeta),
      );
    }
    if (data.containsKey('reg_com')) {
      context.handle(
        _regComMeta,
        regCom.isAcceptableOrUnknown(data['reg_com']!, _regComMeta),
      );
    }
    if (data.containsKey('reprezentant_legal')) {
      context.handle(
        _reprezentantLegalMeta,
        reprezentantLegal.isAcceptableOrUnknown(
          data['reprezentant_legal']!,
          _reprezentantLegalMeta,
        ),
      );
    }
    if (data.containsKey('furnizor_energie')) {
      context.handle(
        _furnizorEnergieMeta,
        furnizorEnergie.isAcceptableOrUnknown(
          data['furnizor_energie']!,
          _furnizorEnergieMeta,
        ),
      );
    }
    if (data.containsKey('cod_client_furnizor')) {
      context.handle(
        _codClientFurnizorMeta,
        codClientFurnizor.isAcceptableOrUnknown(
          data['cod_client_furnizor']!,
          _codClientFurnizorMeta,
        ),
      );
    }
    if (data.containsKey('cod_pod')) {
      context.handle(
        _codPodMeta,
        codPod.isAcceptableOrUnknown(data['cod_pod']!, _codPodMeta),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ClientiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClientiData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip'],
      )!,
      denumire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}denumire'],
      )!,
      telefon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefon'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      adresaCorespondenta: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adresa_corespondenta'],
      )!,
      cui: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cui'],
      )!,
      regCom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reg_com'],
      )!,
      reprezentantLegal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reprezentant_legal'],
      )!,
      furnizorEnergie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}furnizor_energie'],
      )!,
      codClientFurnizor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cod_client_furnizor'],
      )!,
      codPod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cod_pod'],
      )!,
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $ClientiTable createAlias(String alias) {
    return $ClientiTable(attachedDatabase, alias);
  }
}

class ClientiData extends DataClass implements Insertable<ClientiData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String tip;
  final String denumire;
  final String telefon;
  final String email;
  final String adresaCorespondenta;
  final String cui;
  final String regCom;
  final String reprezentantLegal;
  final String furnizorEnergie;
  final String codClientFurnizor;
  final String codPod;
  final String observatii;
  const ClientiData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.tip,
    required this.denumire,
    required this.telefon,
    required this.email,
    required this.adresaCorespondenta,
    required this.cui,
    required this.regCom,
    required this.reprezentantLegal,
    required this.furnizorEnergie,
    required this.codClientFurnizor,
    required this.codPod,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['tip'] = Variable<String>(tip);
    map['denumire'] = Variable<String>(denumire);
    map['telefon'] = Variable<String>(telefon);
    map['email'] = Variable<String>(email);
    map['adresa_corespondenta'] = Variable<String>(adresaCorespondenta);
    map['cui'] = Variable<String>(cui);
    map['reg_com'] = Variable<String>(regCom);
    map['reprezentant_legal'] = Variable<String>(reprezentantLegal);
    map['furnizor_energie'] = Variable<String>(furnizorEnergie);
    map['cod_client_furnizor'] = Variable<String>(codClientFurnizor);
    map['cod_pod'] = Variable<String>(codPod);
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  ClientiCompanion toCompanion(bool nullToAbsent) {
    return ClientiCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      tip: Value(tip),
      denumire: Value(denumire),
      telefon: Value(telefon),
      email: Value(email),
      adresaCorespondenta: Value(adresaCorespondenta),
      cui: Value(cui),
      regCom: Value(regCom),
      reprezentantLegal: Value(reprezentantLegal),
      furnizorEnergie: Value(furnizorEnergie),
      codClientFurnizor: Value(codClientFurnizor),
      codPod: Value(codPod),
      observatii: Value(observatii),
    );
  }

  factory ClientiData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClientiData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      tip: serializer.fromJson<String>(json['tip']),
      denumire: serializer.fromJson<String>(json['denumire']),
      telefon: serializer.fromJson<String>(json['telefon']),
      email: serializer.fromJson<String>(json['email']),
      adresaCorespondenta: serializer.fromJson<String>(
        json['adresaCorespondenta'],
      ),
      cui: serializer.fromJson<String>(json['cui']),
      regCom: serializer.fromJson<String>(json['regCom']),
      reprezentantLegal: serializer.fromJson<String>(json['reprezentantLegal']),
      furnizorEnergie: serializer.fromJson<String>(json['furnizorEnergie']),
      codClientFurnizor: serializer.fromJson<String>(json['codClientFurnizor']),
      codPod: serializer.fromJson<String>(json['codPod']),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'tip': serializer.toJson<String>(tip),
      'denumire': serializer.toJson<String>(denumire),
      'telefon': serializer.toJson<String>(telefon),
      'email': serializer.toJson<String>(email),
      'adresaCorespondenta': serializer.toJson<String>(adresaCorespondenta),
      'cui': serializer.toJson<String>(cui),
      'regCom': serializer.toJson<String>(regCom),
      'reprezentantLegal': serializer.toJson<String>(reprezentantLegal),
      'furnizorEnergie': serializer.toJson<String>(furnizorEnergie),
      'codClientFurnizor': serializer.toJson<String>(codClientFurnizor),
      'codPod': serializer.toJson<String>(codPod),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  ClientiData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? tip,
    String? denumire,
    String? telefon,
    String? email,
    String? adresaCorespondenta,
    String? cui,
    String? regCom,
    String? reprezentantLegal,
    String? furnizorEnergie,
    String? codClientFurnizor,
    String? codPod,
    String? observatii,
  }) => ClientiData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    tip: tip ?? this.tip,
    denumire: denumire ?? this.denumire,
    telefon: telefon ?? this.telefon,
    email: email ?? this.email,
    adresaCorespondenta: adresaCorespondenta ?? this.adresaCorespondenta,
    cui: cui ?? this.cui,
    regCom: regCom ?? this.regCom,
    reprezentantLegal: reprezentantLegal ?? this.reprezentantLegal,
    furnizorEnergie: furnizorEnergie ?? this.furnizorEnergie,
    codClientFurnizor: codClientFurnizor ?? this.codClientFurnizor,
    codPod: codPod ?? this.codPod,
    observatii: observatii ?? this.observatii,
  );
  ClientiData copyWithCompanion(ClientiCompanion data) {
    return ClientiData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      tip: data.tip.present ? data.tip.value : this.tip,
      denumire: data.denumire.present ? data.denumire.value : this.denumire,
      telefon: data.telefon.present ? data.telefon.value : this.telefon,
      email: data.email.present ? data.email.value : this.email,
      adresaCorespondenta: data.adresaCorespondenta.present
          ? data.adresaCorespondenta.value
          : this.adresaCorespondenta,
      cui: data.cui.present ? data.cui.value : this.cui,
      regCom: data.regCom.present ? data.regCom.value : this.regCom,
      reprezentantLegal: data.reprezentantLegal.present
          ? data.reprezentantLegal.value
          : this.reprezentantLegal,
      furnizorEnergie: data.furnizorEnergie.present
          ? data.furnizorEnergie.value
          : this.furnizorEnergie,
      codClientFurnizor: data.codClientFurnizor.present
          ? data.codClientFurnizor.value
          : this.codClientFurnizor,
      codPod: data.codPod.present ? data.codPod.value : this.codPod,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClientiData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('tip: $tip, ')
          ..write('denumire: $denumire, ')
          ..write('telefon: $telefon, ')
          ..write('email: $email, ')
          ..write('adresaCorespondenta: $adresaCorespondenta, ')
          ..write('cui: $cui, ')
          ..write('regCom: $regCom, ')
          ..write('reprezentantLegal: $reprezentantLegal, ')
          ..write('furnizorEnergie: $furnizorEnergie, ')
          ..write('codClientFurnizor: $codClientFurnizor, ')
          ..write('codPod: $codPod, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    tip,
    denumire,
    telefon,
    email,
    adresaCorespondenta,
    cui,
    regCom,
    reprezentantLegal,
    furnizorEnergie,
    codClientFurnizor,
    codPod,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClientiData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.tip == this.tip &&
          other.denumire == this.denumire &&
          other.telefon == this.telefon &&
          other.email == this.email &&
          other.adresaCorespondenta == this.adresaCorespondenta &&
          other.cui == this.cui &&
          other.regCom == this.regCom &&
          other.reprezentantLegal == this.reprezentantLegal &&
          other.furnizorEnergie == this.furnizorEnergie &&
          other.codClientFurnizor == this.codClientFurnizor &&
          other.codPod == this.codPod &&
          other.observatii == this.observatii);
}

class ClientiCompanion extends UpdateCompanion<ClientiData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> tip;
  final Value<String> denumire;
  final Value<String> telefon;
  final Value<String> email;
  final Value<String> adresaCorespondenta;
  final Value<String> cui;
  final Value<String> regCom;
  final Value<String> reprezentantLegal;
  final Value<String> furnizorEnergie;
  final Value<String> codClientFurnizor;
  final Value<String> codPod;
  final Value<String> observatii;
  final Value<int> rowid;
  const ClientiCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.tip = const Value.absent(),
    this.denumire = const Value.absent(),
    this.telefon = const Value.absent(),
    this.email = const Value.absent(),
    this.adresaCorespondenta = const Value.absent(),
    this.cui = const Value.absent(),
    this.regCom = const Value.absent(),
    this.reprezentantLegal = const Value.absent(),
    this.furnizorEnergie = const Value.absent(),
    this.codClientFurnizor = const Value.absent(),
    this.codPod = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ClientiCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String tip,
    required String denumire,
    this.telefon = const Value.absent(),
    this.email = const Value.absent(),
    this.adresaCorespondenta = const Value.absent(),
    this.cui = const Value.absent(),
    this.regCom = const Value.absent(),
    this.reprezentantLegal = const Value.absent(),
    this.furnizorEnergie = const Value.absent(),
    this.codClientFurnizor = const Value.absent(),
    this.codPod = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       tip = Value(tip),
       denumire = Value(denumire);
  static Insertable<ClientiData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? tip,
    Expression<String>? denumire,
    Expression<String>? telefon,
    Expression<String>? email,
    Expression<String>? adresaCorespondenta,
    Expression<String>? cui,
    Expression<String>? regCom,
    Expression<String>? reprezentantLegal,
    Expression<String>? furnizorEnergie,
    Expression<String>? codClientFurnizor,
    Expression<String>? codPod,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (tip != null) 'tip': tip,
      if (denumire != null) 'denumire': denumire,
      if (telefon != null) 'telefon': telefon,
      if (email != null) 'email': email,
      if (adresaCorespondenta != null)
        'adresa_corespondenta': adresaCorespondenta,
      if (cui != null) 'cui': cui,
      if (regCom != null) 'reg_com': regCom,
      if (reprezentantLegal != null) 'reprezentant_legal': reprezentantLegal,
      if (furnizorEnergie != null) 'furnizor_energie': furnizorEnergie,
      if (codClientFurnizor != null) 'cod_client_furnizor': codClientFurnizor,
      if (codPod != null) 'cod_pod': codPod,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ClientiCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? tip,
    Value<String>? denumire,
    Value<String>? telefon,
    Value<String>? email,
    Value<String>? adresaCorespondenta,
    Value<String>? cui,
    Value<String>? regCom,
    Value<String>? reprezentantLegal,
    Value<String>? furnizorEnergie,
    Value<String>? codClientFurnizor,
    Value<String>? codPod,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return ClientiCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      tip: tip ?? this.tip,
      denumire: denumire ?? this.denumire,
      telefon: telefon ?? this.telefon,
      email: email ?? this.email,
      adresaCorespondenta: adresaCorespondenta ?? this.adresaCorespondenta,
      cui: cui ?? this.cui,
      regCom: regCom ?? this.regCom,
      reprezentantLegal: reprezentantLegal ?? this.reprezentantLegal,
      furnizorEnergie: furnizorEnergie ?? this.furnizorEnergie,
      codClientFurnizor: codClientFurnizor ?? this.codClientFurnizor,
      codPod: codPod ?? this.codPod,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (denumire.present) {
      map['denumire'] = Variable<String>(denumire.value);
    }
    if (telefon.present) {
      map['telefon'] = Variable<String>(telefon.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (adresaCorespondenta.present) {
      map['adresa_corespondenta'] = Variable<String>(adresaCorespondenta.value);
    }
    if (cui.present) {
      map['cui'] = Variable<String>(cui.value);
    }
    if (regCom.present) {
      map['reg_com'] = Variable<String>(regCom.value);
    }
    if (reprezentantLegal.present) {
      map['reprezentant_legal'] = Variable<String>(reprezentantLegal.value);
    }
    if (furnizorEnergie.present) {
      map['furnizor_energie'] = Variable<String>(furnizorEnergie.value);
    }
    if (codClientFurnizor.present) {
      map['cod_client_furnizor'] = Variable<String>(codClientFurnizor.value);
    }
    if (codPod.present) {
      map['cod_pod'] = Variable<String>(codPod.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientiCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('tip: $tip, ')
          ..write('denumire: $denumire, ')
          ..write('telefon: $telefon, ')
          ..write('email: $email, ')
          ..write('adresaCorespondenta: $adresaCorespondenta, ')
          ..write('cui: $cui, ')
          ..write('regCom: $regCom, ')
          ..write('reprezentantLegal: $reprezentantLegal, ')
          ..write('furnizorEnergie: $furnizorEnergie, ')
          ..write('codClientFurnizor: $codClientFurnizor, ')
          ..write('codPod: $codPod, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LucrariTable extends Lucrari with TableInfo<$LucrariTable, LucrariData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LucrariTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _nrInregistrareMeta = const VerificationMeta(
    'nrInregistrare',
  );
  @override
  late final GeneratedColumn<String> nrInregistrare = GeneratedColumn<String>(
    'nr_inregistrare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _clientIdMeta = const VerificationMeta(
    'clientId',
  );
  @override
  late final GeneratedColumn<String> clientId = GeneratedColumn<String>(
    'client_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clienti (id)',
    ),
  );
  static const VerificationMeta _rolClientMeta = const VerificationMeta(
    'rolClient',
  );
  @override
  late final GeneratedColumn<String> rolClient = GeneratedColumn<String>(
    'rol_client',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipLucrareMeta = const VerificationMeta(
    'tipLucrare',
  );
  @override
  late final GeneratedColumn<String> tipLucrare = GeneratedColumn<String>(
    'tip_lucrare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stareMeta = const VerificationMeta('stare');
  @override
  late final GeneratedColumn<String> stare = GeneratedColumn<String>(
    'stare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titluMeta = const VerificationMeta('titlu');
  @override
  late final GeneratedColumn<String> titlu = GeneratedColumn<String>(
    'titlu',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _deschisaLaMeta = const VerificationMeta(
    'deschisaLa',
  );
  @override
  late final GeneratedColumn<DateTime> deschisaLa = GeneratedColumn<DateTime>(
    'deschisa_la',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    nrInregistrare,
    clientId,
    rolClient,
    tipLucrare,
    stare,
    titlu,
    observatii,
    deschisaLa,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lucrari';
  @override
  VerificationContext validateIntegrity(
    Insertable<LucrariData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('nr_inregistrare')) {
      context.handle(
        _nrInregistrareMeta,
        nrInregistrare.isAcceptableOrUnknown(
          data['nr_inregistrare']!,
          _nrInregistrareMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nrInregistrareMeta);
    }
    if (data.containsKey('client_id')) {
      context.handle(
        _clientIdMeta,
        clientId.isAcceptableOrUnknown(data['client_id']!, _clientIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clientIdMeta);
    }
    if (data.containsKey('rol_client')) {
      context.handle(
        _rolClientMeta,
        rolClient.isAcceptableOrUnknown(data['rol_client']!, _rolClientMeta),
      );
    } else if (isInserting) {
      context.missing(_rolClientMeta);
    }
    if (data.containsKey('tip_lucrare')) {
      context.handle(
        _tipLucrareMeta,
        tipLucrare.isAcceptableOrUnknown(data['tip_lucrare']!, _tipLucrareMeta),
      );
    } else if (isInserting) {
      context.missing(_tipLucrareMeta);
    }
    if (data.containsKey('stare')) {
      context.handle(
        _stareMeta,
        stare.isAcceptableOrUnknown(data['stare']!, _stareMeta),
      );
    } else if (isInserting) {
      context.missing(_stareMeta);
    }
    if (data.containsKey('titlu')) {
      context.handle(
        _titluMeta,
        titlu.isAcceptableOrUnknown(data['titlu']!, _titluMeta),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    if (data.containsKey('deschisa_la')) {
      context.handle(
        _deschisaLaMeta,
        deschisaLa.isAcceptableOrUnknown(data['deschisa_la']!, _deschisaLaMeta),
      );
    } else if (isInserting) {
      context.missing(_deschisaLaMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LucrariData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LucrariData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      nrInregistrare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nr_inregistrare'],
      )!,
      clientId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}client_id'],
      )!,
      rolClient: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol_client'],
      )!,
      tipLucrare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip_lucrare'],
      )!,
      stare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stare'],
      )!,
      titlu: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}titlu'],
      )!,
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
      deschisaLa: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deschisa_la'],
      )!,
    );
  }

  @override
  $LucrariTable createAlias(String alias) {
    return $LucrariTable(attachedDatabase, alias);
  }
}

class LucrariData extends DataClass implements Insertable<LucrariData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String nrInregistrare;
  final String clientId;
  final String rolClient;
  final String tipLucrare;
  final String stare;
  final String titlu;
  final String observatii;
  final DateTime deschisaLa;
  const LucrariData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.nrInregistrare,
    required this.clientId,
    required this.rolClient,
    required this.tipLucrare,
    required this.stare,
    required this.titlu,
    required this.observatii,
    required this.deschisaLa,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['nr_inregistrare'] = Variable<String>(nrInregistrare);
    map['client_id'] = Variable<String>(clientId);
    map['rol_client'] = Variable<String>(rolClient);
    map['tip_lucrare'] = Variable<String>(tipLucrare);
    map['stare'] = Variable<String>(stare);
    map['titlu'] = Variable<String>(titlu);
    map['observatii'] = Variable<String>(observatii);
    map['deschisa_la'] = Variable<DateTime>(deschisaLa);
    return map;
  }

  LucrariCompanion toCompanion(bool nullToAbsent) {
    return LucrariCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      nrInregistrare: Value(nrInregistrare),
      clientId: Value(clientId),
      rolClient: Value(rolClient),
      tipLucrare: Value(tipLucrare),
      stare: Value(stare),
      titlu: Value(titlu),
      observatii: Value(observatii),
      deschisaLa: Value(deschisaLa),
    );
  }

  factory LucrariData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LucrariData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      nrInregistrare: serializer.fromJson<String>(json['nrInregistrare']),
      clientId: serializer.fromJson<String>(json['clientId']),
      rolClient: serializer.fromJson<String>(json['rolClient']),
      tipLucrare: serializer.fromJson<String>(json['tipLucrare']),
      stare: serializer.fromJson<String>(json['stare']),
      titlu: serializer.fromJson<String>(json['titlu']),
      observatii: serializer.fromJson<String>(json['observatii']),
      deschisaLa: serializer.fromJson<DateTime>(json['deschisaLa']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'nrInregistrare': serializer.toJson<String>(nrInregistrare),
      'clientId': serializer.toJson<String>(clientId),
      'rolClient': serializer.toJson<String>(rolClient),
      'tipLucrare': serializer.toJson<String>(tipLucrare),
      'stare': serializer.toJson<String>(stare),
      'titlu': serializer.toJson<String>(titlu),
      'observatii': serializer.toJson<String>(observatii),
      'deschisaLa': serializer.toJson<DateTime>(deschisaLa),
    };
  }

  LucrariData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? nrInregistrare,
    String? clientId,
    String? rolClient,
    String? tipLucrare,
    String? stare,
    String? titlu,
    String? observatii,
    DateTime? deschisaLa,
  }) => LucrariData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    nrInregistrare: nrInregistrare ?? this.nrInregistrare,
    clientId: clientId ?? this.clientId,
    rolClient: rolClient ?? this.rolClient,
    tipLucrare: tipLucrare ?? this.tipLucrare,
    stare: stare ?? this.stare,
    titlu: titlu ?? this.titlu,
    observatii: observatii ?? this.observatii,
    deschisaLa: deschisaLa ?? this.deschisaLa,
  );
  LucrariData copyWithCompanion(LucrariCompanion data) {
    return LucrariData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      nrInregistrare: data.nrInregistrare.present
          ? data.nrInregistrare.value
          : this.nrInregistrare,
      clientId: data.clientId.present ? data.clientId.value : this.clientId,
      rolClient: data.rolClient.present ? data.rolClient.value : this.rolClient,
      tipLucrare: data.tipLucrare.present
          ? data.tipLucrare.value
          : this.tipLucrare,
      stare: data.stare.present ? data.stare.value : this.stare,
      titlu: data.titlu.present ? data.titlu.value : this.titlu,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
      deschisaLa: data.deschisaLa.present
          ? data.deschisaLa.value
          : this.deschisaLa,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LucrariData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('nrInregistrare: $nrInregistrare, ')
          ..write('clientId: $clientId, ')
          ..write('rolClient: $rolClient, ')
          ..write('tipLucrare: $tipLucrare, ')
          ..write('stare: $stare, ')
          ..write('titlu: $titlu, ')
          ..write('observatii: $observatii, ')
          ..write('deschisaLa: $deschisaLa')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    nrInregistrare,
    clientId,
    rolClient,
    tipLucrare,
    stare,
    titlu,
    observatii,
    deschisaLa,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LucrariData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.nrInregistrare == this.nrInregistrare &&
          other.clientId == this.clientId &&
          other.rolClient == this.rolClient &&
          other.tipLucrare == this.tipLucrare &&
          other.stare == this.stare &&
          other.titlu == this.titlu &&
          other.observatii == this.observatii &&
          other.deschisaLa == this.deschisaLa);
}

class LucrariCompanion extends UpdateCompanion<LucrariData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> nrInregistrare;
  final Value<String> clientId;
  final Value<String> rolClient;
  final Value<String> tipLucrare;
  final Value<String> stare;
  final Value<String> titlu;
  final Value<String> observatii;
  final Value<DateTime> deschisaLa;
  final Value<int> rowid;
  const LucrariCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.nrInregistrare = const Value.absent(),
    this.clientId = const Value.absent(),
    this.rolClient = const Value.absent(),
    this.tipLucrare = const Value.absent(),
    this.stare = const Value.absent(),
    this.titlu = const Value.absent(),
    this.observatii = const Value.absent(),
    this.deschisaLa = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LucrariCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String nrInregistrare,
    required String clientId,
    required String rolClient,
    required String tipLucrare,
    required String stare,
    this.titlu = const Value.absent(),
    this.observatii = const Value.absent(),
    required DateTime deschisaLa,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       nrInregistrare = Value(nrInregistrare),
       clientId = Value(clientId),
       rolClient = Value(rolClient),
       tipLucrare = Value(tipLucrare),
       stare = Value(stare),
       deschisaLa = Value(deschisaLa);
  static Insertable<LucrariData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? nrInregistrare,
    Expression<String>? clientId,
    Expression<String>? rolClient,
    Expression<String>? tipLucrare,
    Expression<String>? stare,
    Expression<String>? titlu,
    Expression<String>? observatii,
    Expression<DateTime>? deschisaLa,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (nrInregistrare != null) 'nr_inregistrare': nrInregistrare,
      if (clientId != null) 'client_id': clientId,
      if (rolClient != null) 'rol_client': rolClient,
      if (tipLucrare != null) 'tip_lucrare': tipLucrare,
      if (stare != null) 'stare': stare,
      if (titlu != null) 'titlu': titlu,
      if (observatii != null) 'observatii': observatii,
      if (deschisaLa != null) 'deschisa_la': deschisaLa,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LucrariCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? nrInregistrare,
    Value<String>? clientId,
    Value<String>? rolClient,
    Value<String>? tipLucrare,
    Value<String>? stare,
    Value<String>? titlu,
    Value<String>? observatii,
    Value<DateTime>? deschisaLa,
    Value<int>? rowid,
  }) {
    return LucrariCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      nrInregistrare: nrInregistrare ?? this.nrInregistrare,
      clientId: clientId ?? this.clientId,
      rolClient: rolClient ?? this.rolClient,
      tipLucrare: tipLucrare ?? this.tipLucrare,
      stare: stare ?? this.stare,
      titlu: titlu ?? this.titlu,
      observatii: observatii ?? this.observatii,
      deschisaLa: deschisaLa ?? this.deschisaLa,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (nrInregistrare.present) {
      map['nr_inregistrare'] = Variable<String>(nrInregistrare.value);
    }
    if (clientId.present) {
      map['client_id'] = Variable<String>(clientId.value);
    }
    if (rolClient.present) {
      map['rol_client'] = Variable<String>(rolClient.value);
    }
    if (tipLucrare.present) {
      map['tip_lucrare'] = Variable<String>(tipLucrare.value);
    }
    if (stare.present) {
      map['stare'] = Variable<String>(stare.value);
    }
    if (titlu.present) {
      map['titlu'] = Variable<String>(titlu.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (deschisaLa.present) {
      map['deschisa_la'] = Variable<DateTime>(deschisaLa.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LucrariCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('nrInregistrare: $nrInregistrare, ')
          ..write('clientId: $clientId, ')
          ..write('rolClient: $rolClient, ')
          ..write('tipLucrare: $tipLucrare, ')
          ..write('stare: $stare, ')
          ..write('titlu: $titlu, ')
          ..write('observatii: $observatii, ')
          ..write('deschisaLa: $deschisaLa, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LucrariStariTable extends LucrariStari
    with TableInfo<$LucrariStariTable, LucrariStariData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LucrariStariTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lucrareIdMeta = const VerificationMeta(
    'lucrareId',
  );
  @override
  late final GeneratedColumn<String> lucrareId = GeneratedColumn<String>(
    'lucrare_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lucrari (id)',
    ),
  );
  static const VerificationMeta _stareDinMeta = const VerificationMeta(
    'stareDin',
  );
  @override
  late final GeneratedColumn<String> stareDin = GeneratedColumn<String>(
    'stare_din',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stareInMeta = const VerificationMeta(
    'stareIn',
  );
  @override
  late final GeneratedColumn<String> stareIn = GeneratedColumn<String>(
    'stare_in',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _laMeta = const VerificationMeta('la');
  @override
  late final GeneratedColumn<DateTime> la = GeneratedColumn<DateTime>(
    'la',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deCatreMeta = const VerificationMeta(
    'deCatre',
  );
  @override
  late final GeneratedColumn<String> deCatre = GeneratedColumn<String>(
    'de_catre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _observatieMeta = const VerificationMeta(
    'observatie',
  );
  @override
  late final GeneratedColumn<String> observatie = GeneratedColumn<String>(
    'observatie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lucrareId,
    stareDin,
    stareIn,
    la,
    deCatre,
    observatie,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'lucrari_stari';
  @override
  VerificationContext validateIntegrity(
    Insertable<LucrariStariData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lucrare_id')) {
      context.handle(
        _lucrareIdMeta,
        lucrareId.isAcceptableOrUnknown(data['lucrare_id']!, _lucrareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lucrareIdMeta);
    }
    if (data.containsKey('stare_din')) {
      context.handle(
        _stareDinMeta,
        stareDin.isAcceptableOrUnknown(data['stare_din']!, _stareDinMeta),
      );
    }
    if (data.containsKey('stare_in')) {
      context.handle(
        _stareInMeta,
        stareIn.isAcceptableOrUnknown(data['stare_in']!, _stareInMeta),
      );
    } else if (isInserting) {
      context.missing(_stareInMeta);
    }
    if (data.containsKey('la')) {
      context.handle(_laMeta, la.isAcceptableOrUnknown(data['la']!, _laMeta));
    } else if (isInserting) {
      context.missing(_laMeta);
    }
    if (data.containsKey('de_catre')) {
      context.handle(
        _deCatreMeta,
        deCatre.isAcceptableOrUnknown(data['de_catre']!, _deCatreMeta),
      );
    }
    if (data.containsKey('observatie')) {
      context.handle(
        _observatieMeta,
        observatie.isAcceptableOrUnknown(data['observatie']!, _observatieMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LucrariStariData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LucrariStariData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lucrareId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lucrare_id'],
      )!,
      stareDin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stare_din'],
      ),
      stareIn: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stare_in'],
      )!,
      la: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}la'],
      )!,
      deCatre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}de_catre'],
      )!,
      observatie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatie'],
      )!,
    );
  }

  @override
  $LucrariStariTable createAlias(String alias) {
    return $LucrariStariTable(attachedDatabase, alias);
  }
}

class LucrariStariData extends DataClass
    implements Insertable<LucrariStariData> {
  final String id;
  final String lucrareId;
  final String? stareDin;
  final String stareIn;
  final DateTime la;
  final String deCatre;
  final String observatie;
  const LucrariStariData({
    required this.id,
    required this.lucrareId,
    this.stareDin,
    required this.stareIn,
    required this.la,
    required this.deCatre,
    required this.observatie,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lucrare_id'] = Variable<String>(lucrareId);
    if (!nullToAbsent || stareDin != null) {
      map['stare_din'] = Variable<String>(stareDin);
    }
    map['stare_in'] = Variable<String>(stareIn);
    map['la'] = Variable<DateTime>(la);
    map['de_catre'] = Variable<String>(deCatre);
    map['observatie'] = Variable<String>(observatie);
    return map;
  }

  LucrariStariCompanion toCompanion(bool nullToAbsent) {
    return LucrariStariCompanion(
      id: Value(id),
      lucrareId: Value(lucrareId),
      stareDin: stareDin == null && nullToAbsent
          ? const Value.absent()
          : Value(stareDin),
      stareIn: Value(stareIn),
      la: Value(la),
      deCatre: Value(deCatre),
      observatie: Value(observatie),
    );
  }

  factory LucrariStariData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LucrariStariData(
      id: serializer.fromJson<String>(json['id']),
      lucrareId: serializer.fromJson<String>(json['lucrareId']),
      stareDin: serializer.fromJson<String?>(json['stareDin']),
      stareIn: serializer.fromJson<String>(json['stareIn']),
      la: serializer.fromJson<DateTime>(json['la']),
      deCatre: serializer.fromJson<String>(json['deCatre']),
      observatie: serializer.fromJson<String>(json['observatie']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lucrareId': serializer.toJson<String>(lucrareId),
      'stareDin': serializer.toJson<String?>(stareDin),
      'stareIn': serializer.toJson<String>(stareIn),
      'la': serializer.toJson<DateTime>(la),
      'deCatre': serializer.toJson<String>(deCatre),
      'observatie': serializer.toJson<String>(observatie),
    };
  }

  LucrariStariData copyWith({
    String? id,
    String? lucrareId,
    Value<String?> stareDin = const Value.absent(),
    String? stareIn,
    DateTime? la,
    String? deCatre,
    String? observatie,
  }) => LucrariStariData(
    id: id ?? this.id,
    lucrareId: lucrareId ?? this.lucrareId,
    stareDin: stareDin.present ? stareDin.value : this.stareDin,
    stareIn: stareIn ?? this.stareIn,
    la: la ?? this.la,
    deCatre: deCatre ?? this.deCatre,
    observatie: observatie ?? this.observatie,
  );
  LucrariStariData copyWithCompanion(LucrariStariCompanion data) {
    return LucrariStariData(
      id: data.id.present ? data.id.value : this.id,
      lucrareId: data.lucrareId.present ? data.lucrareId.value : this.lucrareId,
      stareDin: data.stareDin.present ? data.stareDin.value : this.stareDin,
      stareIn: data.stareIn.present ? data.stareIn.value : this.stareIn,
      la: data.la.present ? data.la.value : this.la,
      deCatre: data.deCatre.present ? data.deCatre.value : this.deCatre,
      observatie: data.observatie.present
          ? data.observatie.value
          : this.observatie,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LucrariStariData(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('stareDin: $stareDin, ')
          ..write('stareIn: $stareIn, ')
          ..write('la: $la, ')
          ..write('deCatre: $deCatre, ')
          ..write('observatie: $observatie')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, lucrareId, stareDin, stareIn, la, deCatre, observatie);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LucrariStariData &&
          other.id == this.id &&
          other.lucrareId == this.lucrareId &&
          other.stareDin == this.stareDin &&
          other.stareIn == this.stareIn &&
          other.la == this.la &&
          other.deCatre == this.deCatre &&
          other.observatie == this.observatie);
}

class LucrariStariCompanion extends UpdateCompanion<LucrariStariData> {
  final Value<String> id;
  final Value<String> lucrareId;
  final Value<String?> stareDin;
  final Value<String> stareIn;
  final Value<DateTime> la;
  final Value<String> deCatre;
  final Value<String> observatie;
  final Value<int> rowid;
  const LucrariStariCompanion({
    this.id = const Value.absent(),
    this.lucrareId = const Value.absent(),
    this.stareDin = const Value.absent(),
    this.stareIn = const Value.absent(),
    this.la = const Value.absent(),
    this.deCatre = const Value.absent(),
    this.observatie = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LucrariStariCompanion.insert({
    required String id,
    required String lucrareId,
    this.stareDin = const Value.absent(),
    required String stareIn,
    required DateTime la,
    this.deCatre = const Value.absent(),
    this.observatie = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lucrareId = Value(lucrareId),
       stareIn = Value(stareIn),
       la = Value(la);
  static Insertable<LucrariStariData> custom({
    Expression<String>? id,
    Expression<String>? lucrareId,
    Expression<String>? stareDin,
    Expression<String>? stareIn,
    Expression<DateTime>? la,
    Expression<String>? deCatre,
    Expression<String>? observatie,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lucrareId != null) 'lucrare_id': lucrareId,
      if (stareDin != null) 'stare_din': stareDin,
      if (stareIn != null) 'stare_in': stareIn,
      if (la != null) 'la': la,
      if (deCatre != null) 'de_catre': deCatre,
      if (observatie != null) 'observatie': observatie,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LucrariStariCompanion copyWith({
    Value<String>? id,
    Value<String>? lucrareId,
    Value<String?>? stareDin,
    Value<String>? stareIn,
    Value<DateTime>? la,
    Value<String>? deCatre,
    Value<String>? observatie,
    Value<int>? rowid,
  }) {
    return LucrariStariCompanion(
      id: id ?? this.id,
      lucrareId: lucrareId ?? this.lucrareId,
      stareDin: stareDin ?? this.stareDin,
      stareIn: stareIn ?? this.stareIn,
      la: la ?? this.la,
      deCatre: deCatre ?? this.deCatre,
      observatie: observatie ?? this.observatie,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lucrareId.present) {
      map['lucrare_id'] = Variable<String>(lucrareId.value);
    }
    if (stareDin.present) {
      map['stare_din'] = Variable<String>(stareDin.value);
    }
    if (stareIn.present) {
      map['stare_in'] = Variable<String>(stareIn.value);
    }
    if (la.present) {
      map['la'] = Variable<DateTime>(la.value);
    }
    if (deCatre.present) {
      map['de_catre'] = Variable<String>(deCatre.value);
    }
    if (observatie.present) {
      map['observatie'] = Variable<String>(observatie.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LucrariStariCompanion(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('stareDin: $stareDin, ')
          ..write('stareIn: $stareIn, ')
          ..write('la: $la, ')
          ..write('deCatre: $deCatre, ')
          ..write('observatie: $observatie, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocuriConsumTable extends LocuriConsum
    with TableInfo<$LocuriConsumTable, LocuriConsumData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocuriConsumTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lucrareIdMeta = const VerificationMeta(
    'lucrareId',
  );
  @override
  late final GeneratedColumn<String> lucrareId = GeneratedColumn<String>(
    'lucrare_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES lucrari (id)',
    ),
  );
  static const VerificationMeta _adresaMeta = const VerificationMeta('adresa');
  @override
  late final GeneratedColumn<String> adresa = GeneratedColumn<String>(
    'adresa',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _judetMeta = const VerificationMeta('judet');
  @override
  late final GeneratedColumn<String> judet = GeneratedColumn<String>(
    'judet',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _localitateMeta = const VerificationMeta(
    'localitate',
  );
  @override
  late final GeneratedColumn<String> localitate = GeneratedColumn<String>(
    'localitate',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _latMeta = const VerificationMeta('lat');
  @override
  late final GeneratedColumn<double> lat = GeneratedColumn<double>(
    'lat',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lonMeta = const VerificationMeta('lon');
  @override
  late final GeneratedColumn<double> lon = GeneratedColumn<double>(
    'lon',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _operatorDistributieMeta =
      const VerificationMeta('operatorDistributie');
  @override
  late final GeneratedColumn<String> operatorDistributie =
      GeneratedColumn<String>(
        'operator_distributie',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _codPodMeta = const VerificationMeta('codPod');
  @override
  late final GeneratedColumn<String> codPod = GeneratedColumn<String>(
    'cod_pod',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _furnizorEnergieMeta = const VerificationMeta(
    'furnizorEnergie',
  );
  @override
  late final GeneratedColumn<String> furnizorEnergie = GeneratedColumn<String>(
    'furnizor_energie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _codClientFurnizorMeta = const VerificationMeta(
    'codClientFurnizor',
  );
  @override
  late final GeneratedColumn<String> codClientFurnizor =
      GeneratedColumn<String>(
        'cod_client_furnizor',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _nivelTensiuneMeta = const VerificationMeta(
    'nivelTensiune',
  );
  @override
  late final GeneratedColumn<String> nivelTensiune = GeneratedColumn<String>(
    'nivel_tensiune',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bransamentMeta = const VerificationMeta(
    'bransament',
  );
  @override
  late final GeneratedColumn<String> bransament = GeneratedColumn<String>(
    'bransament',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _putereAprobataKvaMeta = const VerificationMeta(
    'putereAprobataKva',
  );
  @override
  late final GeneratedColumn<double> putereAprobataKva =
      GeneratedColumn<double>(
        'putere_aprobata_kva',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _putereContractataKwMeta =
      const VerificationMeta('putereContractataKw');
  @override
  late final GeneratedColumn<double> putereContractataKw =
      GeneratedColumn<double>(
        'putere_contractata_kw',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _disjunctorGeneralAMeta =
      const VerificationMeta('disjunctorGeneralA');
  @override
  late final GeneratedColumn<int> disjunctorGeneralA = GeneratedColumn<int>(
    'disjunctor_general_a',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _schemaLegarePamantMeta =
      const VerificationMeta('schemaLegarePamant');
  @override
  late final GeneratedColumn<String> schemaLegarePamant =
      GeneratedColumn<String>(
        'schema_legare_pamant',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _prizaPamantProprieMeta =
      const VerificationMeta('prizaPamantProprie');
  @override
  late final GeneratedColumn<bool> prizaPamantProprie = GeneratedColumn<bool>(
    'priza_pamant_proprie',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("priza_pamant_proprie" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _contorTipMeta = const VerificationMeta(
    'contorTip',
  );
  @override
  late final GeneratedColumn<String> contorTip = GeneratedColumn<String>(
    'contor_tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contorSerieMeta = const VerificationMeta(
    'contorSerie',
  );
  @override
  late final GeneratedColumn<String> contorSerie = GeneratedColumn<String>(
    'contor_serie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _contorBidirectionalMeta =
      const VerificationMeta('contorBidirectional');
  @override
  late final GeneratedColumn<bool> contorBidirectional = GeneratedColumn<bool>(
    'contor_bidirectional',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("contor_bidirectional" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _destinatieCladireMeta = const VerificationMeta(
    'destinatieCladire',
  );
  @override
  late final GeneratedColumn<String> destinatieCladire =
      GeneratedColumn<String>(
        'destinatie_cladire',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _anConstructieMeta = const VerificationMeta(
    'anConstructie',
  );
  @override
  late final GeneratedColumn<int> anConstructie = GeneratedColumn<int>(
    'an_constructie',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    lucrareId,
    adresa,
    judet,
    localitate,
    lat,
    lon,
    operatorDistributie,
    codPod,
    furnizorEnergie,
    codClientFurnizor,
    nivelTensiune,
    bransament,
    putereAprobataKva,
    putereContractataKw,
    disjunctorGeneralA,
    schemaLegarePamant,
    prizaPamantProprie,
    contorTip,
    contorSerie,
    contorBidirectional,
    destinatieCladire,
    anConstructie,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'locuri_consum';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocuriConsumData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('lucrare_id')) {
      context.handle(
        _lucrareIdMeta,
        lucrareId.isAcceptableOrUnknown(data['lucrare_id']!, _lucrareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lucrareIdMeta);
    }
    if (data.containsKey('adresa')) {
      context.handle(
        _adresaMeta,
        adresa.isAcceptableOrUnknown(data['adresa']!, _adresaMeta),
      );
    }
    if (data.containsKey('judet')) {
      context.handle(
        _judetMeta,
        judet.isAcceptableOrUnknown(data['judet']!, _judetMeta),
      );
    }
    if (data.containsKey('localitate')) {
      context.handle(
        _localitateMeta,
        localitate.isAcceptableOrUnknown(data['localitate']!, _localitateMeta),
      );
    }
    if (data.containsKey('lat')) {
      context.handle(
        _latMeta,
        lat.isAcceptableOrUnknown(data['lat']!, _latMeta),
      );
    }
    if (data.containsKey('lon')) {
      context.handle(
        _lonMeta,
        lon.isAcceptableOrUnknown(data['lon']!, _lonMeta),
      );
    }
    if (data.containsKey('operator_distributie')) {
      context.handle(
        _operatorDistributieMeta,
        operatorDistributie.isAcceptableOrUnknown(
          data['operator_distributie']!,
          _operatorDistributieMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_operatorDistributieMeta);
    }
    if (data.containsKey('cod_pod')) {
      context.handle(
        _codPodMeta,
        codPod.isAcceptableOrUnknown(data['cod_pod']!, _codPodMeta),
      );
    }
    if (data.containsKey('furnizor_energie')) {
      context.handle(
        _furnizorEnergieMeta,
        furnizorEnergie.isAcceptableOrUnknown(
          data['furnizor_energie']!,
          _furnizorEnergieMeta,
        ),
      );
    }
    if (data.containsKey('cod_client_furnizor')) {
      context.handle(
        _codClientFurnizorMeta,
        codClientFurnizor.isAcceptableOrUnknown(
          data['cod_client_furnizor']!,
          _codClientFurnizorMeta,
        ),
      );
    }
    if (data.containsKey('nivel_tensiune')) {
      context.handle(
        _nivelTensiuneMeta,
        nivelTensiune.isAcceptableOrUnknown(
          data['nivel_tensiune']!,
          _nivelTensiuneMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nivelTensiuneMeta);
    }
    if (data.containsKey('bransament')) {
      context.handle(
        _bransamentMeta,
        bransament.isAcceptableOrUnknown(data['bransament']!, _bransamentMeta),
      );
    } else if (isInserting) {
      context.missing(_bransamentMeta);
    }
    if (data.containsKey('putere_aprobata_kva')) {
      context.handle(
        _putereAprobataKvaMeta,
        putereAprobataKva.isAcceptableOrUnknown(
          data['putere_aprobata_kva']!,
          _putereAprobataKvaMeta,
        ),
      );
    }
    if (data.containsKey('putere_contractata_kw')) {
      context.handle(
        _putereContractataKwMeta,
        putereContractataKw.isAcceptableOrUnknown(
          data['putere_contractata_kw']!,
          _putereContractataKwMeta,
        ),
      );
    }
    if (data.containsKey('disjunctor_general_a')) {
      context.handle(
        _disjunctorGeneralAMeta,
        disjunctorGeneralA.isAcceptableOrUnknown(
          data['disjunctor_general_a']!,
          _disjunctorGeneralAMeta,
        ),
      );
    }
    if (data.containsKey('schema_legare_pamant')) {
      context.handle(
        _schemaLegarePamantMeta,
        schemaLegarePamant.isAcceptableOrUnknown(
          data['schema_legare_pamant']!,
          _schemaLegarePamantMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_schemaLegarePamantMeta);
    }
    if (data.containsKey('priza_pamant_proprie')) {
      context.handle(
        _prizaPamantProprieMeta,
        prizaPamantProprie.isAcceptableOrUnknown(
          data['priza_pamant_proprie']!,
          _prizaPamantProprieMeta,
        ),
      );
    }
    if (data.containsKey('contor_tip')) {
      context.handle(
        _contorTipMeta,
        contorTip.isAcceptableOrUnknown(data['contor_tip']!, _contorTipMeta),
      );
    } else if (isInserting) {
      context.missing(_contorTipMeta);
    }
    if (data.containsKey('contor_serie')) {
      context.handle(
        _contorSerieMeta,
        contorSerie.isAcceptableOrUnknown(
          data['contor_serie']!,
          _contorSerieMeta,
        ),
      );
    }
    if (data.containsKey('contor_bidirectional')) {
      context.handle(
        _contorBidirectionalMeta,
        contorBidirectional.isAcceptableOrUnknown(
          data['contor_bidirectional']!,
          _contorBidirectionalMeta,
        ),
      );
    }
    if (data.containsKey('destinatie_cladire')) {
      context.handle(
        _destinatieCladireMeta,
        destinatieCladire.isAcceptableOrUnknown(
          data['destinatie_cladire']!,
          _destinatieCladireMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_destinatieCladireMeta);
    }
    if (data.containsKey('an_constructie')) {
      context.handle(
        _anConstructieMeta,
        anConstructie.isAcceptableOrUnknown(
          data['an_constructie']!,
          _anConstructieMeta,
        ),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocuriConsumData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocuriConsumData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      lucrareId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lucrare_id'],
      )!,
      adresa: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}adresa'],
      )!,
      judet: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}judet'],
      )!,
      localitate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}localitate'],
      )!,
      lat: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lat'],
      ),
      lon: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lon'],
      ),
      operatorDistributie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator_distributie'],
      )!,
      codPod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cod_pod'],
      )!,
      furnizorEnergie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}furnizor_energie'],
      )!,
      codClientFurnizor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cod_client_furnizor'],
      )!,
      nivelTensiune: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nivel_tensiune'],
      )!,
      bransament: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bransament'],
      )!,
      putereAprobataKva: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}putere_aprobata_kva'],
      ),
      putereContractataKw: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}putere_contractata_kw'],
      ),
      disjunctorGeneralA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disjunctor_general_a'],
      ),
      schemaLegarePamant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}schema_legare_pamant'],
      )!,
      prizaPamantProprie: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}priza_pamant_proprie'],
      )!,
      contorTip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contor_tip'],
      )!,
      contorSerie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contor_serie'],
      )!,
      contorBidirectional: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}contor_bidirectional'],
      )!,
      destinatieCladire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}destinatie_cladire'],
      )!,
      anConstructie: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}an_constructie'],
      ),
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $LocuriConsumTable createAlias(String alias) {
    return $LocuriConsumTable(attachedDatabase, alias);
  }
}

class LocuriConsumData extends DataClass
    implements Insertable<LocuriConsumData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String lucrareId;
  final String adresa;
  final String judet;
  final String localitate;
  final double? lat;
  final double? lon;
  final String operatorDistributie;
  final String codPod;
  final String furnizorEnergie;
  final String codClientFurnizor;
  final String nivelTensiune;
  final String bransament;
  final double? putereAprobataKva;
  final double? putereContractataKw;
  final int? disjunctorGeneralA;
  final String schemaLegarePamant;
  final bool prizaPamantProprie;
  final String contorTip;
  final String contorSerie;
  final bool contorBidirectional;
  final String destinatieCladire;
  final int? anConstructie;
  final String observatii;
  const LocuriConsumData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.lucrareId,
    required this.adresa,
    required this.judet,
    required this.localitate,
    this.lat,
    this.lon,
    required this.operatorDistributie,
    required this.codPod,
    required this.furnizorEnergie,
    required this.codClientFurnizor,
    required this.nivelTensiune,
    required this.bransament,
    this.putereAprobataKva,
    this.putereContractataKw,
    this.disjunctorGeneralA,
    required this.schemaLegarePamant,
    required this.prizaPamantProprie,
    required this.contorTip,
    required this.contorSerie,
    required this.contorBidirectional,
    required this.destinatieCladire,
    this.anConstructie,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['lucrare_id'] = Variable<String>(lucrareId);
    map['adresa'] = Variable<String>(adresa);
    map['judet'] = Variable<String>(judet);
    map['localitate'] = Variable<String>(localitate);
    if (!nullToAbsent || lat != null) {
      map['lat'] = Variable<double>(lat);
    }
    if (!nullToAbsent || lon != null) {
      map['lon'] = Variable<double>(lon);
    }
    map['operator_distributie'] = Variable<String>(operatorDistributie);
    map['cod_pod'] = Variable<String>(codPod);
    map['furnizor_energie'] = Variable<String>(furnizorEnergie);
    map['cod_client_furnizor'] = Variable<String>(codClientFurnizor);
    map['nivel_tensiune'] = Variable<String>(nivelTensiune);
    map['bransament'] = Variable<String>(bransament);
    if (!nullToAbsent || putereAprobataKva != null) {
      map['putere_aprobata_kva'] = Variable<double>(putereAprobataKva);
    }
    if (!nullToAbsent || putereContractataKw != null) {
      map['putere_contractata_kw'] = Variable<double>(putereContractataKw);
    }
    if (!nullToAbsent || disjunctorGeneralA != null) {
      map['disjunctor_general_a'] = Variable<int>(disjunctorGeneralA);
    }
    map['schema_legare_pamant'] = Variable<String>(schemaLegarePamant);
    map['priza_pamant_proprie'] = Variable<bool>(prizaPamantProprie);
    map['contor_tip'] = Variable<String>(contorTip);
    map['contor_serie'] = Variable<String>(contorSerie);
    map['contor_bidirectional'] = Variable<bool>(contorBidirectional);
    map['destinatie_cladire'] = Variable<String>(destinatieCladire);
    if (!nullToAbsent || anConstructie != null) {
      map['an_constructie'] = Variable<int>(anConstructie);
    }
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  LocuriConsumCompanion toCompanion(bool nullToAbsent) {
    return LocuriConsumCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      lucrareId: Value(lucrareId),
      adresa: Value(adresa),
      judet: Value(judet),
      localitate: Value(localitate),
      lat: lat == null && nullToAbsent ? const Value.absent() : Value(lat),
      lon: lon == null && nullToAbsent ? const Value.absent() : Value(lon),
      operatorDistributie: Value(operatorDistributie),
      codPod: Value(codPod),
      furnizorEnergie: Value(furnizorEnergie),
      codClientFurnizor: Value(codClientFurnizor),
      nivelTensiune: Value(nivelTensiune),
      bransament: Value(bransament),
      putereAprobataKva: putereAprobataKva == null && nullToAbsent
          ? const Value.absent()
          : Value(putereAprobataKva),
      putereContractataKw: putereContractataKw == null && nullToAbsent
          ? const Value.absent()
          : Value(putereContractataKw),
      disjunctorGeneralA: disjunctorGeneralA == null && nullToAbsent
          ? const Value.absent()
          : Value(disjunctorGeneralA),
      schemaLegarePamant: Value(schemaLegarePamant),
      prizaPamantProprie: Value(prizaPamantProprie),
      contorTip: Value(contorTip),
      contorSerie: Value(contorSerie),
      contorBidirectional: Value(contorBidirectional),
      destinatieCladire: Value(destinatieCladire),
      anConstructie: anConstructie == null && nullToAbsent
          ? const Value.absent()
          : Value(anConstructie),
      observatii: Value(observatii),
    );
  }

  factory LocuriConsumData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocuriConsumData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      lucrareId: serializer.fromJson<String>(json['lucrareId']),
      adresa: serializer.fromJson<String>(json['adresa']),
      judet: serializer.fromJson<String>(json['judet']),
      localitate: serializer.fromJson<String>(json['localitate']),
      lat: serializer.fromJson<double?>(json['lat']),
      lon: serializer.fromJson<double?>(json['lon']),
      operatorDistributie: serializer.fromJson<String>(
        json['operatorDistributie'],
      ),
      codPod: serializer.fromJson<String>(json['codPod']),
      furnizorEnergie: serializer.fromJson<String>(json['furnizorEnergie']),
      codClientFurnizor: serializer.fromJson<String>(json['codClientFurnizor']),
      nivelTensiune: serializer.fromJson<String>(json['nivelTensiune']),
      bransament: serializer.fromJson<String>(json['bransament']),
      putereAprobataKva: serializer.fromJson<double?>(
        json['putereAprobataKva'],
      ),
      putereContractataKw: serializer.fromJson<double?>(
        json['putereContractataKw'],
      ),
      disjunctorGeneralA: serializer.fromJson<int?>(json['disjunctorGeneralA']),
      schemaLegarePamant: serializer.fromJson<String>(
        json['schemaLegarePamant'],
      ),
      prizaPamantProprie: serializer.fromJson<bool>(json['prizaPamantProprie']),
      contorTip: serializer.fromJson<String>(json['contorTip']),
      contorSerie: serializer.fromJson<String>(json['contorSerie']),
      contorBidirectional: serializer.fromJson<bool>(
        json['contorBidirectional'],
      ),
      destinatieCladire: serializer.fromJson<String>(json['destinatieCladire']),
      anConstructie: serializer.fromJson<int?>(json['anConstructie']),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'lucrareId': serializer.toJson<String>(lucrareId),
      'adresa': serializer.toJson<String>(adresa),
      'judet': serializer.toJson<String>(judet),
      'localitate': serializer.toJson<String>(localitate),
      'lat': serializer.toJson<double?>(lat),
      'lon': serializer.toJson<double?>(lon),
      'operatorDistributie': serializer.toJson<String>(operatorDistributie),
      'codPod': serializer.toJson<String>(codPod),
      'furnizorEnergie': serializer.toJson<String>(furnizorEnergie),
      'codClientFurnizor': serializer.toJson<String>(codClientFurnizor),
      'nivelTensiune': serializer.toJson<String>(nivelTensiune),
      'bransament': serializer.toJson<String>(bransament),
      'putereAprobataKva': serializer.toJson<double?>(putereAprobataKva),
      'putereContractataKw': serializer.toJson<double?>(putereContractataKw),
      'disjunctorGeneralA': serializer.toJson<int?>(disjunctorGeneralA),
      'schemaLegarePamant': serializer.toJson<String>(schemaLegarePamant),
      'prizaPamantProprie': serializer.toJson<bool>(prizaPamantProprie),
      'contorTip': serializer.toJson<String>(contorTip),
      'contorSerie': serializer.toJson<String>(contorSerie),
      'contorBidirectional': serializer.toJson<bool>(contorBidirectional),
      'destinatieCladire': serializer.toJson<String>(destinatieCladire),
      'anConstructie': serializer.toJson<int?>(anConstructie),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  LocuriConsumData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? lucrareId,
    String? adresa,
    String? judet,
    String? localitate,
    Value<double?> lat = const Value.absent(),
    Value<double?> lon = const Value.absent(),
    String? operatorDistributie,
    String? codPod,
    String? furnizorEnergie,
    String? codClientFurnizor,
    String? nivelTensiune,
    String? bransament,
    Value<double?> putereAprobataKva = const Value.absent(),
    Value<double?> putereContractataKw = const Value.absent(),
    Value<int?> disjunctorGeneralA = const Value.absent(),
    String? schemaLegarePamant,
    bool? prizaPamantProprie,
    String? contorTip,
    String? contorSerie,
    bool? contorBidirectional,
    String? destinatieCladire,
    Value<int?> anConstructie = const Value.absent(),
    String? observatii,
  }) => LocuriConsumData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    lucrareId: lucrareId ?? this.lucrareId,
    adresa: adresa ?? this.adresa,
    judet: judet ?? this.judet,
    localitate: localitate ?? this.localitate,
    lat: lat.present ? lat.value : this.lat,
    lon: lon.present ? lon.value : this.lon,
    operatorDistributie: operatorDistributie ?? this.operatorDistributie,
    codPod: codPod ?? this.codPod,
    furnizorEnergie: furnizorEnergie ?? this.furnizorEnergie,
    codClientFurnizor: codClientFurnizor ?? this.codClientFurnizor,
    nivelTensiune: nivelTensiune ?? this.nivelTensiune,
    bransament: bransament ?? this.bransament,
    putereAprobataKva: putereAprobataKva.present
        ? putereAprobataKva.value
        : this.putereAprobataKva,
    putereContractataKw: putereContractataKw.present
        ? putereContractataKw.value
        : this.putereContractataKw,
    disjunctorGeneralA: disjunctorGeneralA.present
        ? disjunctorGeneralA.value
        : this.disjunctorGeneralA,
    schemaLegarePamant: schemaLegarePamant ?? this.schemaLegarePamant,
    prizaPamantProprie: prizaPamantProprie ?? this.prizaPamantProprie,
    contorTip: contorTip ?? this.contorTip,
    contorSerie: contorSerie ?? this.contorSerie,
    contorBidirectional: contorBidirectional ?? this.contorBidirectional,
    destinatieCladire: destinatieCladire ?? this.destinatieCladire,
    anConstructie: anConstructie.present
        ? anConstructie.value
        : this.anConstructie,
    observatii: observatii ?? this.observatii,
  );
  LocuriConsumData copyWithCompanion(LocuriConsumCompanion data) {
    return LocuriConsumData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      lucrareId: data.lucrareId.present ? data.lucrareId.value : this.lucrareId,
      adresa: data.adresa.present ? data.adresa.value : this.adresa,
      judet: data.judet.present ? data.judet.value : this.judet,
      localitate: data.localitate.present
          ? data.localitate.value
          : this.localitate,
      lat: data.lat.present ? data.lat.value : this.lat,
      lon: data.lon.present ? data.lon.value : this.lon,
      operatorDistributie: data.operatorDistributie.present
          ? data.operatorDistributie.value
          : this.operatorDistributie,
      codPod: data.codPod.present ? data.codPod.value : this.codPod,
      furnizorEnergie: data.furnizorEnergie.present
          ? data.furnizorEnergie.value
          : this.furnizorEnergie,
      codClientFurnizor: data.codClientFurnizor.present
          ? data.codClientFurnizor.value
          : this.codClientFurnizor,
      nivelTensiune: data.nivelTensiune.present
          ? data.nivelTensiune.value
          : this.nivelTensiune,
      bransament: data.bransament.present
          ? data.bransament.value
          : this.bransament,
      putereAprobataKva: data.putereAprobataKva.present
          ? data.putereAprobataKva.value
          : this.putereAprobataKva,
      putereContractataKw: data.putereContractataKw.present
          ? data.putereContractataKw.value
          : this.putereContractataKw,
      disjunctorGeneralA: data.disjunctorGeneralA.present
          ? data.disjunctorGeneralA.value
          : this.disjunctorGeneralA,
      schemaLegarePamant: data.schemaLegarePamant.present
          ? data.schemaLegarePamant.value
          : this.schemaLegarePamant,
      prizaPamantProprie: data.prizaPamantProprie.present
          ? data.prizaPamantProprie.value
          : this.prizaPamantProprie,
      contorTip: data.contorTip.present ? data.contorTip.value : this.contorTip,
      contorSerie: data.contorSerie.present
          ? data.contorSerie.value
          : this.contorSerie,
      contorBidirectional: data.contorBidirectional.present
          ? data.contorBidirectional.value
          : this.contorBidirectional,
      destinatieCladire: data.destinatieCladire.present
          ? data.destinatieCladire.value
          : this.destinatieCladire,
      anConstructie: data.anConstructie.present
          ? data.anConstructie.value
          : this.anConstructie,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocuriConsumData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('adresa: $adresa, ')
          ..write('judet: $judet, ')
          ..write('localitate: $localitate, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('operatorDistributie: $operatorDistributie, ')
          ..write('codPod: $codPod, ')
          ..write('furnizorEnergie: $furnizorEnergie, ')
          ..write('codClientFurnizor: $codClientFurnizor, ')
          ..write('nivelTensiune: $nivelTensiune, ')
          ..write('bransament: $bransament, ')
          ..write('putereAprobataKva: $putereAprobataKva, ')
          ..write('putereContractataKw: $putereContractataKw, ')
          ..write('disjunctorGeneralA: $disjunctorGeneralA, ')
          ..write('schemaLegarePamant: $schemaLegarePamant, ')
          ..write('prizaPamantProprie: $prizaPamantProprie, ')
          ..write('contorTip: $contorTip, ')
          ..write('contorSerie: $contorSerie, ')
          ..write('contorBidirectional: $contorBidirectional, ')
          ..write('destinatieCladire: $destinatieCladire, ')
          ..write('anConstructie: $anConstructie, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    lucrareId,
    adresa,
    judet,
    localitate,
    lat,
    lon,
    operatorDistributie,
    codPod,
    furnizorEnergie,
    codClientFurnizor,
    nivelTensiune,
    bransament,
    putereAprobataKva,
    putereContractataKw,
    disjunctorGeneralA,
    schemaLegarePamant,
    prizaPamantProprie,
    contorTip,
    contorSerie,
    contorBidirectional,
    destinatieCladire,
    anConstructie,
    observatii,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocuriConsumData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.lucrareId == this.lucrareId &&
          other.adresa == this.adresa &&
          other.judet == this.judet &&
          other.localitate == this.localitate &&
          other.lat == this.lat &&
          other.lon == this.lon &&
          other.operatorDistributie == this.operatorDistributie &&
          other.codPod == this.codPod &&
          other.furnizorEnergie == this.furnizorEnergie &&
          other.codClientFurnizor == this.codClientFurnizor &&
          other.nivelTensiune == this.nivelTensiune &&
          other.bransament == this.bransament &&
          other.putereAprobataKva == this.putereAprobataKva &&
          other.putereContractataKw == this.putereContractataKw &&
          other.disjunctorGeneralA == this.disjunctorGeneralA &&
          other.schemaLegarePamant == this.schemaLegarePamant &&
          other.prizaPamantProprie == this.prizaPamantProprie &&
          other.contorTip == this.contorTip &&
          other.contorSerie == this.contorSerie &&
          other.contorBidirectional == this.contorBidirectional &&
          other.destinatieCladire == this.destinatieCladire &&
          other.anConstructie == this.anConstructie &&
          other.observatii == this.observatii);
}

class LocuriConsumCompanion extends UpdateCompanion<LocuriConsumData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> lucrareId;
  final Value<String> adresa;
  final Value<String> judet;
  final Value<String> localitate;
  final Value<double?> lat;
  final Value<double?> lon;
  final Value<String> operatorDistributie;
  final Value<String> codPod;
  final Value<String> furnizorEnergie;
  final Value<String> codClientFurnizor;
  final Value<String> nivelTensiune;
  final Value<String> bransament;
  final Value<double?> putereAprobataKva;
  final Value<double?> putereContractataKw;
  final Value<int?> disjunctorGeneralA;
  final Value<String> schemaLegarePamant;
  final Value<bool> prizaPamantProprie;
  final Value<String> contorTip;
  final Value<String> contorSerie;
  final Value<bool> contorBidirectional;
  final Value<String> destinatieCladire;
  final Value<int?> anConstructie;
  final Value<String> observatii;
  final Value<int> rowid;
  const LocuriConsumCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.lucrareId = const Value.absent(),
    this.adresa = const Value.absent(),
    this.judet = const Value.absent(),
    this.localitate = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    this.operatorDistributie = const Value.absent(),
    this.codPod = const Value.absent(),
    this.furnizorEnergie = const Value.absent(),
    this.codClientFurnizor = const Value.absent(),
    this.nivelTensiune = const Value.absent(),
    this.bransament = const Value.absent(),
    this.putereAprobataKva = const Value.absent(),
    this.putereContractataKw = const Value.absent(),
    this.disjunctorGeneralA = const Value.absent(),
    this.schemaLegarePamant = const Value.absent(),
    this.prizaPamantProprie = const Value.absent(),
    this.contorTip = const Value.absent(),
    this.contorSerie = const Value.absent(),
    this.contorBidirectional = const Value.absent(),
    this.destinatieCladire = const Value.absent(),
    this.anConstructie = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocuriConsumCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String lucrareId,
    this.adresa = const Value.absent(),
    this.judet = const Value.absent(),
    this.localitate = const Value.absent(),
    this.lat = const Value.absent(),
    this.lon = const Value.absent(),
    required String operatorDistributie,
    this.codPod = const Value.absent(),
    this.furnizorEnergie = const Value.absent(),
    this.codClientFurnizor = const Value.absent(),
    required String nivelTensiune,
    required String bransament,
    this.putereAprobataKva = const Value.absent(),
    this.putereContractataKw = const Value.absent(),
    this.disjunctorGeneralA = const Value.absent(),
    required String schemaLegarePamant,
    this.prizaPamantProprie = const Value.absent(),
    required String contorTip,
    this.contorSerie = const Value.absent(),
    this.contorBidirectional = const Value.absent(),
    required String destinatieCladire,
    this.anConstructie = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       lucrareId = Value(lucrareId),
       operatorDistributie = Value(operatorDistributie),
       nivelTensiune = Value(nivelTensiune),
       bransament = Value(bransament),
       schemaLegarePamant = Value(schemaLegarePamant),
       contorTip = Value(contorTip),
       destinatieCladire = Value(destinatieCladire);
  static Insertable<LocuriConsumData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? lucrareId,
    Expression<String>? adresa,
    Expression<String>? judet,
    Expression<String>? localitate,
    Expression<double>? lat,
    Expression<double>? lon,
    Expression<String>? operatorDistributie,
    Expression<String>? codPod,
    Expression<String>? furnizorEnergie,
    Expression<String>? codClientFurnizor,
    Expression<String>? nivelTensiune,
    Expression<String>? bransament,
    Expression<double>? putereAprobataKva,
    Expression<double>? putereContractataKw,
    Expression<int>? disjunctorGeneralA,
    Expression<String>? schemaLegarePamant,
    Expression<bool>? prizaPamantProprie,
    Expression<String>? contorTip,
    Expression<String>? contorSerie,
    Expression<bool>? contorBidirectional,
    Expression<String>? destinatieCladire,
    Expression<int>? anConstructie,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (lucrareId != null) 'lucrare_id': lucrareId,
      if (adresa != null) 'adresa': adresa,
      if (judet != null) 'judet': judet,
      if (localitate != null) 'localitate': localitate,
      if (lat != null) 'lat': lat,
      if (lon != null) 'lon': lon,
      if (operatorDistributie != null)
        'operator_distributie': operatorDistributie,
      if (codPod != null) 'cod_pod': codPod,
      if (furnizorEnergie != null) 'furnizor_energie': furnizorEnergie,
      if (codClientFurnizor != null) 'cod_client_furnizor': codClientFurnizor,
      if (nivelTensiune != null) 'nivel_tensiune': nivelTensiune,
      if (bransament != null) 'bransament': bransament,
      if (putereAprobataKva != null) 'putere_aprobata_kva': putereAprobataKva,
      if (putereContractataKw != null)
        'putere_contractata_kw': putereContractataKw,
      if (disjunctorGeneralA != null)
        'disjunctor_general_a': disjunctorGeneralA,
      if (schemaLegarePamant != null)
        'schema_legare_pamant': schemaLegarePamant,
      if (prizaPamantProprie != null)
        'priza_pamant_proprie': prizaPamantProprie,
      if (contorTip != null) 'contor_tip': contorTip,
      if (contorSerie != null) 'contor_serie': contorSerie,
      if (contorBidirectional != null)
        'contor_bidirectional': contorBidirectional,
      if (destinatieCladire != null) 'destinatie_cladire': destinatieCladire,
      if (anConstructie != null) 'an_constructie': anConstructie,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocuriConsumCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? lucrareId,
    Value<String>? adresa,
    Value<String>? judet,
    Value<String>? localitate,
    Value<double?>? lat,
    Value<double?>? lon,
    Value<String>? operatorDistributie,
    Value<String>? codPod,
    Value<String>? furnizorEnergie,
    Value<String>? codClientFurnizor,
    Value<String>? nivelTensiune,
    Value<String>? bransament,
    Value<double?>? putereAprobataKva,
    Value<double?>? putereContractataKw,
    Value<int?>? disjunctorGeneralA,
    Value<String>? schemaLegarePamant,
    Value<bool>? prizaPamantProprie,
    Value<String>? contorTip,
    Value<String>? contorSerie,
    Value<bool>? contorBidirectional,
    Value<String>? destinatieCladire,
    Value<int?>? anConstructie,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return LocuriConsumCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      lucrareId: lucrareId ?? this.lucrareId,
      adresa: adresa ?? this.adresa,
      judet: judet ?? this.judet,
      localitate: localitate ?? this.localitate,
      lat: lat ?? this.lat,
      lon: lon ?? this.lon,
      operatorDistributie: operatorDistributie ?? this.operatorDistributie,
      codPod: codPod ?? this.codPod,
      furnizorEnergie: furnizorEnergie ?? this.furnizorEnergie,
      codClientFurnizor: codClientFurnizor ?? this.codClientFurnizor,
      nivelTensiune: nivelTensiune ?? this.nivelTensiune,
      bransament: bransament ?? this.bransament,
      putereAprobataKva: putereAprobataKva ?? this.putereAprobataKva,
      putereContractataKw: putereContractataKw ?? this.putereContractataKw,
      disjunctorGeneralA: disjunctorGeneralA ?? this.disjunctorGeneralA,
      schemaLegarePamant: schemaLegarePamant ?? this.schemaLegarePamant,
      prizaPamantProprie: prizaPamantProprie ?? this.prizaPamantProprie,
      contorTip: contorTip ?? this.contorTip,
      contorSerie: contorSerie ?? this.contorSerie,
      contorBidirectional: contorBidirectional ?? this.contorBidirectional,
      destinatieCladire: destinatieCladire ?? this.destinatieCladire,
      anConstructie: anConstructie ?? this.anConstructie,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (lucrareId.present) {
      map['lucrare_id'] = Variable<String>(lucrareId.value);
    }
    if (adresa.present) {
      map['adresa'] = Variable<String>(adresa.value);
    }
    if (judet.present) {
      map['judet'] = Variable<String>(judet.value);
    }
    if (localitate.present) {
      map['localitate'] = Variable<String>(localitate.value);
    }
    if (lat.present) {
      map['lat'] = Variable<double>(lat.value);
    }
    if (lon.present) {
      map['lon'] = Variable<double>(lon.value);
    }
    if (operatorDistributie.present) {
      map['operator_distributie'] = Variable<String>(operatorDistributie.value);
    }
    if (codPod.present) {
      map['cod_pod'] = Variable<String>(codPod.value);
    }
    if (furnizorEnergie.present) {
      map['furnizor_energie'] = Variable<String>(furnizorEnergie.value);
    }
    if (codClientFurnizor.present) {
      map['cod_client_furnizor'] = Variable<String>(codClientFurnizor.value);
    }
    if (nivelTensiune.present) {
      map['nivel_tensiune'] = Variable<String>(nivelTensiune.value);
    }
    if (bransament.present) {
      map['bransament'] = Variable<String>(bransament.value);
    }
    if (putereAprobataKva.present) {
      map['putere_aprobata_kva'] = Variable<double>(putereAprobataKva.value);
    }
    if (putereContractataKw.present) {
      map['putere_contractata_kw'] = Variable<double>(
        putereContractataKw.value,
      );
    }
    if (disjunctorGeneralA.present) {
      map['disjunctor_general_a'] = Variable<int>(disjunctorGeneralA.value);
    }
    if (schemaLegarePamant.present) {
      map['schema_legare_pamant'] = Variable<String>(schemaLegarePamant.value);
    }
    if (prizaPamantProprie.present) {
      map['priza_pamant_proprie'] = Variable<bool>(prizaPamantProprie.value);
    }
    if (contorTip.present) {
      map['contor_tip'] = Variable<String>(contorTip.value);
    }
    if (contorSerie.present) {
      map['contor_serie'] = Variable<String>(contorSerie.value);
    }
    if (contorBidirectional.present) {
      map['contor_bidirectional'] = Variable<bool>(contorBidirectional.value);
    }
    if (destinatieCladire.present) {
      map['destinatie_cladire'] = Variable<String>(destinatieCladire.value);
    }
    if (anConstructie.present) {
      map['an_constructie'] = Variable<int>(anConstructie.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocuriConsumCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('adresa: $adresa, ')
          ..write('judet: $judet, ')
          ..write('localitate: $localitate, ')
          ..write('lat: $lat, ')
          ..write('lon: $lon, ')
          ..write('operatorDistributie: $operatorDistributie, ')
          ..write('codPod: $codPod, ')
          ..write('furnizorEnergie: $furnizorEnergie, ')
          ..write('codClientFurnizor: $codClientFurnizor, ')
          ..write('nivelTensiune: $nivelTensiune, ')
          ..write('bransament: $bransament, ')
          ..write('putereAprobataKva: $putereAprobataKva, ')
          ..write('putereContractataKw: $putereContractataKw, ')
          ..write('disjunctorGeneralA: $disjunctorGeneralA, ')
          ..write('schemaLegarePamant: $schemaLegarePamant, ')
          ..write('prizaPamantProprie: $prizaPamantProprie, ')
          ..write('contorTip: $contorTip, ')
          ..write('contorSerie: $contorSerie, ')
          ..write('contorBidirectional: $contorBidirectional, ')
          ..write('destinatieCladire: $destinatieCladire, ')
          ..write('anConstructie: $anConstructie, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FurnizoriTable extends Furnizori
    with TableInfo<$FurnizoriTable, FurnizoriData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FurnizoriTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _denumireMeta = const VerificationMeta(
    'denumire',
  );
  @override
  late final GeneratedColumn<String> denumire = GeneratedColumn<String>(
    'denumire',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _predefinitMeta = const VerificationMeta(
    'predefinit',
  );
  @override
  late final GeneratedColumn<bool> predefinit = GeneratedColumn<bool>(
    'predefinit',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("predefinit" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    denumire,
    predefinit,
    createdAt,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'furnizori';
  @override
  VerificationContext validateIntegrity(
    Insertable<FurnizoriData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('denumire')) {
      context.handle(
        _denumireMeta,
        denumire.isAcceptableOrUnknown(data['denumire']!, _denumireMeta),
      );
    } else if (isInserting) {
      context.missing(_denumireMeta);
    }
    if (data.containsKey('predefinit')) {
      context.handle(
        _predefinitMeta,
        predefinit.isAcceptableOrUnknown(data['predefinit']!, _predefinitMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FurnizoriData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FurnizoriData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      denumire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}denumire'],
      )!,
      predefinit: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}predefinit'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $FurnizoriTable createAlias(String alias) {
    return $FurnizoriTable(attachedDatabase, alias);
  }
}

class FurnizoriData extends DataClass implements Insertable<FurnizoriData> {
  final String id;
  final String denumire;
  final bool predefinit;
  final DateTime createdAt;
  final DateTime? deletedAt;
  const FurnizoriData({
    required this.id,
    required this.denumire,
    required this.predefinit,
    required this.createdAt,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['denumire'] = Variable<String>(denumire);
    map['predefinit'] = Variable<bool>(predefinit);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  FurnizoriCompanion toCompanion(bool nullToAbsent) {
    return FurnizoriCompanion(
      id: Value(id),
      denumire: Value(denumire),
      predefinit: Value(predefinit),
      createdAt: Value(createdAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory FurnizoriData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FurnizoriData(
      id: serializer.fromJson<String>(json['id']),
      denumire: serializer.fromJson<String>(json['denumire']),
      predefinit: serializer.fromJson<bool>(json['predefinit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'denumire': serializer.toJson<String>(denumire),
      'predefinit': serializer.toJson<bool>(predefinit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  FurnizoriData copyWith({
    String? id,
    String? denumire,
    bool? predefinit,
    DateTime? createdAt,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => FurnizoriData(
    id: id ?? this.id,
    denumire: denumire ?? this.denumire,
    predefinit: predefinit ?? this.predefinit,
    createdAt: createdAt ?? this.createdAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  FurnizoriData copyWithCompanion(FurnizoriCompanion data) {
    return FurnizoriData(
      id: data.id.present ? data.id.value : this.id,
      denumire: data.denumire.present ? data.denumire.value : this.denumire,
      predefinit: data.predefinit.present
          ? data.predefinit.value
          : this.predefinit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FurnizoriData(')
          ..write('id: $id, ')
          ..write('denumire: $denumire, ')
          ..write('predefinit: $predefinit, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, denumire, predefinit, createdAt, deletedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FurnizoriData &&
          other.id == this.id &&
          other.denumire == this.denumire &&
          other.predefinit == this.predefinit &&
          other.createdAt == this.createdAt &&
          other.deletedAt == this.deletedAt);
}

class FurnizoriCompanion extends UpdateCompanion<FurnizoriData> {
  final Value<String> id;
  final Value<String> denumire;
  final Value<bool> predefinit;
  final Value<DateTime> createdAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const FurnizoriCompanion({
    this.id = const Value.absent(),
    this.denumire = const Value.absent(),
    this.predefinit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FurnizoriCompanion.insert({
    required String id,
    required String denumire,
    this.predefinit = const Value.absent(),
    required DateTime createdAt,
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       denumire = Value(denumire),
       createdAt = Value(createdAt);
  static Insertable<FurnizoriData> custom({
    Expression<String>? id,
    Expression<String>? denumire,
    Expression<bool>? predefinit,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (denumire != null) 'denumire': denumire,
      if (predefinit != null) 'predefinit': predefinit,
      if (createdAt != null) 'created_at': createdAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FurnizoriCompanion copyWith({
    Value<String>? id,
    Value<String>? denumire,
    Value<bool>? predefinit,
    Value<DateTime>? createdAt,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return FurnizoriCompanion(
      id: id ?? this.id,
      denumire: denumire ?? this.denumire,
      predefinit: predefinit ?? this.predefinit,
      createdAt: createdAt ?? this.createdAt,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (denumire.present) {
      map['denumire'] = Variable<String>(denumire.value);
    }
    if (predefinit.present) {
      map['predefinit'] = Variable<bool>(predefinit.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FurnizoriCompanion(')
          ..write('id: $id, ')
          ..write('denumire: $denumire, ')
          ..write('predefinit: $predefinit, ')
          ..write('createdAt: $createdAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SolutiiTable extends Solutii with TableInfo<$SolutiiTable, SolutiiData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SolutiiTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lucrareIdMeta = const VerificationMeta(
    'lucrareId',
  );
  @override
  late final GeneratedColumn<String> lucrareId = GeneratedColumn<String>(
    'lucrare_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lucrari (id)',
    ),
  );
  static const VerificationMeta _revizieMeta = const VerificationMeta(
    'revizie',
  );
  @override
  late final GeneratedColumn<int> revizie = GeneratedColumn<int>(
    'revizie',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creataLaMeta = const VerificationMeta(
    'creataLa',
  );
  @override
  late final GeneratedColumn<DateTime> creataLa = GeneratedColumn<DateTime>(
    'creata_la',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intrariJsonMeta = const VerificationMeta(
    'intrariJson',
  );
  @override
  late final GeneratedColumn<String> intrariJson = GeneratedColumn<String>(
    'intrari_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rezultatJsonMeta = const VerificationMeta(
    'rezultatJson',
  );
  @override
  late final GeneratedColumn<String> rezultatJson = GeneratedColumn<String>(
    'rezultat_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lucrareId,
    revizie,
    creataLa,
    intrariJson,
    rezultatJson,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'solutii';
  @override
  VerificationContext validateIntegrity(
    Insertable<SolutiiData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lucrare_id')) {
      context.handle(
        _lucrareIdMeta,
        lucrareId.isAcceptableOrUnknown(data['lucrare_id']!, _lucrareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lucrareIdMeta);
    }
    if (data.containsKey('revizie')) {
      context.handle(
        _revizieMeta,
        revizie.isAcceptableOrUnknown(data['revizie']!, _revizieMeta),
      );
    } else if (isInserting) {
      context.missing(_revizieMeta);
    }
    if (data.containsKey('creata_la')) {
      context.handle(
        _creataLaMeta,
        creataLa.isAcceptableOrUnknown(data['creata_la']!, _creataLaMeta),
      );
    } else if (isInserting) {
      context.missing(_creataLaMeta);
    }
    if (data.containsKey('intrari_json')) {
      context.handle(
        _intrariJsonMeta,
        intrariJson.isAcceptableOrUnknown(
          data['intrari_json']!,
          _intrariJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intrariJsonMeta);
    }
    if (data.containsKey('rezultat_json')) {
      context.handle(
        _rezultatJsonMeta,
        rezultatJson.isAcceptableOrUnknown(
          data['rezultat_json']!,
          _rezultatJsonMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_rezultatJsonMeta);
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SolutiiData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SolutiiData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lucrareId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lucrare_id'],
      )!,
      revizie: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revizie'],
      )!,
      creataLa: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creata_la'],
      )!,
      intrariJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intrari_json'],
      )!,
      rezultatJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rezultat_json'],
      )!,
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $SolutiiTable createAlias(String alias) {
    return $SolutiiTable(attachedDatabase, alias);
  }
}

class SolutiiData extends DataClass implements Insertable<SolutiiData> {
  final String id;
  final String lucrareId;
  final int revizie;
  final DateTime creataLa;
  final String intrariJson;
  final String rezultatJson;
  final String observatii;
  const SolutiiData({
    required this.id,
    required this.lucrareId,
    required this.revizie,
    required this.creataLa,
    required this.intrariJson,
    required this.rezultatJson,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lucrare_id'] = Variable<String>(lucrareId);
    map['revizie'] = Variable<int>(revizie);
    map['creata_la'] = Variable<DateTime>(creataLa);
    map['intrari_json'] = Variable<String>(intrariJson);
    map['rezultat_json'] = Variable<String>(rezultatJson);
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  SolutiiCompanion toCompanion(bool nullToAbsent) {
    return SolutiiCompanion(
      id: Value(id),
      lucrareId: Value(lucrareId),
      revizie: Value(revizie),
      creataLa: Value(creataLa),
      intrariJson: Value(intrariJson),
      rezultatJson: Value(rezultatJson),
      observatii: Value(observatii),
    );
  }

  factory SolutiiData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SolutiiData(
      id: serializer.fromJson<String>(json['id']),
      lucrareId: serializer.fromJson<String>(json['lucrareId']),
      revizie: serializer.fromJson<int>(json['revizie']),
      creataLa: serializer.fromJson<DateTime>(json['creataLa']),
      intrariJson: serializer.fromJson<String>(json['intrariJson']),
      rezultatJson: serializer.fromJson<String>(json['rezultatJson']),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lucrareId': serializer.toJson<String>(lucrareId),
      'revizie': serializer.toJson<int>(revizie),
      'creataLa': serializer.toJson<DateTime>(creataLa),
      'intrariJson': serializer.toJson<String>(intrariJson),
      'rezultatJson': serializer.toJson<String>(rezultatJson),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  SolutiiData copyWith({
    String? id,
    String? lucrareId,
    int? revizie,
    DateTime? creataLa,
    String? intrariJson,
    String? rezultatJson,
    String? observatii,
  }) => SolutiiData(
    id: id ?? this.id,
    lucrareId: lucrareId ?? this.lucrareId,
    revizie: revizie ?? this.revizie,
    creataLa: creataLa ?? this.creataLa,
    intrariJson: intrariJson ?? this.intrariJson,
    rezultatJson: rezultatJson ?? this.rezultatJson,
    observatii: observatii ?? this.observatii,
  );
  SolutiiData copyWithCompanion(SolutiiCompanion data) {
    return SolutiiData(
      id: data.id.present ? data.id.value : this.id,
      lucrareId: data.lucrareId.present ? data.lucrareId.value : this.lucrareId,
      revizie: data.revizie.present ? data.revizie.value : this.revizie,
      creataLa: data.creataLa.present ? data.creataLa.value : this.creataLa,
      intrariJson: data.intrariJson.present
          ? data.intrariJson.value
          : this.intrariJson,
      rezultatJson: data.rezultatJson.present
          ? data.rezultatJson.value
          : this.rezultatJson,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SolutiiData(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('revizie: $revizie, ')
          ..write('creataLa: $creataLa, ')
          ..write('intrariJson: $intrariJson, ')
          ..write('rezultatJson: $rezultatJson, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lucrareId,
    revizie,
    creataLa,
    intrariJson,
    rezultatJson,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SolutiiData &&
          other.id == this.id &&
          other.lucrareId == this.lucrareId &&
          other.revizie == this.revizie &&
          other.creataLa == this.creataLa &&
          other.intrariJson == this.intrariJson &&
          other.rezultatJson == this.rezultatJson &&
          other.observatii == this.observatii);
}

class SolutiiCompanion extends UpdateCompanion<SolutiiData> {
  final Value<String> id;
  final Value<String> lucrareId;
  final Value<int> revizie;
  final Value<DateTime> creataLa;
  final Value<String> intrariJson;
  final Value<String> rezultatJson;
  final Value<String> observatii;
  final Value<int> rowid;
  const SolutiiCompanion({
    this.id = const Value.absent(),
    this.lucrareId = const Value.absent(),
    this.revizie = const Value.absent(),
    this.creataLa = const Value.absent(),
    this.intrariJson = const Value.absent(),
    this.rezultatJson = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SolutiiCompanion.insert({
    required String id,
    required String lucrareId,
    required int revizie,
    required DateTime creataLa,
    required String intrariJson,
    required String rezultatJson,
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lucrareId = Value(lucrareId),
       revizie = Value(revizie),
       creataLa = Value(creataLa),
       intrariJson = Value(intrariJson),
       rezultatJson = Value(rezultatJson);
  static Insertable<SolutiiData> custom({
    Expression<String>? id,
    Expression<String>? lucrareId,
    Expression<int>? revizie,
    Expression<DateTime>? creataLa,
    Expression<String>? intrariJson,
    Expression<String>? rezultatJson,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lucrareId != null) 'lucrare_id': lucrareId,
      if (revizie != null) 'revizie': revizie,
      if (creataLa != null) 'creata_la': creataLa,
      if (intrariJson != null) 'intrari_json': intrariJson,
      if (rezultatJson != null) 'rezultat_json': rezultatJson,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SolutiiCompanion copyWith({
    Value<String>? id,
    Value<String>? lucrareId,
    Value<int>? revizie,
    Value<DateTime>? creataLa,
    Value<String>? intrariJson,
    Value<String>? rezultatJson,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return SolutiiCompanion(
      id: id ?? this.id,
      lucrareId: lucrareId ?? this.lucrareId,
      revizie: revizie ?? this.revizie,
      creataLa: creataLa ?? this.creataLa,
      intrariJson: intrariJson ?? this.intrariJson,
      rezultatJson: rezultatJson ?? this.rezultatJson,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lucrareId.present) {
      map['lucrare_id'] = Variable<String>(lucrareId.value);
    }
    if (revizie.present) {
      map['revizie'] = Variable<int>(revizie.value);
    }
    if (creataLa.present) {
      map['creata_la'] = Variable<DateTime>(creataLa.value);
    }
    if (intrariJson.present) {
      map['intrari_json'] = Variable<String>(intrariJson.value);
    }
    if (rezultatJson.present) {
      map['rezultat_json'] = Variable<String>(rezultatJson.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SolutiiCompanion(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('revizie: $revizie, ')
          ..write('creataLa: $creataLa, ')
          ..write('intrariJson: $intrariJson, ')
          ..write('rezultatJson: $rezultatJson, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DocumenteTable extends Documente
    with TableInfo<$DocumenteTable, DocumenteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DocumenteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lucrareIdMeta = const VerificationMeta(
    'lucrareId',
  );
  @override
  late final GeneratedColumn<String> lucrareId = GeneratedColumn<String>(
    'lucrare_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES lucrari (id)',
    ),
  );
  static const VerificationMeta _solutieIdMeta = const VerificationMeta(
    'solutieId',
  );
  @override
  late final GeneratedColumn<String> solutieId = GeneratedColumn<String>(
    'solutie_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _versiuneMeta = const VerificationMeta(
    'versiune',
  );
  @override
  late final GeneratedColumn<int> versiune = GeneratedColumn<int>(
    'versiune',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emisLaMeta = const VerificationMeta('emisLa');
  @override
  late final GeneratedColumn<DateTime> emisLa = GeneratedColumn<DateTime>(
    'emis_la',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _caleMeta = const VerificationMeta('cale');
  @override
  late final GeneratedColumn<String> cale = GeneratedColumn<String>(
    'cale',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sha256Meta = const VerificationMeta('sha256');
  @override
  late final GeneratedColumn<String> sha256 = GeneratedColumn<String>(
    'sha256',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marimeBytesMeta = const VerificationMeta(
    'marimeBytes',
  );
  @override
  late final GeneratedColumn<int> marimeBytes = GeneratedColumn<int>(
    'marime_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    lucrareId,
    solutieId,
    tip,
    versiune,
    emisLa,
    cale,
    sha256,
    marimeBytes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'documente';
  @override
  VerificationContext validateIntegrity(
    Insertable<DocumenteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('lucrare_id')) {
      context.handle(
        _lucrareIdMeta,
        lucrareId.isAcceptableOrUnknown(data['lucrare_id']!, _lucrareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lucrareIdMeta);
    }
    if (data.containsKey('solutie_id')) {
      context.handle(
        _solutieIdMeta,
        solutieId.isAcceptableOrUnknown(data['solutie_id']!, _solutieIdMeta),
      );
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('versiune')) {
      context.handle(
        _versiuneMeta,
        versiune.isAcceptableOrUnknown(data['versiune']!, _versiuneMeta),
      );
    } else if (isInserting) {
      context.missing(_versiuneMeta);
    }
    if (data.containsKey('emis_la')) {
      context.handle(
        _emisLaMeta,
        emisLa.isAcceptableOrUnknown(data['emis_la']!, _emisLaMeta),
      );
    } else if (isInserting) {
      context.missing(_emisLaMeta);
    }
    if (data.containsKey('cale')) {
      context.handle(
        _caleMeta,
        cale.isAcceptableOrUnknown(data['cale']!, _caleMeta),
      );
    } else if (isInserting) {
      context.missing(_caleMeta);
    }
    if (data.containsKey('sha256')) {
      context.handle(
        _sha256Meta,
        sha256.isAcceptableOrUnknown(data['sha256']!, _sha256Meta),
      );
    } else if (isInserting) {
      context.missing(_sha256Meta);
    }
    if (data.containsKey('marime_bytes')) {
      context.handle(
        _marimeBytesMeta,
        marimeBytes.isAcceptableOrUnknown(
          data['marime_bytes']!,
          _marimeBytesMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DocumenteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DocumenteData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      lucrareId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lucrare_id'],
      )!,
      solutieId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}solutie_id'],
      ),
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip'],
      )!,
      versiune: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}versiune'],
      )!,
      emisLa: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}emis_la'],
      )!,
      cale: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cale'],
      )!,
      sha256: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sha256'],
      )!,
      marimeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}marime_bytes'],
      )!,
    );
  }

  @override
  $DocumenteTable createAlias(String alias) {
    return $DocumenteTable(attachedDatabase, alias);
  }
}

class DocumenteData extends DataClass implements Insertable<DocumenteData> {
  final String id;
  final String lucrareId;
  final String? solutieId;
  final String tip;
  final int versiune;
  final DateTime emisLa;
  final String cale;
  final String sha256;
  final int marimeBytes;
  const DocumenteData({
    required this.id,
    required this.lucrareId,
    this.solutieId,
    required this.tip,
    required this.versiune,
    required this.emisLa,
    required this.cale,
    required this.sha256,
    required this.marimeBytes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['lucrare_id'] = Variable<String>(lucrareId);
    if (!nullToAbsent || solutieId != null) {
      map['solutie_id'] = Variable<String>(solutieId);
    }
    map['tip'] = Variable<String>(tip);
    map['versiune'] = Variable<int>(versiune);
    map['emis_la'] = Variable<DateTime>(emisLa);
    map['cale'] = Variable<String>(cale);
    map['sha256'] = Variable<String>(sha256);
    map['marime_bytes'] = Variable<int>(marimeBytes);
    return map;
  }

  DocumenteCompanion toCompanion(bool nullToAbsent) {
    return DocumenteCompanion(
      id: Value(id),
      lucrareId: Value(lucrareId),
      solutieId: solutieId == null && nullToAbsent
          ? const Value.absent()
          : Value(solutieId),
      tip: Value(tip),
      versiune: Value(versiune),
      emisLa: Value(emisLa),
      cale: Value(cale),
      sha256: Value(sha256),
      marimeBytes: Value(marimeBytes),
    );
  }

  factory DocumenteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DocumenteData(
      id: serializer.fromJson<String>(json['id']),
      lucrareId: serializer.fromJson<String>(json['lucrareId']),
      solutieId: serializer.fromJson<String?>(json['solutieId']),
      tip: serializer.fromJson<String>(json['tip']),
      versiune: serializer.fromJson<int>(json['versiune']),
      emisLa: serializer.fromJson<DateTime>(json['emisLa']),
      cale: serializer.fromJson<String>(json['cale']),
      sha256: serializer.fromJson<String>(json['sha256']),
      marimeBytes: serializer.fromJson<int>(json['marimeBytes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'lucrareId': serializer.toJson<String>(lucrareId),
      'solutieId': serializer.toJson<String?>(solutieId),
      'tip': serializer.toJson<String>(tip),
      'versiune': serializer.toJson<int>(versiune),
      'emisLa': serializer.toJson<DateTime>(emisLa),
      'cale': serializer.toJson<String>(cale),
      'sha256': serializer.toJson<String>(sha256),
      'marimeBytes': serializer.toJson<int>(marimeBytes),
    };
  }

  DocumenteData copyWith({
    String? id,
    String? lucrareId,
    Value<String?> solutieId = const Value.absent(),
    String? tip,
    int? versiune,
    DateTime? emisLa,
    String? cale,
    String? sha256,
    int? marimeBytes,
  }) => DocumenteData(
    id: id ?? this.id,
    lucrareId: lucrareId ?? this.lucrareId,
    solutieId: solutieId.present ? solutieId.value : this.solutieId,
    tip: tip ?? this.tip,
    versiune: versiune ?? this.versiune,
    emisLa: emisLa ?? this.emisLa,
    cale: cale ?? this.cale,
    sha256: sha256 ?? this.sha256,
    marimeBytes: marimeBytes ?? this.marimeBytes,
  );
  DocumenteData copyWithCompanion(DocumenteCompanion data) {
    return DocumenteData(
      id: data.id.present ? data.id.value : this.id,
      lucrareId: data.lucrareId.present ? data.lucrareId.value : this.lucrareId,
      solutieId: data.solutieId.present ? data.solutieId.value : this.solutieId,
      tip: data.tip.present ? data.tip.value : this.tip,
      versiune: data.versiune.present ? data.versiune.value : this.versiune,
      emisLa: data.emisLa.present ? data.emisLa.value : this.emisLa,
      cale: data.cale.present ? data.cale.value : this.cale,
      sha256: data.sha256.present ? data.sha256.value : this.sha256,
      marimeBytes: data.marimeBytes.present
          ? data.marimeBytes.value
          : this.marimeBytes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DocumenteData(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('solutieId: $solutieId, ')
          ..write('tip: $tip, ')
          ..write('versiune: $versiune, ')
          ..write('emisLa: $emisLa, ')
          ..write('cale: $cale, ')
          ..write('sha256: $sha256, ')
          ..write('marimeBytes: $marimeBytes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    lucrareId,
    solutieId,
    tip,
    versiune,
    emisLa,
    cale,
    sha256,
    marimeBytes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DocumenteData &&
          other.id == this.id &&
          other.lucrareId == this.lucrareId &&
          other.solutieId == this.solutieId &&
          other.tip == this.tip &&
          other.versiune == this.versiune &&
          other.emisLa == this.emisLa &&
          other.cale == this.cale &&
          other.sha256 == this.sha256 &&
          other.marimeBytes == this.marimeBytes);
}

class DocumenteCompanion extends UpdateCompanion<DocumenteData> {
  final Value<String> id;
  final Value<String> lucrareId;
  final Value<String?> solutieId;
  final Value<String> tip;
  final Value<int> versiune;
  final Value<DateTime> emisLa;
  final Value<String> cale;
  final Value<String> sha256;
  final Value<int> marimeBytes;
  final Value<int> rowid;
  const DocumenteCompanion({
    this.id = const Value.absent(),
    this.lucrareId = const Value.absent(),
    this.solutieId = const Value.absent(),
    this.tip = const Value.absent(),
    this.versiune = const Value.absent(),
    this.emisLa = const Value.absent(),
    this.cale = const Value.absent(),
    this.sha256 = const Value.absent(),
    this.marimeBytes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DocumenteCompanion.insert({
    required String id,
    required String lucrareId,
    this.solutieId = const Value.absent(),
    required String tip,
    required int versiune,
    required DateTime emisLa,
    required String cale,
    required String sha256,
    this.marimeBytes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       lucrareId = Value(lucrareId),
       tip = Value(tip),
       versiune = Value(versiune),
       emisLa = Value(emisLa),
       cale = Value(cale),
       sha256 = Value(sha256);
  static Insertable<DocumenteData> custom({
    Expression<String>? id,
    Expression<String>? lucrareId,
    Expression<String>? solutieId,
    Expression<String>? tip,
    Expression<int>? versiune,
    Expression<DateTime>? emisLa,
    Expression<String>? cale,
    Expression<String>? sha256,
    Expression<int>? marimeBytes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lucrareId != null) 'lucrare_id': lucrareId,
      if (solutieId != null) 'solutie_id': solutieId,
      if (tip != null) 'tip': tip,
      if (versiune != null) 'versiune': versiune,
      if (emisLa != null) 'emis_la': emisLa,
      if (cale != null) 'cale': cale,
      if (sha256 != null) 'sha256': sha256,
      if (marimeBytes != null) 'marime_bytes': marimeBytes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DocumenteCompanion copyWith({
    Value<String>? id,
    Value<String>? lucrareId,
    Value<String?>? solutieId,
    Value<String>? tip,
    Value<int>? versiune,
    Value<DateTime>? emisLa,
    Value<String>? cale,
    Value<String>? sha256,
    Value<int>? marimeBytes,
    Value<int>? rowid,
  }) {
    return DocumenteCompanion(
      id: id ?? this.id,
      lucrareId: lucrareId ?? this.lucrareId,
      solutieId: solutieId ?? this.solutieId,
      tip: tip ?? this.tip,
      versiune: versiune ?? this.versiune,
      emisLa: emisLa ?? this.emisLa,
      cale: cale ?? this.cale,
      sha256: sha256 ?? this.sha256,
      marimeBytes: marimeBytes ?? this.marimeBytes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (lucrareId.present) {
      map['lucrare_id'] = Variable<String>(lucrareId.value);
    }
    if (solutieId.present) {
      map['solutie_id'] = Variable<String>(solutieId.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (versiune.present) {
      map['versiune'] = Variable<int>(versiune.value);
    }
    if (emisLa.present) {
      map['emis_la'] = Variable<DateTime>(emisLa.value);
    }
    if (cale.present) {
      map['cale'] = Variable<String>(cale.value);
    }
    if (sha256.present) {
      map['sha256'] = Variable<String>(sha256.value);
    }
    if (marimeBytes.present) {
      map['marime_bytes'] = Variable<int>(marimeBytes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DocumenteCompanion(')
          ..write('id: $id, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('solutieId: $solutieId, ')
          ..write('tip: $tip, ')
          ..write('versiune: $versiune, ')
          ..write('emisLa: $emisLa, ')
          ..write('cale: $cale, ')
          ..write('sha256: $sha256, ')
          ..write('marimeBytes: $marimeBytes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReleveeTable extends Relevee with TableInfo<$ReleveeTable, ReleveeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReleveeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _lucrareIdMeta = const VerificationMeta(
    'lucrareId',
  );
  @override
  late final GeneratedColumn<String> lucrareId = GeneratedColumn<String>(
    'lucrare_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES lucrari (id)',
    ),
  );
  static const VerificationMeta _dataMeta = const VerificationMeta('data');
  @override
  late final GeneratedColumn<DateTime> data = GeneratedColumn<DateTime>(
    'data',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operatorMeta = const VerificationMeta(
    'operator',
  );
  @override
  late final GeneratedColumn<String> operator = GeneratedColumn<String>(
    'operator',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _temperaturaAmbientaCMeta =
      const VerificationMeta('temperaturaAmbientaC');
  @override
  late final GeneratedColumn<double> temperaturaAmbientaC =
      GeneratedColumn<double>(
        'temperatura_ambienta_c',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _zapadaSkKnM2Meta = const VerificationMeta(
    'zapadaSkKnM2',
  );
  @override
  late final GeneratedColumn<double> zapadaSkKnM2 = GeneratedColumn<double>(
    'zapada_sk_kn_m2',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _vantQbKpaMeta = const VerificationMeta(
    'vantQbKpa',
  );
  @override
  late final GeneratedColumn<double> vantQbKpa = GeneratedColumn<double>(
    'vant_qb_kpa',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    lucrareId,
    data,
    operator,
    temperaturaAmbientaC,
    zapadaSkKnM2,
    vantQbKpa,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relevee';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReleveeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('lucrare_id')) {
      context.handle(
        _lucrareIdMeta,
        lucrareId.isAcceptableOrUnknown(data['lucrare_id']!, _lucrareIdMeta),
      );
    } else if (isInserting) {
      context.missing(_lucrareIdMeta);
    }
    if (data.containsKey('data')) {
      context.handle(
        _dataMeta,
        this.data.isAcceptableOrUnknown(data['data']!, _dataMeta),
      );
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('operator')) {
      context.handle(
        _operatorMeta,
        operator.isAcceptableOrUnknown(data['operator']!, _operatorMeta),
      );
    }
    if (data.containsKey('temperatura_ambienta_c')) {
      context.handle(
        _temperaturaAmbientaCMeta,
        temperaturaAmbientaC.isAcceptableOrUnknown(
          data['temperatura_ambienta_c']!,
          _temperaturaAmbientaCMeta,
        ),
      );
    }
    if (data.containsKey('zapada_sk_kn_m2')) {
      context.handle(
        _zapadaSkKnM2Meta,
        zapadaSkKnM2.isAcceptableOrUnknown(
          data['zapada_sk_kn_m2']!,
          _zapadaSkKnM2Meta,
        ),
      );
    }
    if (data.containsKey('vant_qb_kpa')) {
      context.handle(
        _vantQbKpaMeta,
        vantQbKpa.isAcceptableOrUnknown(data['vant_qb_kpa']!, _vantQbKpaMeta),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReleveeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReleveeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      lucrareId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lucrare_id'],
      )!,
      data: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}data'],
      )!,
      operator: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operator'],
      )!,
      temperaturaAmbientaC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperatura_ambienta_c'],
      ),
      zapadaSkKnM2: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}zapada_sk_kn_m2'],
      ),
      vantQbKpa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}vant_qb_kpa'],
      ),
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $ReleveeTable createAlias(String alias) {
    return $ReleveeTable(attachedDatabase, alias);
  }
}

class ReleveeData extends DataClass implements Insertable<ReleveeData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String lucrareId;
  final DateTime data;
  final String operator;
  final double? temperaturaAmbientaC;
  final double? zapadaSkKnM2;
  final double? vantQbKpa;
  final String observatii;
  const ReleveeData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.lucrareId,
    required this.data,
    required this.operator,
    this.temperaturaAmbientaC,
    this.zapadaSkKnM2,
    this.vantQbKpa,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['lucrare_id'] = Variable<String>(lucrareId);
    map['data'] = Variable<DateTime>(data);
    map['operator'] = Variable<String>(operator);
    if (!nullToAbsent || temperaturaAmbientaC != null) {
      map['temperatura_ambienta_c'] = Variable<double>(temperaturaAmbientaC);
    }
    if (!nullToAbsent || zapadaSkKnM2 != null) {
      map['zapada_sk_kn_m2'] = Variable<double>(zapadaSkKnM2);
    }
    if (!nullToAbsent || vantQbKpa != null) {
      map['vant_qb_kpa'] = Variable<double>(vantQbKpa);
    }
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  ReleveeCompanion toCompanion(bool nullToAbsent) {
    return ReleveeCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      lucrareId: Value(lucrareId),
      data: Value(data),
      operator: Value(operator),
      temperaturaAmbientaC: temperaturaAmbientaC == null && nullToAbsent
          ? const Value.absent()
          : Value(temperaturaAmbientaC),
      zapadaSkKnM2: zapadaSkKnM2 == null && nullToAbsent
          ? const Value.absent()
          : Value(zapadaSkKnM2),
      vantQbKpa: vantQbKpa == null && nullToAbsent
          ? const Value.absent()
          : Value(vantQbKpa),
      observatii: Value(observatii),
    );
  }

  factory ReleveeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReleveeData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      lucrareId: serializer.fromJson<String>(json['lucrareId']),
      data: serializer.fromJson<DateTime>(json['data']),
      operator: serializer.fromJson<String>(json['operator']),
      temperaturaAmbientaC: serializer.fromJson<double?>(
        json['temperaturaAmbientaC'],
      ),
      zapadaSkKnM2: serializer.fromJson<double?>(json['zapadaSkKnM2']),
      vantQbKpa: serializer.fromJson<double?>(json['vantQbKpa']),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'lucrareId': serializer.toJson<String>(lucrareId),
      'data': serializer.toJson<DateTime>(data),
      'operator': serializer.toJson<String>(operator),
      'temperaturaAmbientaC': serializer.toJson<double?>(temperaturaAmbientaC),
      'zapadaSkKnM2': serializer.toJson<double?>(zapadaSkKnM2),
      'vantQbKpa': serializer.toJson<double?>(vantQbKpa),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  ReleveeData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? lucrareId,
    DateTime? data,
    String? operator,
    Value<double?> temperaturaAmbientaC = const Value.absent(),
    Value<double?> zapadaSkKnM2 = const Value.absent(),
    Value<double?> vantQbKpa = const Value.absent(),
    String? observatii,
  }) => ReleveeData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    lucrareId: lucrareId ?? this.lucrareId,
    data: data ?? this.data,
    operator: operator ?? this.operator,
    temperaturaAmbientaC: temperaturaAmbientaC.present
        ? temperaturaAmbientaC.value
        : this.temperaturaAmbientaC,
    zapadaSkKnM2: zapadaSkKnM2.present ? zapadaSkKnM2.value : this.zapadaSkKnM2,
    vantQbKpa: vantQbKpa.present ? vantQbKpa.value : this.vantQbKpa,
    observatii: observatii ?? this.observatii,
  );
  ReleveeData copyWithCompanion(ReleveeCompanion data) {
    return ReleveeData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      lucrareId: data.lucrareId.present ? data.lucrareId.value : this.lucrareId,
      data: data.data.present ? data.data.value : this.data,
      operator: data.operator.present ? data.operator.value : this.operator,
      temperaturaAmbientaC: data.temperaturaAmbientaC.present
          ? data.temperaturaAmbientaC.value
          : this.temperaturaAmbientaC,
      zapadaSkKnM2: data.zapadaSkKnM2.present
          ? data.zapadaSkKnM2.value
          : this.zapadaSkKnM2,
      vantQbKpa: data.vantQbKpa.present ? data.vantQbKpa.value : this.vantQbKpa,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReleveeData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('data: $data, ')
          ..write('operator: $operator, ')
          ..write('temperaturaAmbientaC: $temperaturaAmbientaC, ')
          ..write('zapadaSkKnM2: $zapadaSkKnM2, ')
          ..write('vantQbKpa: $vantQbKpa, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    lucrareId,
    data,
    operator,
    temperaturaAmbientaC,
    zapadaSkKnM2,
    vantQbKpa,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReleveeData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.lucrareId == this.lucrareId &&
          other.data == this.data &&
          other.operator == this.operator &&
          other.temperaturaAmbientaC == this.temperaturaAmbientaC &&
          other.zapadaSkKnM2 == this.zapadaSkKnM2 &&
          other.vantQbKpa == this.vantQbKpa &&
          other.observatii == this.observatii);
}

class ReleveeCompanion extends UpdateCompanion<ReleveeData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> lucrareId;
  final Value<DateTime> data;
  final Value<String> operator;
  final Value<double?> temperaturaAmbientaC;
  final Value<double?> zapadaSkKnM2;
  final Value<double?> vantQbKpa;
  final Value<String> observatii;
  final Value<int> rowid;
  const ReleveeCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.lucrareId = const Value.absent(),
    this.data = const Value.absent(),
    this.operator = const Value.absent(),
    this.temperaturaAmbientaC = const Value.absent(),
    this.zapadaSkKnM2 = const Value.absent(),
    this.vantQbKpa = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReleveeCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String lucrareId,
    required DateTime data,
    this.operator = const Value.absent(),
    this.temperaturaAmbientaC = const Value.absent(),
    this.zapadaSkKnM2 = const Value.absent(),
    this.vantQbKpa = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       lucrareId = Value(lucrareId),
       data = Value(data);
  static Insertable<ReleveeData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? lucrareId,
    Expression<DateTime>? data,
    Expression<String>? operator,
    Expression<double>? temperaturaAmbientaC,
    Expression<double>? zapadaSkKnM2,
    Expression<double>? vantQbKpa,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (lucrareId != null) 'lucrare_id': lucrareId,
      if (data != null) 'data': data,
      if (operator != null) 'operator': operator,
      if (temperaturaAmbientaC != null)
        'temperatura_ambienta_c': temperaturaAmbientaC,
      if (zapadaSkKnM2 != null) 'zapada_sk_kn_m2': zapadaSkKnM2,
      if (vantQbKpa != null) 'vant_qb_kpa': vantQbKpa,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReleveeCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? lucrareId,
    Value<DateTime>? data,
    Value<String>? operator,
    Value<double?>? temperaturaAmbientaC,
    Value<double?>? zapadaSkKnM2,
    Value<double?>? vantQbKpa,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return ReleveeCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      lucrareId: lucrareId ?? this.lucrareId,
      data: data ?? this.data,
      operator: operator ?? this.operator,
      temperaturaAmbientaC: temperaturaAmbientaC ?? this.temperaturaAmbientaC,
      zapadaSkKnM2: zapadaSkKnM2 ?? this.zapadaSkKnM2,
      vantQbKpa: vantQbKpa ?? this.vantQbKpa,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (lucrareId.present) {
      map['lucrare_id'] = Variable<String>(lucrareId.value);
    }
    if (data.present) {
      map['data'] = Variable<DateTime>(data.value);
    }
    if (operator.present) {
      map['operator'] = Variable<String>(operator.value);
    }
    if (temperaturaAmbientaC.present) {
      map['temperatura_ambienta_c'] = Variable<double>(
        temperaturaAmbientaC.value,
      );
    }
    if (zapadaSkKnM2.present) {
      map['zapada_sk_kn_m2'] = Variable<double>(zapadaSkKnM2.value);
    }
    if (vantQbKpa.present) {
      map['vant_qb_kpa'] = Variable<double>(vantQbKpa.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReleveeCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('lucrareId: $lucrareId, ')
          ..write('data: $data, ')
          ..write('operator: $operator, ')
          ..write('temperaturaAmbientaC: $temperaturaAmbientaC, ')
          ..write('zapadaSkKnM2: $zapadaSkKnM2, ')
          ..write('vantQbKpa: $vantQbKpa, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlaneMontajTable extends PlaneMontaj
    with TableInfo<$PlaneMontajTable, PlaneMontajData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaneMontajTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _releveuIdMeta = const VerificationMeta(
    'releveuId',
  );
  @override
  late final GeneratedColumn<String> releveuId = GeneratedColumn<String>(
    'releveu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES relevee (id)',
    ),
  );
  static const VerificationMeta _denumireMeta = const VerificationMeta(
    'denumire',
  );
  @override
  late final GeneratedColumn<String> denumire = GeneratedColumn<String>(
    'denumire',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invelitoareMeta = const VerificationMeta(
    'invelitoare',
  );
  @override
  late final GeneratedColumn<String> invelitoare = GeneratedColumn<String>(
    'invelitoare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inclinareGradeMeta = const VerificationMeta(
    'inclinareGrade',
  );
  @override
  late final GeneratedColumn<double> inclinareGrade = GeneratedColumn<double>(
    'inclinare_grade',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _azimutGradeMeta = const VerificationMeta(
    'azimutGrade',
  );
  @override
  late final GeneratedColumn<double> azimutGrade = GeneratedColumn<double>(
    'azimut_grade',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lungimeMMeta = const VerificationMeta(
    'lungimeM',
  );
  @override
  late final GeneratedColumn<double> lungimeM = GeneratedColumn<double>(
    'lungime_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _latimeMMeta = const VerificationMeta(
    'latimeM',
  );
  @override
  late final GeneratedColumn<double> latimeM = GeneratedColumn<double>(
    'latime_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _inaltimeStreasinaMMeta =
      const VerificationMeta('inaltimeStreasinaM');
  @override
  late final GeneratedColumn<double> inaltimeStreasinaM =
      GeneratedColumn<double>(
        'inaltime_streasina_m',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _capriorSectiuneMeta = const VerificationMeta(
    'capriorSectiune',
  );
  @override
  late final GeneratedColumn<String> capriorSectiune = GeneratedColumn<String>(
    'caprior_sectiune',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _capriorInteraxCmMeta = const VerificationMeta(
    'capriorInteraxCm',
  );
  @override
  late final GeneratedColumn<double> capriorInteraxCm = GeneratedColumn<double>(
    'caprior_interax_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _stareMeta = const VerificationMeta('stare');
  @override
  late final GeneratedColumn<String> stare = GeneratedColumn<String>(
    'stare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _factorUmbrireMeta = const VerificationMeta(
    'factorUmbrire',
  );
  @override
  late final GeneratedColumn<double> factorUmbrire = GeneratedColumn<double>(
    'factor_umbrire',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ordineMeta = const VerificationMeta('ordine');
  @override
  late final GeneratedColumn<int> ordine = GeneratedColumn<int>(
    'ordine',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    denumire,
    tip,
    invelitoare,
    inclinareGrade,
    azimutGrade,
    lungimeM,
    latimeM,
    inaltimeStreasinaM,
    capriorSectiune,
    capriorInteraxCm,
    stare,
    factorUmbrire,
    observatii,
    ordine,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'plane_montaj';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlaneMontajData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('releveu_id')) {
      context.handle(
        _releveuIdMeta,
        releveuId.isAcceptableOrUnknown(data['releveu_id']!, _releveuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_releveuIdMeta);
    }
    if (data.containsKey('denumire')) {
      context.handle(
        _denumireMeta,
        denumire.isAcceptableOrUnknown(data['denumire']!, _denumireMeta),
      );
    } else if (isInserting) {
      context.missing(_denumireMeta);
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('invelitoare')) {
      context.handle(
        _invelitoareMeta,
        invelitoare.isAcceptableOrUnknown(
          data['invelitoare']!,
          _invelitoareMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_invelitoareMeta);
    }
    if (data.containsKey('inclinare_grade')) {
      context.handle(
        _inclinareGradeMeta,
        inclinareGrade.isAcceptableOrUnknown(
          data['inclinare_grade']!,
          _inclinareGradeMeta,
        ),
      );
    }
    if (data.containsKey('azimut_grade')) {
      context.handle(
        _azimutGradeMeta,
        azimutGrade.isAcceptableOrUnknown(
          data['azimut_grade']!,
          _azimutGradeMeta,
        ),
      );
    }
    if (data.containsKey('lungime_m')) {
      context.handle(
        _lungimeMMeta,
        lungimeM.isAcceptableOrUnknown(data['lungime_m']!, _lungimeMMeta),
      );
    }
    if (data.containsKey('latime_m')) {
      context.handle(
        _latimeMMeta,
        latimeM.isAcceptableOrUnknown(data['latime_m']!, _latimeMMeta),
      );
    }
    if (data.containsKey('inaltime_streasina_m')) {
      context.handle(
        _inaltimeStreasinaMMeta,
        inaltimeStreasinaM.isAcceptableOrUnknown(
          data['inaltime_streasina_m']!,
          _inaltimeStreasinaMMeta,
        ),
      );
    }
    if (data.containsKey('caprior_sectiune')) {
      context.handle(
        _capriorSectiuneMeta,
        capriorSectiune.isAcceptableOrUnknown(
          data['caprior_sectiune']!,
          _capriorSectiuneMeta,
        ),
      );
    }
    if (data.containsKey('caprior_interax_cm')) {
      context.handle(
        _capriorInteraxCmMeta,
        capriorInteraxCm.isAcceptableOrUnknown(
          data['caprior_interax_cm']!,
          _capriorInteraxCmMeta,
        ),
      );
    }
    if (data.containsKey('stare')) {
      context.handle(
        _stareMeta,
        stare.isAcceptableOrUnknown(data['stare']!, _stareMeta),
      );
    } else if (isInserting) {
      context.missing(_stareMeta);
    }
    if (data.containsKey('factor_umbrire')) {
      context.handle(
        _factorUmbrireMeta,
        factorUmbrire.isAcceptableOrUnknown(
          data['factor_umbrire']!,
          _factorUmbrireMeta,
        ),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    if (data.containsKey('ordine')) {
      context.handle(
        _ordineMeta,
        ordine.isAcceptableOrUnknown(data['ordine']!, _ordineMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaneMontajData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaneMontajData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      releveuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}releveu_id'],
      )!,
      denumire: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}denumire'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip'],
      )!,
      invelitoare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invelitoare'],
      )!,
      inclinareGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}inclinare_grade'],
      )!,
      azimutGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}azimut_grade'],
      )!,
      lungimeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lungime_m'],
      )!,
      latimeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latime_m'],
      )!,
      inaltimeStreasinaM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}inaltime_streasina_m'],
      ),
      capriorSectiune: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}caprior_sectiune'],
      )!,
      capriorInteraxCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}caprior_interax_cm'],
      ),
      stare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stare'],
      )!,
      factorUmbrire: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}factor_umbrire'],
      )!,
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
      ordine: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordine'],
      )!,
    );
  }

  @override
  $PlaneMontajTable createAlias(String alias) {
    return $PlaneMontajTable(attachedDatabase, alias);
  }
}

class PlaneMontajData extends DataClass implements Insertable<PlaneMontajData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String releveuId;
  final String denumire;
  final String tip;
  final String invelitoare;
  final double inclinareGrade;
  final double azimutGrade;
  final double lungimeM;
  final double latimeM;
  final double? inaltimeStreasinaM;
  final String capriorSectiune;
  final double? capriorInteraxCm;
  final String stare;
  final double factorUmbrire;
  final String observatii;
  final int ordine;
  const PlaneMontajData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.releveuId,
    required this.denumire,
    required this.tip,
    required this.invelitoare,
    required this.inclinareGrade,
    required this.azimutGrade,
    required this.lungimeM,
    required this.latimeM,
    this.inaltimeStreasinaM,
    required this.capriorSectiune,
    this.capriorInteraxCm,
    required this.stare,
    required this.factorUmbrire,
    required this.observatii,
    required this.ordine,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['releveu_id'] = Variable<String>(releveuId);
    map['denumire'] = Variable<String>(denumire);
    map['tip'] = Variable<String>(tip);
    map['invelitoare'] = Variable<String>(invelitoare);
    map['inclinare_grade'] = Variable<double>(inclinareGrade);
    map['azimut_grade'] = Variable<double>(azimutGrade);
    map['lungime_m'] = Variable<double>(lungimeM);
    map['latime_m'] = Variable<double>(latimeM);
    if (!nullToAbsent || inaltimeStreasinaM != null) {
      map['inaltime_streasina_m'] = Variable<double>(inaltimeStreasinaM);
    }
    map['caprior_sectiune'] = Variable<String>(capriorSectiune);
    if (!nullToAbsent || capriorInteraxCm != null) {
      map['caprior_interax_cm'] = Variable<double>(capriorInteraxCm);
    }
    map['stare'] = Variable<String>(stare);
    map['factor_umbrire'] = Variable<double>(factorUmbrire);
    map['observatii'] = Variable<String>(observatii);
    map['ordine'] = Variable<int>(ordine);
    return map;
  }

  PlaneMontajCompanion toCompanion(bool nullToAbsent) {
    return PlaneMontajCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      releveuId: Value(releveuId),
      denumire: Value(denumire),
      tip: Value(tip),
      invelitoare: Value(invelitoare),
      inclinareGrade: Value(inclinareGrade),
      azimutGrade: Value(azimutGrade),
      lungimeM: Value(lungimeM),
      latimeM: Value(latimeM),
      inaltimeStreasinaM: inaltimeStreasinaM == null && nullToAbsent
          ? const Value.absent()
          : Value(inaltimeStreasinaM),
      capriorSectiune: Value(capriorSectiune),
      capriorInteraxCm: capriorInteraxCm == null && nullToAbsent
          ? const Value.absent()
          : Value(capriorInteraxCm),
      stare: Value(stare),
      factorUmbrire: Value(factorUmbrire),
      observatii: Value(observatii),
      ordine: Value(ordine),
    );
  }

  factory PlaneMontajData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaneMontajData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      releveuId: serializer.fromJson<String>(json['releveuId']),
      denumire: serializer.fromJson<String>(json['denumire']),
      tip: serializer.fromJson<String>(json['tip']),
      invelitoare: serializer.fromJson<String>(json['invelitoare']),
      inclinareGrade: serializer.fromJson<double>(json['inclinareGrade']),
      azimutGrade: serializer.fromJson<double>(json['azimutGrade']),
      lungimeM: serializer.fromJson<double>(json['lungimeM']),
      latimeM: serializer.fromJson<double>(json['latimeM']),
      inaltimeStreasinaM: serializer.fromJson<double?>(
        json['inaltimeStreasinaM'],
      ),
      capriorSectiune: serializer.fromJson<String>(json['capriorSectiune']),
      capriorInteraxCm: serializer.fromJson<double?>(json['capriorInteraxCm']),
      stare: serializer.fromJson<String>(json['stare']),
      factorUmbrire: serializer.fromJson<double>(json['factorUmbrire']),
      observatii: serializer.fromJson<String>(json['observatii']),
      ordine: serializer.fromJson<int>(json['ordine']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'releveuId': serializer.toJson<String>(releveuId),
      'denumire': serializer.toJson<String>(denumire),
      'tip': serializer.toJson<String>(tip),
      'invelitoare': serializer.toJson<String>(invelitoare),
      'inclinareGrade': serializer.toJson<double>(inclinareGrade),
      'azimutGrade': serializer.toJson<double>(azimutGrade),
      'lungimeM': serializer.toJson<double>(lungimeM),
      'latimeM': serializer.toJson<double>(latimeM),
      'inaltimeStreasinaM': serializer.toJson<double?>(inaltimeStreasinaM),
      'capriorSectiune': serializer.toJson<String>(capriorSectiune),
      'capriorInteraxCm': serializer.toJson<double?>(capriorInteraxCm),
      'stare': serializer.toJson<String>(stare),
      'factorUmbrire': serializer.toJson<double>(factorUmbrire),
      'observatii': serializer.toJson<String>(observatii),
      'ordine': serializer.toJson<int>(ordine),
    };
  }

  PlaneMontajData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? releveuId,
    String? denumire,
    String? tip,
    String? invelitoare,
    double? inclinareGrade,
    double? azimutGrade,
    double? lungimeM,
    double? latimeM,
    Value<double?> inaltimeStreasinaM = const Value.absent(),
    String? capriorSectiune,
    Value<double?> capriorInteraxCm = const Value.absent(),
    String? stare,
    double? factorUmbrire,
    String? observatii,
    int? ordine,
  }) => PlaneMontajData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    releveuId: releveuId ?? this.releveuId,
    denumire: denumire ?? this.denumire,
    tip: tip ?? this.tip,
    invelitoare: invelitoare ?? this.invelitoare,
    inclinareGrade: inclinareGrade ?? this.inclinareGrade,
    azimutGrade: azimutGrade ?? this.azimutGrade,
    lungimeM: lungimeM ?? this.lungimeM,
    latimeM: latimeM ?? this.latimeM,
    inaltimeStreasinaM: inaltimeStreasinaM.present
        ? inaltimeStreasinaM.value
        : this.inaltimeStreasinaM,
    capriorSectiune: capriorSectiune ?? this.capriorSectiune,
    capriorInteraxCm: capriorInteraxCm.present
        ? capriorInteraxCm.value
        : this.capriorInteraxCm,
    stare: stare ?? this.stare,
    factorUmbrire: factorUmbrire ?? this.factorUmbrire,
    observatii: observatii ?? this.observatii,
    ordine: ordine ?? this.ordine,
  );
  PlaneMontajData copyWithCompanion(PlaneMontajCompanion data) {
    return PlaneMontajData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      releveuId: data.releveuId.present ? data.releveuId.value : this.releveuId,
      denumire: data.denumire.present ? data.denumire.value : this.denumire,
      tip: data.tip.present ? data.tip.value : this.tip,
      invelitoare: data.invelitoare.present
          ? data.invelitoare.value
          : this.invelitoare,
      inclinareGrade: data.inclinareGrade.present
          ? data.inclinareGrade.value
          : this.inclinareGrade,
      azimutGrade: data.azimutGrade.present
          ? data.azimutGrade.value
          : this.azimutGrade,
      lungimeM: data.lungimeM.present ? data.lungimeM.value : this.lungimeM,
      latimeM: data.latimeM.present ? data.latimeM.value : this.latimeM,
      inaltimeStreasinaM: data.inaltimeStreasinaM.present
          ? data.inaltimeStreasinaM.value
          : this.inaltimeStreasinaM,
      capriorSectiune: data.capriorSectiune.present
          ? data.capriorSectiune.value
          : this.capriorSectiune,
      capriorInteraxCm: data.capriorInteraxCm.present
          ? data.capriorInteraxCm.value
          : this.capriorInteraxCm,
      stare: data.stare.present ? data.stare.value : this.stare,
      factorUmbrire: data.factorUmbrire.present
          ? data.factorUmbrire.value
          : this.factorUmbrire,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
      ordine: data.ordine.present ? data.ordine.value : this.ordine,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaneMontajData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('denumire: $denumire, ')
          ..write('tip: $tip, ')
          ..write('invelitoare: $invelitoare, ')
          ..write('inclinareGrade: $inclinareGrade, ')
          ..write('azimutGrade: $azimutGrade, ')
          ..write('lungimeM: $lungimeM, ')
          ..write('latimeM: $latimeM, ')
          ..write('inaltimeStreasinaM: $inaltimeStreasinaM, ')
          ..write('capriorSectiune: $capriorSectiune, ')
          ..write('capriorInteraxCm: $capriorInteraxCm, ')
          ..write('stare: $stare, ')
          ..write('factorUmbrire: $factorUmbrire, ')
          ..write('observatii: $observatii, ')
          ..write('ordine: $ordine')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    denumire,
    tip,
    invelitoare,
    inclinareGrade,
    azimutGrade,
    lungimeM,
    latimeM,
    inaltimeStreasinaM,
    capriorSectiune,
    capriorInteraxCm,
    stare,
    factorUmbrire,
    observatii,
    ordine,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaneMontajData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.releveuId == this.releveuId &&
          other.denumire == this.denumire &&
          other.tip == this.tip &&
          other.invelitoare == this.invelitoare &&
          other.inclinareGrade == this.inclinareGrade &&
          other.azimutGrade == this.azimutGrade &&
          other.lungimeM == this.lungimeM &&
          other.latimeM == this.latimeM &&
          other.inaltimeStreasinaM == this.inaltimeStreasinaM &&
          other.capriorSectiune == this.capriorSectiune &&
          other.capriorInteraxCm == this.capriorInteraxCm &&
          other.stare == this.stare &&
          other.factorUmbrire == this.factorUmbrire &&
          other.observatii == this.observatii &&
          other.ordine == this.ordine);
}

class PlaneMontajCompanion extends UpdateCompanion<PlaneMontajData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> releveuId;
  final Value<String> denumire;
  final Value<String> tip;
  final Value<String> invelitoare;
  final Value<double> inclinareGrade;
  final Value<double> azimutGrade;
  final Value<double> lungimeM;
  final Value<double> latimeM;
  final Value<double?> inaltimeStreasinaM;
  final Value<String> capriorSectiune;
  final Value<double?> capriorInteraxCm;
  final Value<String> stare;
  final Value<double> factorUmbrire;
  final Value<String> observatii;
  final Value<int> ordine;
  final Value<int> rowid;
  const PlaneMontajCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.releveuId = const Value.absent(),
    this.denumire = const Value.absent(),
    this.tip = const Value.absent(),
    this.invelitoare = const Value.absent(),
    this.inclinareGrade = const Value.absent(),
    this.azimutGrade = const Value.absent(),
    this.lungimeM = const Value.absent(),
    this.latimeM = const Value.absent(),
    this.inaltimeStreasinaM = const Value.absent(),
    this.capriorSectiune = const Value.absent(),
    this.capriorInteraxCm = const Value.absent(),
    this.stare = const Value.absent(),
    this.factorUmbrire = const Value.absent(),
    this.observatii = const Value.absent(),
    this.ordine = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlaneMontajCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String releveuId,
    required String denumire,
    required String tip,
    required String invelitoare,
    this.inclinareGrade = const Value.absent(),
    this.azimutGrade = const Value.absent(),
    this.lungimeM = const Value.absent(),
    this.latimeM = const Value.absent(),
    this.inaltimeStreasinaM = const Value.absent(),
    this.capriorSectiune = const Value.absent(),
    this.capriorInteraxCm = const Value.absent(),
    required String stare,
    this.factorUmbrire = const Value.absent(),
    this.observatii = const Value.absent(),
    this.ordine = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       releveuId = Value(releveuId),
       denumire = Value(denumire),
       tip = Value(tip),
       invelitoare = Value(invelitoare),
       stare = Value(stare);
  static Insertable<PlaneMontajData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? releveuId,
    Expression<String>? denumire,
    Expression<String>? tip,
    Expression<String>? invelitoare,
    Expression<double>? inclinareGrade,
    Expression<double>? azimutGrade,
    Expression<double>? lungimeM,
    Expression<double>? latimeM,
    Expression<double>? inaltimeStreasinaM,
    Expression<String>? capriorSectiune,
    Expression<double>? capriorInteraxCm,
    Expression<String>? stare,
    Expression<double>? factorUmbrire,
    Expression<String>? observatii,
    Expression<int>? ordine,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (releveuId != null) 'releveu_id': releveuId,
      if (denumire != null) 'denumire': denumire,
      if (tip != null) 'tip': tip,
      if (invelitoare != null) 'invelitoare': invelitoare,
      if (inclinareGrade != null) 'inclinare_grade': inclinareGrade,
      if (azimutGrade != null) 'azimut_grade': azimutGrade,
      if (lungimeM != null) 'lungime_m': lungimeM,
      if (latimeM != null) 'latime_m': latimeM,
      if (inaltimeStreasinaM != null)
        'inaltime_streasina_m': inaltimeStreasinaM,
      if (capriorSectiune != null) 'caprior_sectiune': capriorSectiune,
      if (capriorInteraxCm != null) 'caprior_interax_cm': capriorInteraxCm,
      if (stare != null) 'stare': stare,
      if (factorUmbrire != null) 'factor_umbrire': factorUmbrire,
      if (observatii != null) 'observatii': observatii,
      if (ordine != null) 'ordine': ordine,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlaneMontajCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? releveuId,
    Value<String>? denumire,
    Value<String>? tip,
    Value<String>? invelitoare,
    Value<double>? inclinareGrade,
    Value<double>? azimutGrade,
    Value<double>? lungimeM,
    Value<double>? latimeM,
    Value<double?>? inaltimeStreasinaM,
    Value<String>? capriorSectiune,
    Value<double?>? capriorInteraxCm,
    Value<String>? stare,
    Value<double>? factorUmbrire,
    Value<String>? observatii,
    Value<int>? ordine,
    Value<int>? rowid,
  }) {
    return PlaneMontajCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      releveuId: releveuId ?? this.releveuId,
      denumire: denumire ?? this.denumire,
      tip: tip ?? this.tip,
      invelitoare: invelitoare ?? this.invelitoare,
      inclinareGrade: inclinareGrade ?? this.inclinareGrade,
      azimutGrade: azimutGrade ?? this.azimutGrade,
      lungimeM: lungimeM ?? this.lungimeM,
      latimeM: latimeM ?? this.latimeM,
      inaltimeStreasinaM: inaltimeStreasinaM ?? this.inaltimeStreasinaM,
      capriorSectiune: capriorSectiune ?? this.capriorSectiune,
      capriorInteraxCm: capriorInteraxCm ?? this.capriorInteraxCm,
      stare: stare ?? this.stare,
      factorUmbrire: factorUmbrire ?? this.factorUmbrire,
      observatii: observatii ?? this.observatii,
      ordine: ordine ?? this.ordine,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (releveuId.present) {
      map['releveu_id'] = Variable<String>(releveuId.value);
    }
    if (denumire.present) {
      map['denumire'] = Variable<String>(denumire.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (invelitoare.present) {
      map['invelitoare'] = Variable<String>(invelitoare.value);
    }
    if (inclinareGrade.present) {
      map['inclinare_grade'] = Variable<double>(inclinareGrade.value);
    }
    if (azimutGrade.present) {
      map['azimut_grade'] = Variable<double>(azimutGrade.value);
    }
    if (lungimeM.present) {
      map['lungime_m'] = Variable<double>(lungimeM.value);
    }
    if (latimeM.present) {
      map['latime_m'] = Variable<double>(latimeM.value);
    }
    if (inaltimeStreasinaM.present) {
      map['inaltime_streasina_m'] = Variable<double>(inaltimeStreasinaM.value);
    }
    if (capriorSectiune.present) {
      map['caprior_sectiune'] = Variable<String>(capriorSectiune.value);
    }
    if (capriorInteraxCm.present) {
      map['caprior_interax_cm'] = Variable<double>(capriorInteraxCm.value);
    }
    if (stare.present) {
      map['stare'] = Variable<String>(stare.value);
    }
    if (factorUmbrire.present) {
      map['factor_umbrire'] = Variable<double>(factorUmbrire.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (ordine.present) {
      map['ordine'] = Variable<int>(ordine.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaneMontajCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('denumire: $denumire, ')
          ..write('tip: $tip, ')
          ..write('invelitoare: $invelitoare, ')
          ..write('inclinareGrade: $inclinareGrade, ')
          ..write('azimutGrade: $azimutGrade, ')
          ..write('lungimeM: $lungimeM, ')
          ..write('latimeM: $latimeM, ')
          ..write('inaltimeStreasinaM: $inaltimeStreasinaM, ')
          ..write('capriorSectiune: $capriorSectiune, ')
          ..write('capriorInteraxCm: $capriorInteraxCm, ')
          ..write('stare: $stare, ')
          ..write('factorUmbrire: $factorUmbrire, ')
          ..write('observatii: $observatii, ')
          ..write('ordine: $ordine, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ObstacoleTable extends Obstacole
    with TableInfo<$ObstacoleTable, ObstacoleData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ObstacoleTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _planIdMeta = const VerificationMeta('planId');
  @override
  late final GeneratedColumn<String> planId = GeneratedColumn<String>(
    'plan_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES plane_montaj (id)',
    ),
  );
  static const VerificationMeta _tipMeta = const VerificationMeta('tip');
  @override
  late final GeneratedColumn<String> tip = GeneratedColumn<String>(
    'tip',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _inaltimeMMeta = const VerificationMeta(
    'inaltimeM',
  );
  @override
  late final GeneratedColumn<double> inaltimeM = GeneratedColumn<double>(
    'inaltime_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _distantaMMeta = const VerificationMeta(
    'distantaM',
  );
  @override
  late final GeneratedColumn<double> distantaM = GeneratedColumn<double>(
    'distanta_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _azimutGradeMeta = const VerificationMeta(
    'azimutGrade',
  );
  @override
  late final GeneratedColumn<double> azimutGrade = GeneratedColumn<double>(
    'azimut_grade',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latimeMMeta = const VerificationMeta(
    'latimeM',
  );
  @override
  late final GeneratedColumn<double> latimeM = GeneratedColumn<double>(
    'latime_m',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    planId,
    tip,
    inaltimeM,
    distantaM,
    azimutGrade,
    latimeM,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'obstacole';
  @override
  VerificationContext validateIntegrity(
    Insertable<ObstacoleData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('plan_id')) {
      context.handle(
        _planIdMeta,
        planId.isAcceptableOrUnknown(data['plan_id']!, _planIdMeta),
      );
    } else if (isInserting) {
      context.missing(_planIdMeta);
    }
    if (data.containsKey('tip')) {
      context.handle(
        _tipMeta,
        tip.isAcceptableOrUnknown(data['tip']!, _tipMeta),
      );
    } else if (isInserting) {
      context.missing(_tipMeta);
    }
    if (data.containsKey('inaltime_m')) {
      context.handle(
        _inaltimeMMeta,
        inaltimeM.isAcceptableOrUnknown(data['inaltime_m']!, _inaltimeMMeta),
      );
    }
    if (data.containsKey('distanta_m')) {
      context.handle(
        _distantaMMeta,
        distantaM.isAcceptableOrUnknown(data['distanta_m']!, _distantaMMeta),
      );
    }
    if (data.containsKey('azimut_grade')) {
      context.handle(
        _azimutGradeMeta,
        azimutGrade.isAcceptableOrUnknown(
          data['azimut_grade']!,
          _azimutGradeMeta,
        ),
      );
    }
    if (data.containsKey('latime_m')) {
      context.handle(
        _latimeMMeta,
        latimeM.isAcceptableOrUnknown(data['latime_m']!, _latimeMMeta),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ObstacoleData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ObstacoleData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      planId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plan_id'],
      )!,
      tip: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tip'],
      )!,
      inaltimeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}inaltime_m'],
      )!,
      distantaM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}distanta_m'],
      )!,
      azimutGrade: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}azimut_grade'],
      ),
      latimeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latime_m'],
      ),
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $ObstacoleTable createAlias(String alias) {
    return $ObstacoleTable(attachedDatabase, alias);
  }
}

class ObstacoleData extends DataClass implements Insertable<ObstacoleData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String planId;
  final String tip;
  final double inaltimeM;
  final double distantaM;
  final double? azimutGrade;
  final double? latimeM;
  final String observatii;
  const ObstacoleData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.planId,
    required this.tip,
    required this.inaltimeM,
    required this.distantaM,
    this.azimutGrade,
    this.latimeM,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['plan_id'] = Variable<String>(planId);
    map['tip'] = Variable<String>(tip);
    map['inaltime_m'] = Variable<double>(inaltimeM);
    map['distanta_m'] = Variable<double>(distantaM);
    if (!nullToAbsent || azimutGrade != null) {
      map['azimut_grade'] = Variable<double>(azimutGrade);
    }
    if (!nullToAbsent || latimeM != null) {
      map['latime_m'] = Variable<double>(latimeM);
    }
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  ObstacoleCompanion toCompanion(bool nullToAbsent) {
    return ObstacoleCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      planId: Value(planId),
      tip: Value(tip),
      inaltimeM: Value(inaltimeM),
      distantaM: Value(distantaM),
      azimutGrade: azimutGrade == null && nullToAbsent
          ? const Value.absent()
          : Value(azimutGrade),
      latimeM: latimeM == null && nullToAbsent
          ? const Value.absent()
          : Value(latimeM),
      observatii: Value(observatii),
    );
  }

  factory ObstacoleData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ObstacoleData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      planId: serializer.fromJson<String>(json['planId']),
      tip: serializer.fromJson<String>(json['tip']),
      inaltimeM: serializer.fromJson<double>(json['inaltimeM']),
      distantaM: serializer.fromJson<double>(json['distantaM']),
      azimutGrade: serializer.fromJson<double?>(json['azimutGrade']),
      latimeM: serializer.fromJson<double?>(json['latimeM']),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'planId': serializer.toJson<String>(planId),
      'tip': serializer.toJson<String>(tip),
      'inaltimeM': serializer.toJson<double>(inaltimeM),
      'distantaM': serializer.toJson<double>(distantaM),
      'azimutGrade': serializer.toJson<double?>(azimutGrade),
      'latimeM': serializer.toJson<double?>(latimeM),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  ObstacoleData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? planId,
    String? tip,
    double? inaltimeM,
    double? distantaM,
    Value<double?> azimutGrade = const Value.absent(),
    Value<double?> latimeM = const Value.absent(),
    String? observatii,
  }) => ObstacoleData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    planId: planId ?? this.planId,
    tip: tip ?? this.tip,
    inaltimeM: inaltimeM ?? this.inaltimeM,
    distantaM: distantaM ?? this.distantaM,
    azimutGrade: azimutGrade.present ? azimutGrade.value : this.azimutGrade,
    latimeM: latimeM.present ? latimeM.value : this.latimeM,
    observatii: observatii ?? this.observatii,
  );
  ObstacoleData copyWithCompanion(ObstacoleCompanion data) {
    return ObstacoleData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      planId: data.planId.present ? data.planId.value : this.planId,
      tip: data.tip.present ? data.tip.value : this.tip,
      inaltimeM: data.inaltimeM.present ? data.inaltimeM.value : this.inaltimeM,
      distantaM: data.distantaM.present ? data.distantaM.value : this.distantaM,
      azimutGrade: data.azimutGrade.present
          ? data.azimutGrade.value
          : this.azimutGrade,
      latimeM: data.latimeM.present ? data.latimeM.value : this.latimeM,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ObstacoleData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('planId: $planId, ')
          ..write('tip: $tip, ')
          ..write('inaltimeM: $inaltimeM, ')
          ..write('distantaM: $distantaM, ')
          ..write('azimutGrade: $azimutGrade, ')
          ..write('latimeM: $latimeM, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    planId,
    tip,
    inaltimeM,
    distantaM,
    azimutGrade,
    latimeM,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ObstacoleData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.planId == this.planId &&
          other.tip == this.tip &&
          other.inaltimeM == this.inaltimeM &&
          other.distantaM == this.distantaM &&
          other.azimutGrade == this.azimutGrade &&
          other.latimeM == this.latimeM &&
          other.observatii == this.observatii);
}

class ObstacoleCompanion extends UpdateCompanion<ObstacoleData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> planId;
  final Value<String> tip;
  final Value<double> inaltimeM;
  final Value<double> distantaM;
  final Value<double?> azimutGrade;
  final Value<double?> latimeM;
  final Value<String> observatii;
  final Value<int> rowid;
  const ObstacoleCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.planId = const Value.absent(),
    this.tip = const Value.absent(),
    this.inaltimeM = const Value.absent(),
    this.distantaM = const Value.absent(),
    this.azimutGrade = const Value.absent(),
    this.latimeM = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ObstacoleCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String planId,
    required String tip,
    this.inaltimeM = const Value.absent(),
    this.distantaM = const Value.absent(),
    this.azimutGrade = const Value.absent(),
    this.latimeM = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       planId = Value(planId),
       tip = Value(tip);
  static Insertable<ObstacoleData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? planId,
    Expression<String>? tip,
    Expression<double>? inaltimeM,
    Expression<double>? distantaM,
    Expression<double>? azimutGrade,
    Expression<double>? latimeM,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (planId != null) 'plan_id': planId,
      if (tip != null) 'tip': tip,
      if (inaltimeM != null) 'inaltime_m': inaltimeM,
      if (distantaM != null) 'distanta_m': distantaM,
      if (azimutGrade != null) 'azimut_grade': azimutGrade,
      if (latimeM != null) 'latime_m': latimeM,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ObstacoleCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? planId,
    Value<String>? tip,
    Value<double>? inaltimeM,
    Value<double>? distantaM,
    Value<double?>? azimutGrade,
    Value<double?>? latimeM,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return ObstacoleCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      planId: planId ?? this.planId,
      tip: tip ?? this.tip,
      inaltimeM: inaltimeM ?? this.inaltimeM,
      distantaM: distantaM ?? this.distantaM,
      azimutGrade: azimutGrade ?? this.azimutGrade,
      latimeM: latimeM ?? this.latimeM,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (planId.present) {
      map['plan_id'] = Variable<String>(planId.value);
    }
    if (tip.present) {
      map['tip'] = Variable<String>(tip.value);
    }
    if (inaltimeM.present) {
      map['inaltime_m'] = Variable<double>(inaltimeM.value);
    }
    if (distantaM.present) {
      map['distanta_m'] = Variable<double>(distantaM.value);
    }
    if (azimutGrade.present) {
      map['azimut_grade'] = Variable<double>(azimutGrade.value);
    }
    if (latimeM.present) {
      map['latime_m'] = Variable<double>(latimeM.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ObstacoleCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('planId: $planId, ')
          ..write('tip: $tip, ')
          ..write('inaltimeM: $inaltimeM, ')
          ..write('distantaM: $distantaM, ')
          ..write('azimutGrade: $azimutGrade, ')
          ..write('latimeM: $latimeM, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TablouriExistenteTable extends TablouriExistente
    with TableInfo<$TablouriExistenteTable, TablouriExistenteData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TablouriExistenteTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _releveuIdMeta = const VerificationMeta(
    'releveuId',
  );
  @override
  late final GeneratedColumn<String> releveuId = GeneratedColumn<String>(
    'releveu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES relevee (id)',
    ),
  );
  static const VerificationMeta _pozitiiLibereMeta = const VerificationMeta(
    'pozitiiLibere',
  );
  @override
  late final GeneratedColumn<int> pozitiiLibere = GeneratedColumn<int>(
    'pozitii_libere',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disjunctorGeneralAMeta =
      const VerificationMeta('disjunctorGeneralA');
  @override
  late final GeneratedColumn<int> disjunctorGeneralA = GeneratedColumn<int>(
    'disjunctor_general_a',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _disjunctorCurbaMeta = const VerificationMeta(
    'disjunctorCurba',
  );
  @override
  late final GeneratedColumn<String> disjunctorCurba = GeneratedColumn<String>(
    'disjunctor_curba',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _icuKaMeta = const VerificationMeta('icuKa');
  @override
  late final GeneratedColumn<double> icuKa = GeneratedColumn<double>(
    'icu_ka',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ddrExistentMeta = const VerificationMeta(
    'ddrExistent',
  );
  @override
  late final GeneratedColumn<String> ddrExistent = GeneratedColumn<String>(
    'ddr_existent',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ddrIdnMaMeta = const VerificationMeta(
    'ddrIdnMa',
  );
  @override
  late final GeneratedColumn<int> ddrIdnMa = GeneratedColumn<int>(
    'ddr_idn_ma',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _spdExistentMeta = const VerificationMeta(
    'spdExistent',
  );
  @override
  late final GeneratedColumn<bool> spdExistent = GeneratedColumn<bool>(
    'spd_existent',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("spd_existent" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _baraPeSeparataMeta = const VerificationMeta(
    'baraPeSeparata',
  );
  @override
  late final GeneratedColumn<bool> baraPeSeparata = GeneratedColumn<bool>(
    'bara_pe_separata',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("bara_pe_separata" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sectiuneColoanaMm2Meta =
      const VerificationMeta('sectiuneColoanaMm2');
  @override
  late final GeneratedColumn<double> sectiuneColoanaMm2 =
      GeneratedColumn<double>(
        'sectiune_coloana_mm2',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    pozitiiLibere,
    disjunctorGeneralA,
    disjunctorCurba,
    icuKa,
    ddrExistent,
    ddrIdnMa,
    spdExistent,
    baraPeSeparata,
    sectiuneColoanaMm2,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tablouri_existente';
  @override
  VerificationContext validateIntegrity(
    Insertable<TablouriExistenteData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('releveu_id')) {
      context.handle(
        _releveuIdMeta,
        releveuId.isAcceptableOrUnknown(data['releveu_id']!, _releveuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_releveuIdMeta);
    }
    if (data.containsKey('pozitii_libere')) {
      context.handle(
        _pozitiiLibereMeta,
        pozitiiLibere.isAcceptableOrUnknown(
          data['pozitii_libere']!,
          _pozitiiLibereMeta,
        ),
      );
    }
    if (data.containsKey('disjunctor_general_a')) {
      context.handle(
        _disjunctorGeneralAMeta,
        disjunctorGeneralA.isAcceptableOrUnknown(
          data['disjunctor_general_a']!,
          _disjunctorGeneralAMeta,
        ),
      );
    }
    if (data.containsKey('disjunctor_curba')) {
      context.handle(
        _disjunctorCurbaMeta,
        disjunctorCurba.isAcceptableOrUnknown(
          data['disjunctor_curba']!,
          _disjunctorCurbaMeta,
        ),
      );
    }
    if (data.containsKey('icu_ka')) {
      context.handle(
        _icuKaMeta,
        icuKa.isAcceptableOrUnknown(data['icu_ka']!, _icuKaMeta),
      );
    }
    if (data.containsKey('ddr_existent')) {
      context.handle(
        _ddrExistentMeta,
        ddrExistent.isAcceptableOrUnknown(
          data['ddr_existent']!,
          _ddrExistentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_ddrExistentMeta);
    }
    if (data.containsKey('ddr_idn_ma')) {
      context.handle(
        _ddrIdnMaMeta,
        ddrIdnMa.isAcceptableOrUnknown(data['ddr_idn_ma']!, _ddrIdnMaMeta),
      );
    }
    if (data.containsKey('spd_existent')) {
      context.handle(
        _spdExistentMeta,
        spdExistent.isAcceptableOrUnknown(
          data['spd_existent']!,
          _spdExistentMeta,
        ),
      );
    }
    if (data.containsKey('bara_pe_separata')) {
      context.handle(
        _baraPeSeparataMeta,
        baraPeSeparata.isAcceptableOrUnknown(
          data['bara_pe_separata']!,
          _baraPeSeparataMeta,
        ),
      );
    }
    if (data.containsKey('sectiune_coloana_mm2')) {
      context.handle(
        _sectiuneColoanaMm2Meta,
        sectiuneColoanaMm2.isAcceptableOrUnknown(
          data['sectiune_coloana_mm2']!,
          _sectiuneColoanaMm2Meta,
        ),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TablouriExistenteData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TablouriExistenteData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      releveuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}releveu_id'],
      )!,
      pozitiiLibere: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pozitii_libere'],
      ),
      disjunctorGeneralA: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disjunctor_general_a'],
      ),
      disjunctorCurba: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}disjunctor_curba'],
      )!,
      icuKa: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}icu_ka'],
      ),
      ddrExistent: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ddr_existent'],
      )!,
      ddrIdnMa: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ddr_idn_ma'],
      ),
      spdExistent: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}spd_existent'],
      )!,
      baraPeSeparata: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}bara_pe_separata'],
      )!,
      sectiuneColoanaMm2: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}sectiune_coloana_mm2'],
      ),
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $TablouriExistenteTable createAlias(String alias) {
    return $TablouriExistenteTable(attachedDatabase, alias);
  }
}

class TablouriExistenteData extends DataClass
    implements Insertable<TablouriExistenteData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String releveuId;
  final int? pozitiiLibere;
  final int? disjunctorGeneralA;
  final String disjunctorCurba;
  final double? icuKa;
  final String ddrExistent;
  final int? ddrIdnMa;
  final bool spdExistent;
  final bool baraPeSeparata;
  final double? sectiuneColoanaMm2;
  final String observatii;
  const TablouriExistenteData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.releveuId,
    this.pozitiiLibere,
    this.disjunctorGeneralA,
    required this.disjunctorCurba,
    this.icuKa,
    required this.ddrExistent,
    this.ddrIdnMa,
    required this.spdExistent,
    required this.baraPeSeparata,
    this.sectiuneColoanaMm2,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['releveu_id'] = Variable<String>(releveuId);
    if (!nullToAbsent || pozitiiLibere != null) {
      map['pozitii_libere'] = Variable<int>(pozitiiLibere);
    }
    if (!nullToAbsent || disjunctorGeneralA != null) {
      map['disjunctor_general_a'] = Variable<int>(disjunctorGeneralA);
    }
    map['disjunctor_curba'] = Variable<String>(disjunctorCurba);
    if (!nullToAbsent || icuKa != null) {
      map['icu_ka'] = Variable<double>(icuKa);
    }
    map['ddr_existent'] = Variable<String>(ddrExistent);
    if (!nullToAbsent || ddrIdnMa != null) {
      map['ddr_idn_ma'] = Variable<int>(ddrIdnMa);
    }
    map['spd_existent'] = Variable<bool>(spdExistent);
    map['bara_pe_separata'] = Variable<bool>(baraPeSeparata);
    if (!nullToAbsent || sectiuneColoanaMm2 != null) {
      map['sectiune_coloana_mm2'] = Variable<double>(sectiuneColoanaMm2);
    }
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  TablouriExistenteCompanion toCompanion(bool nullToAbsent) {
    return TablouriExistenteCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      releveuId: Value(releveuId),
      pozitiiLibere: pozitiiLibere == null && nullToAbsent
          ? const Value.absent()
          : Value(pozitiiLibere),
      disjunctorGeneralA: disjunctorGeneralA == null && nullToAbsent
          ? const Value.absent()
          : Value(disjunctorGeneralA),
      disjunctorCurba: Value(disjunctorCurba),
      icuKa: icuKa == null && nullToAbsent
          ? const Value.absent()
          : Value(icuKa),
      ddrExistent: Value(ddrExistent),
      ddrIdnMa: ddrIdnMa == null && nullToAbsent
          ? const Value.absent()
          : Value(ddrIdnMa),
      spdExistent: Value(spdExistent),
      baraPeSeparata: Value(baraPeSeparata),
      sectiuneColoanaMm2: sectiuneColoanaMm2 == null && nullToAbsent
          ? const Value.absent()
          : Value(sectiuneColoanaMm2),
      observatii: Value(observatii),
    );
  }

  factory TablouriExistenteData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TablouriExistenteData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      releveuId: serializer.fromJson<String>(json['releveuId']),
      pozitiiLibere: serializer.fromJson<int?>(json['pozitiiLibere']),
      disjunctorGeneralA: serializer.fromJson<int?>(json['disjunctorGeneralA']),
      disjunctorCurba: serializer.fromJson<String>(json['disjunctorCurba']),
      icuKa: serializer.fromJson<double?>(json['icuKa']),
      ddrExistent: serializer.fromJson<String>(json['ddrExistent']),
      ddrIdnMa: serializer.fromJson<int?>(json['ddrIdnMa']),
      spdExistent: serializer.fromJson<bool>(json['spdExistent']),
      baraPeSeparata: serializer.fromJson<bool>(json['baraPeSeparata']),
      sectiuneColoanaMm2: serializer.fromJson<double?>(
        json['sectiuneColoanaMm2'],
      ),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'releveuId': serializer.toJson<String>(releveuId),
      'pozitiiLibere': serializer.toJson<int?>(pozitiiLibere),
      'disjunctorGeneralA': serializer.toJson<int?>(disjunctorGeneralA),
      'disjunctorCurba': serializer.toJson<String>(disjunctorCurba),
      'icuKa': serializer.toJson<double?>(icuKa),
      'ddrExistent': serializer.toJson<String>(ddrExistent),
      'ddrIdnMa': serializer.toJson<int?>(ddrIdnMa),
      'spdExistent': serializer.toJson<bool>(spdExistent),
      'baraPeSeparata': serializer.toJson<bool>(baraPeSeparata),
      'sectiuneColoanaMm2': serializer.toJson<double?>(sectiuneColoanaMm2),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  TablouriExistenteData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? releveuId,
    Value<int?> pozitiiLibere = const Value.absent(),
    Value<int?> disjunctorGeneralA = const Value.absent(),
    String? disjunctorCurba,
    Value<double?> icuKa = const Value.absent(),
    String? ddrExistent,
    Value<int?> ddrIdnMa = const Value.absent(),
    bool? spdExistent,
    bool? baraPeSeparata,
    Value<double?> sectiuneColoanaMm2 = const Value.absent(),
    String? observatii,
  }) => TablouriExistenteData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    releveuId: releveuId ?? this.releveuId,
    pozitiiLibere: pozitiiLibere.present
        ? pozitiiLibere.value
        : this.pozitiiLibere,
    disjunctorGeneralA: disjunctorGeneralA.present
        ? disjunctorGeneralA.value
        : this.disjunctorGeneralA,
    disjunctorCurba: disjunctorCurba ?? this.disjunctorCurba,
    icuKa: icuKa.present ? icuKa.value : this.icuKa,
    ddrExistent: ddrExistent ?? this.ddrExistent,
    ddrIdnMa: ddrIdnMa.present ? ddrIdnMa.value : this.ddrIdnMa,
    spdExistent: spdExistent ?? this.spdExistent,
    baraPeSeparata: baraPeSeparata ?? this.baraPeSeparata,
    sectiuneColoanaMm2: sectiuneColoanaMm2.present
        ? sectiuneColoanaMm2.value
        : this.sectiuneColoanaMm2,
    observatii: observatii ?? this.observatii,
  );
  TablouriExistenteData copyWithCompanion(TablouriExistenteCompanion data) {
    return TablouriExistenteData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      releveuId: data.releveuId.present ? data.releveuId.value : this.releveuId,
      pozitiiLibere: data.pozitiiLibere.present
          ? data.pozitiiLibere.value
          : this.pozitiiLibere,
      disjunctorGeneralA: data.disjunctorGeneralA.present
          ? data.disjunctorGeneralA.value
          : this.disjunctorGeneralA,
      disjunctorCurba: data.disjunctorCurba.present
          ? data.disjunctorCurba.value
          : this.disjunctorCurba,
      icuKa: data.icuKa.present ? data.icuKa.value : this.icuKa,
      ddrExistent: data.ddrExistent.present
          ? data.ddrExistent.value
          : this.ddrExistent,
      ddrIdnMa: data.ddrIdnMa.present ? data.ddrIdnMa.value : this.ddrIdnMa,
      spdExistent: data.spdExistent.present
          ? data.spdExistent.value
          : this.spdExistent,
      baraPeSeparata: data.baraPeSeparata.present
          ? data.baraPeSeparata.value
          : this.baraPeSeparata,
      sectiuneColoanaMm2: data.sectiuneColoanaMm2.present
          ? data.sectiuneColoanaMm2.value
          : this.sectiuneColoanaMm2,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TablouriExistenteData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('pozitiiLibere: $pozitiiLibere, ')
          ..write('disjunctorGeneralA: $disjunctorGeneralA, ')
          ..write('disjunctorCurba: $disjunctorCurba, ')
          ..write('icuKa: $icuKa, ')
          ..write('ddrExistent: $ddrExistent, ')
          ..write('ddrIdnMa: $ddrIdnMa, ')
          ..write('spdExistent: $spdExistent, ')
          ..write('baraPeSeparata: $baraPeSeparata, ')
          ..write('sectiuneColoanaMm2: $sectiuneColoanaMm2, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    pozitiiLibere,
    disjunctorGeneralA,
    disjunctorCurba,
    icuKa,
    ddrExistent,
    ddrIdnMa,
    spdExistent,
    baraPeSeparata,
    sectiuneColoanaMm2,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TablouriExistenteData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.releveuId == this.releveuId &&
          other.pozitiiLibere == this.pozitiiLibere &&
          other.disjunctorGeneralA == this.disjunctorGeneralA &&
          other.disjunctorCurba == this.disjunctorCurba &&
          other.icuKa == this.icuKa &&
          other.ddrExistent == this.ddrExistent &&
          other.ddrIdnMa == this.ddrIdnMa &&
          other.spdExistent == this.spdExistent &&
          other.baraPeSeparata == this.baraPeSeparata &&
          other.sectiuneColoanaMm2 == this.sectiuneColoanaMm2 &&
          other.observatii == this.observatii);
}

class TablouriExistenteCompanion
    extends UpdateCompanion<TablouriExistenteData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> releveuId;
  final Value<int?> pozitiiLibere;
  final Value<int?> disjunctorGeneralA;
  final Value<String> disjunctorCurba;
  final Value<double?> icuKa;
  final Value<String> ddrExistent;
  final Value<int?> ddrIdnMa;
  final Value<bool> spdExistent;
  final Value<bool> baraPeSeparata;
  final Value<double?> sectiuneColoanaMm2;
  final Value<String> observatii;
  final Value<int> rowid;
  const TablouriExistenteCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.releveuId = const Value.absent(),
    this.pozitiiLibere = const Value.absent(),
    this.disjunctorGeneralA = const Value.absent(),
    this.disjunctorCurba = const Value.absent(),
    this.icuKa = const Value.absent(),
    this.ddrExistent = const Value.absent(),
    this.ddrIdnMa = const Value.absent(),
    this.spdExistent = const Value.absent(),
    this.baraPeSeparata = const Value.absent(),
    this.sectiuneColoanaMm2 = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TablouriExistenteCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String releveuId,
    this.pozitiiLibere = const Value.absent(),
    this.disjunctorGeneralA = const Value.absent(),
    this.disjunctorCurba = const Value.absent(),
    this.icuKa = const Value.absent(),
    required String ddrExistent,
    this.ddrIdnMa = const Value.absent(),
    this.spdExistent = const Value.absent(),
    this.baraPeSeparata = const Value.absent(),
    this.sectiuneColoanaMm2 = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       releveuId = Value(releveuId),
       ddrExistent = Value(ddrExistent);
  static Insertable<TablouriExistenteData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? releveuId,
    Expression<int>? pozitiiLibere,
    Expression<int>? disjunctorGeneralA,
    Expression<String>? disjunctorCurba,
    Expression<double>? icuKa,
    Expression<String>? ddrExistent,
    Expression<int>? ddrIdnMa,
    Expression<bool>? spdExistent,
    Expression<bool>? baraPeSeparata,
    Expression<double>? sectiuneColoanaMm2,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (releveuId != null) 'releveu_id': releveuId,
      if (pozitiiLibere != null) 'pozitii_libere': pozitiiLibere,
      if (disjunctorGeneralA != null)
        'disjunctor_general_a': disjunctorGeneralA,
      if (disjunctorCurba != null) 'disjunctor_curba': disjunctorCurba,
      if (icuKa != null) 'icu_ka': icuKa,
      if (ddrExistent != null) 'ddr_existent': ddrExistent,
      if (ddrIdnMa != null) 'ddr_idn_ma': ddrIdnMa,
      if (spdExistent != null) 'spd_existent': spdExistent,
      if (baraPeSeparata != null) 'bara_pe_separata': baraPeSeparata,
      if (sectiuneColoanaMm2 != null)
        'sectiune_coloana_mm2': sectiuneColoanaMm2,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TablouriExistenteCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? releveuId,
    Value<int?>? pozitiiLibere,
    Value<int?>? disjunctorGeneralA,
    Value<String>? disjunctorCurba,
    Value<double?>? icuKa,
    Value<String>? ddrExistent,
    Value<int?>? ddrIdnMa,
    Value<bool>? spdExistent,
    Value<bool>? baraPeSeparata,
    Value<double?>? sectiuneColoanaMm2,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return TablouriExistenteCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      releveuId: releveuId ?? this.releveuId,
      pozitiiLibere: pozitiiLibere ?? this.pozitiiLibere,
      disjunctorGeneralA: disjunctorGeneralA ?? this.disjunctorGeneralA,
      disjunctorCurba: disjunctorCurba ?? this.disjunctorCurba,
      icuKa: icuKa ?? this.icuKa,
      ddrExistent: ddrExistent ?? this.ddrExistent,
      ddrIdnMa: ddrIdnMa ?? this.ddrIdnMa,
      spdExistent: spdExistent ?? this.spdExistent,
      baraPeSeparata: baraPeSeparata ?? this.baraPeSeparata,
      sectiuneColoanaMm2: sectiuneColoanaMm2 ?? this.sectiuneColoanaMm2,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (releveuId.present) {
      map['releveu_id'] = Variable<String>(releveuId.value);
    }
    if (pozitiiLibere.present) {
      map['pozitii_libere'] = Variable<int>(pozitiiLibere.value);
    }
    if (disjunctorGeneralA.present) {
      map['disjunctor_general_a'] = Variable<int>(disjunctorGeneralA.value);
    }
    if (disjunctorCurba.present) {
      map['disjunctor_curba'] = Variable<String>(disjunctorCurba.value);
    }
    if (icuKa.present) {
      map['icu_ka'] = Variable<double>(icuKa.value);
    }
    if (ddrExistent.present) {
      map['ddr_existent'] = Variable<String>(ddrExistent.value);
    }
    if (ddrIdnMa.present) {
      map['ddr_idn_ma'] = Variable<int>(ddrIdnMa.value);
    }
    if (spdExistent.present) {
      map['spd_existent'] = Variable<bool>(spdExistent.value);
    }
    if (baraPeSeparata.present) {
      map['bara_pe_separata'] = Variable<bool>(baraPeSeparata.value);
    }
    if (sectiuneColoanaMm2.present) {
      map['sectiune_coloana_mm2'] = Variable<double>(sectiuneColoanaMm2.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TablouriExistenteCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('pozitiiLibere: $pozitiiLibere, ')
          ..write('disjunctorGeneralA: $disjunctorGeneralA, ')
          ..write('disjunctorCurba: $disjunctorCurba, ')
          ..write('icuKa: $icuKa, ')
          ..write('ddrExistent: $ddrExistent, ')
          ..write('ddrIdnMa: $ddrIdnMa, ')
          ..write('spdExistent: $spdExistent, ')
          ..write('baraPeSeparata: $baraPeSeparata, ')
          ..write('sectiuneColoanaMm2: $sectiuneColoanaMm2, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TraseeTable extends Trasee with TableInfo<$TraseeTable, TraseeData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TraseeTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _releveuIdMeta = const VerificationMeta(
    'releveuId',
  );
  @override
  late final GeneratedColumn<String> releveuId = GeneratedColumn<String>(
    'releveu_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES relevee (id)',
    ),
  );
  static const VerificationMeta _segmentMeta = const VerificationMeta(
    'segment',
  );
  @override
  late final GeneratedColumn<String> segment = GeneratedColumn<String>(
    'segment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lungimeMMeta = const VerificationMeta(
    'lungimeM',
  );
  @override
  late final GeneratedColumn<double> lungimeM = GeneratedColumn<double>(
    'lungime_m',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _modPozareMeta = const VerificationMeta(
    'modPozare',
  );
  @override
  late final GeneratedColumn<String> modPozare = GeneratedColumn<String>(
    'mod_pozare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('B1'),
  );
  static const VerificationMeta _temperaturaMaximaCMeta =
      const VerificationMeta('temperaturaMaximaC');
  @override
  late final GeneratedColumn<double> temperaturaMaximaC =
      GeneratedColumn<double>(
        'temperatura_maxima_c',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _observatiiMeta = const VerificationMeta(
    'observatii',
  );
  @override
  late final GeneratedColumn<String> observatii = GeneratedColumn<String>(
    'observatii',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    segment,
    lungimeM,
    modPozare,
    temperaturaMaximaC,
    observatii,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trasee';
  @override
  VerificationContext validateIntegrity(
    Insertable<TraseeData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('releveu_id')) {
      context.handle(
        _releveuIdMeta,
        releveuId.isAcceptableOrUnknown(data['releveu_id']!, _releveuIdMeta),
      );
    } else if (isInserting) {
      context.missing(_releveuIdMeta);
    }
    if (data.containsKey('segment')) {
      context.handle(
        _segmentMeta,
        segment.isAcceptableOrUnknown(data['segment']!, _segmentMeta),
      );
    } else if (isInserting) {
      context.missing(_segmentMeta);
    }
    if (data.containsKey('lungime_m')) {
      context.handle(
        _lungimeMMeta,
        lungimeM.isAcceptableOrUnknown(data['lungime_m']!, _lungimeMMeta),
      );
    }
    if (data.containsKey('mod_pozare')) {
      context.handle(
        _modPozareMeta,
        modPozare.isAcceptableOrUnknown(data['mod_pozare']!, _modPozareMeta),
      );
    }
    if (data.containsKey('temperatura_maxima_c')) {
      context.handle(
        _temperaturaMaximaCMeta,
        temperaturaMaximaC.isAcceptableOrUnknown(
          data['temperatura_maxima_c']!,
          _temperaturaMaximaCMeta,
        ),
      );
    }
    if (data.containsKey('observatii')) {
      context.handle(
        _observatiiMeta,
        observatii.isAcceptableOrUnknown(data['observatii']!, _observatiiMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TraseeData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TraseeData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      releveuId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}releveu_id'],
      )!,
      segment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}segment'],
      )!,
      lungimeM: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}lungime_m'],
      )!,
      modPozare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mod_pozare'],
      )!,
      temperaturaMaximaC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}temperatura_maxima_c'],
      ),
      observatii: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observatii'],
      )!,
    );
  }

  @override
  $TraseeTable createAlias(String alias) {
    return $TraseeTable(attachedDatabase, alias);
  }
}

class TraseeData extends DataClass implements Insertable<TraseeData> {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final int version;
  final String releveuId;
  final String segment;
  final double lungimeM;
  final String modPozare;
  final double? temperaturaMaximaC;
  final String observatii;
  const TraseeData({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.version,
    required this.releveuId,
    required this.segment,
    required this.lungimeM,
    required this.modPozare,
    this.temperaturaMaximaC,
    required this.observatii,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    map['version'] = Variable<int>(version);
    map['releveu_id'] = Variable<String>(releveuId);
    map['segment'] = Variable<String>(segment);
    map['lungime_m'] = Variable<double>(lungimeM);
    map['mod_pozare'] = Variable<String>(modPozare);
    if (!nullToAbsent || temperaturaMaximaC != null) {
      map['temperatura_maxima_c'] = Variable<double>(temperaturaMaximaC);
    }
    map['observatii'] = Variable<String>(observatii);
    return map;
  }

  TraseeCompanion toCompanion(bool nullToAbsent) {
    return TraseeCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
      version: Value(version),
      releveuId: Value(releveuId),
      segment: Value(segment),
      lungimeM: Value(lungimeM),
      modPozare: Value(modPozare),
      temperaturaMaximaC: temperaturaMaximaC == null && nullToAbsent
          ? const Value.absent()
          : Value(temperaturaMaximaC),
      observatii: Value(observatii),
    );
  }

  factory TraseeData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TraseeData(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
      version: serializer.fromJson<int>(json['version']),
      releveuId: serializer.fromJson<String>(json['releveuId']),
      segment: serializer.fromJson<String>(json['segment']),
      lungimeM: serializer.fromJson<double>(json['lungimeM']),
      modPozare: serializer.fromJson<String>(json['modPozare']),
      temperaturaMaximaC: serializer.fromJson<double?>(
        json['temperaturaMaximaC'],
      ),
      observatii: serializer.fromJson<String>(json['observatii']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
      'version': serializer.toJson<int>(version),
      'releveuId': serializer.toJson<String>(releveuId),
      'segment': serializer.toJson<String>(segment),
      'lungimeM': serializer.toJson<double>(lungimeM),
      'modPozare': serializer.toJson<String>(modPozare),
      'temperaturaMaximaC': serializer.toJson<double?>(temperaturaMaximaC),
      'observatii': serializer.toJson<String>(observatii),
    };
  }

  TraseeData copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> deletedAt = const Value.absent(),
    int? version,
    String? releveuId,
    String? segment,
    double? lungimeM,
    String? modPozare,
    Value<double?> temperaturaMaximaC = const Value.absent(),
    String? observatii,
  }) => TraseeData(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
    version: version ?? this.version,
    releveuId: releveuId ?? this.releveuId,
    segment: segment ?? this.segment,
    lungimeM: lungimeM ?? this.lungimeM,
    modPozare: modPozare ?? this.modPozare,
    temperaturaMaximaC: temperaturaMaximaC.present
        ? temperaturaMaximaC.value
        : this.temperaturaMaximaC,
    observatii: observatii ?? this.observatii,
  );
  TraseeData copyWithCompanion(TraseeCompanion data) {
    return TraseeData(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
      version: data.version.present ? data.version.value : this.version,
      releveuId: data.releveuId.present ? data.releveuId.value : this.releveuId,
      segment: data.segment.present ? data.segment.value : this.segment,
      lungimeM: data.lungimeM.present ? data.lungimeM.value : this.lungimeM,
      modPozare: data.modPozare.present ? data.modPozare.value : this.modPozare,
      temperaturaMaximaC: data.temperaturaMaximaC.present
          ? data.temperaturaMaximaC.value
          : this.temperaturaMaximaC,
      observatii: data.observatii.present
          ? data.observatii.value
          : this.observatii,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TraseeData(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('segment: $segment, ')
          ..write('lungimeM: $lungimeM, ')
          ..write('modPozare: $modPozare, ')
          ..write('temperaturaMaximaC: $temperaturaMaximaC, ')
          ..write('observatii: $observatii')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    deletedAt,
    version,
    releveuId,
    segment,
    lungimeM,
    modPozare,
    temperaturaMaximaC,
    observatii,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TraseeData &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt &&
          other.version == this.version &&
          other.releveuId == this.releveuId &&
          other.segment == this.segment &&
          other.lungimeM == this.lungimeM &&
          other.modPozare == this.modPozare &&
          other.temperaturaMaximaC == this.temperaturaMaximaC &&
          other.observatii == this.observatii);
}

class TraseeCompanion extends UpdateCompanion<TraseeData> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> version;
  final Value<String> releveuId;
  final Value<String> segment;
  final Value<double> lungimeM;
  final Value<String> modPozare;
  final Value<double?> temperaturaMaximaC;
  final Value<String> observatii;
  final Value<int> rowid;
  const TraseeCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.releveuId = const Value.absent(),
    this.segment = const Value.absent(),
    this.lungimeM = const Value.absent(),
    this.modPozare = const Value.absent(),
    this.temperaturaMaximaC = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TraseeCompanion.insert({
    required String id,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.deletedAt = const Value.absent(),
    this.version = const Value.absent(),
    required String releveuId,
    required String segment,
    this.lungimeM = const Value.absent(),
    this.modPozare = const Value.absent(),
    this.temperaturaMaximaC = const Value.absent(),
    this.observatii = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt),
       releveuId = Value(releveuId),
       segment = Value(segment);
  static Insertable<TraseeData> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? version,
    Expression<String>? releveuId,
    Expression<String>? segment,
    Expression<double>? lungimeM,
    Expression<String>? modPozare,
    Expression<double>? temperaturaMaximaC,
    Expression<String>? observatii,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (version != null) 'version': version,
      if (releveuId != null) 'releveu_id': releveuId,
      if (segment != null) 'segment': segment,
      if (lungimeM != null) 'lungime_m': lungimeM,
      if (modPozare != null) 'mod_pozare': modPozare,
      if (temperaturaMaximaC != null)
        'temperatura_maxima_c': temperaturaMaximaC,
      if (observatii != null) 'observatii': observatii,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TraseeCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? deletedAt,
    Value<int>? version,
    Value<String>? releveuId,
    Value<String>? segment,
    Value<double>? lungimeM,
    Value<String>? modPozare,
    Value<double?>? temperaturaMaximaC,
    Value<String>? observatii,
    Value<int>? rowid,
  }) {
    return TraseeCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      version: version ?? this.version,
      releveuId: releveuId ?? this.releveuId,
      segment: segment ?? this.segment,
      lungimeM: lungimeM ?? this.lungimeM,
      modPozare: modPozare ?? this.modPozare,
      temperaturaMaximaC: temperaturaMaximaC ?? this.temperaturaMaximaC,
      observatii: observatii ?? this.observatii,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (releveuId.present) {
      map['releveu_id'] = Variable<String>(releveuId.value);
    }
    if (segment.present) {
      map['segment'] = Variable<String>(segment.value);
    }
    if (lungimeM.present) {
      map['lungime_m'] = Variable<double>(lungimeM.value);
    }
    if (modPozare.present) {
      map['mod_pozare'] = Variable<String>(modPozare.value);
    }
    if (temperaturaMaximaC.present) {
      map['temperatura_maxima_c'] = Variable<double>(temperaturaMaximaC.value);
    }
    if (observatii.present) {
      map['observatii'] = Variable<String>(observatii.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TraseeCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('version: $version, ')
          ..write('releveuId: $releveuId, ')
          ..write('segment: $segment, ')
          ..write('lungimeM: $lungimeM, ')
          ..write('modPozare: $modPozare, ')
          ..write('temperaturaMaximaC: $temperaturaMaximaC, ')
          ..write('observatii: $observatii, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SetariTable extends Setari with TableInfo<$SetariTable, SetariData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SetariTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _cheieMeta = const VerificationMeta('cheie');
  @override
  late final GeneratedColumn<String> cheie = GeneratedColumn<String>(
    'cheie',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valoareMeta = const VerificationMeta(
    'valoare',
  );
  @override
  late final GeneratedColumn<String> valoare = GeneratedColumn<String>(
    'valoare',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [cheie, valoare];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'setari';
  @override
  VerificationContext validateIntegrity(
    Insertable<SetariData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('cheie')) {
      context.handle(
        _cheieMeta,
        cheie.isAcceptableOrUnknown(data['cheie']!, _cheieMeta),
      );
    } else if (isInserting) {
      context.missing(_cheieMeta);
    }
    if (data.containsKey('valoare')) {
      context.handle(
        _valoareMeta,
        valoare.isAcceptableOrUnknown(data['valoare']!, _valoareMeta),
      );
    } else if (isInserting) {
      context.missing(_valoareMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {cheie};
  @override
  SetariData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SetariData(
      cheie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cheie'],
      )!,
      valoare: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valoare'],
      )!,
    );
  }

  @override
  $SetariTable createAlias(String alias) {
    return $SetariTable(attachedDatabase, alias);
  }
}

class SetariData extends DataClass implements Insertable<SetariData> {
  final String cheie;
  final String valoare;
  const SetariData({required this.cheie, required this.valoare});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['cheie'] = Variable<String>(cheie);
    map['valoare'] = Variable<String>(valoare);
    return map;
  }

  SetariCompanion toCompanion(bool nullToAbsent) {
    return SetariCompanion(cheie: Value(cheie), valoare: Value(valoare));
  }

  factory SetariData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SetariData(
      cheie: serializer.fromJson<String>(json['cheie']),
      valoare: serializer.fromJson<String>(json['valoare']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'cheie': serializer.toJson<String>(cheie),
      'valoare': serializer.toJson<String>(valoare),
    };
  }

  SetariData copyWith({String? cheie, String? valoare}) =>
      SetariData(cheie: cheie ?? this.cheie, valoare: valoare ?? this.valoare);
  SetariData copyWithCompanion(SetariCompanion data) {
    return SetariData(
      cheie: data.cheie.present ? data.cheie.value : this.cheie,
      valoare: data.valoare.present ? data.valoare.value : this.valoare,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SetariData(')
          ..write('cheie: $cheie, ')
          ..write('valoare: $valoare')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(cheie, valoare);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SetariData &&
          other.cheie == this.cheie &&
          other.valoare == this.valoare);
}

class SetariCompanion extends UpdateCompanion<SetariData> {
  final Value<String> cheie;
  final Value<String> valoare;
  final Value<int> rowid;
  const SetariCompanion({
    this.cheie = const Value.absent(),
    this.valoare = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SetariCompanion.insert({
    required String cheie,
    required String valoare,
    this.rowid = const Value.absent(),
  }) : cheie = Value(cheie),
       valoare = Value(valoare);
  static Insertable<SetariData> custom({
    Expression<String>? cheie,
    Expression<String>? valoare,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (cheie != null) 'cheie': cheie,
      if (valoare != null) 'valoare': valoare,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SetariCompanion copyWith({
    Value<String>? cheie,
    Value<String>? valoare,
    Value<int>? rowid,
  }) {
    return SetariCompanion(
      cheie: cheie ?? this.cheie,
      valoare: valoare ?? this.valoare,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (cheie.present) {
      map['cheie'] = Variable<String>(cheie.value);
    }
    if (valoare.present) {
      map['valoare'] = Variable<String>(valoare.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SetariCompanion(')
          ..write('cheie: $cheie, ')
          ..write('valoare: $valoare, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientiTable clienti = $ClientiTable(this);
  late final $LucrariTable lucrari = $LucrariTable(this);
  late final $LucrariStariTable lucrariStari = $LucrariStariTable(this);
  late final $LocuriConsumTable locuriConsum = $LocuriConsumTable(this);
  late final $FurnizoriTable furnizori = $FurnizoriTable(this);
  late final $SolutiiTable solutii = $SolutiiTable(this);
  late final $DocumenteTable documente = $DocumenteTable(this);
  late final $ReleveeTable relevee = $ReleveeTable(this);
  late final $PlaneMontajTable planeMontaj = $PlaneMontajTable(this);
  late final $ObstacoleTable obstacole = $ObstacoleTable(this);
  late final $TablouriExistenteTable tablouriExistente =
      $TablouriExistenteTable(this);
  late final $TraseeTable trasee = $TraseeTable(this);
  late final $SetariTable setari = $SetariTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clienti,
    lucrari,
    lucrariStari,
    locuriConsum,
    furnizori,
    solutii,
    documente,
    relevee,
    planeMontaj,
    obstacole,
    tablouriExistente,
    trasee,
    setari,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$ClientiTableCreateCompanionBuilder =
    ClientiCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String tip,
      required String denumire,
      Value<String> telefon,
      Value<String> email,
      Value<String> adresaCorespondenta,
      Value<String> cui,
      Value<String> regCom,
      Value<String> reprezentantLegal,
      Value<String> furnizorEnergie,
      Value<String> codClientFurnizor,
      Value<String> codPod,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$ClientiTableUpdateCompanionBuilder =
    ClientiCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> tip,
      Value<String> denumire,
      Value<String> telefon,
      Value<String> email,
      Value<String> adresaCorespondenta,
      Value<String> cui,
      Value<String> regCom,
      Value<String> reprezentantLegal,
      Value<String> furnizorEnergie,
      Value<String> codClientFurnizor,
      Value<String> codPod,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$ClientiTableReferences
    extends BaseReferences<_$AppDatabase, $ClientiTable, ClientiData> {
  $$ClientiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LucrariTable, List<LucrariData>>
  _lucrariRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lucrari,
    aliasName: 'clienti__id__lucrari__client_id',
  );

  $$LucrariTableProcessedTableManager get lucrariRefs {
    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.clientId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lucrariRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientiTableFilterComposer
    extends Composer<_$AppDatabase, $ClientiTable> {
  $$ClientiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefon => $composableBuilder(
    column: $table.telefon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adresaCorespondenta => $composableBuilder(
    column: $table.adresaCorespondenta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cui => $composableBuilder(
    column: $table.cui,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get regCom => $composableBuilder(
    column: $table.regCom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reprezentantLegal => $composableBuilder(
    column: $table.reprezentantLegal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codPod => $composableBuilder(
    column: $table.codPod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> lucrariRefs(
    Expression<bool> Function($$LucrariTableFilterComposer f) f,
  ) {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientiTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientiTable> {
  $$ClientiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefon => $composableBuilder(
    column: $table.telefon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adresaCorespondenta => $composableBuilder(
    column: $table.adresaCorespondenta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cui => $composableBuilder(
    column: $table.cui,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get regCom => $composableBuilder(
    column: $table.regCom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reprezentantLegal => $composableBuilder(
    column: $table.reprezentantLegal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codPod => $composableBuilder(
    column: $table.codPod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientiTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientiTable> {
  $$ClientiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<String> get denumire =>
      $composableBuilder(column: $table.denumire, builder: (column) => column);

  GeneratedColumn<String> get telefon =>
      $composableBuilder(column: $table.telefon, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get adresaCorespondenta => $composableBuilder(
    column: $table.adresaCorespondenta,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cui =>
      $composableBuilder(column: $table.cui, builder: (column) => column);

  GeneratedColumn<String> get regCom =>
      $composableBuilder(column: $table.regCom, builder: (column) => column);

  GeneratedColumn<String> get reprezentantLegal => $composableBuilder(
    column: $table.reprezentantLegal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codPod =>
      $composableBuilder(column: $table.codPod, builder: (column) => column);

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  Expression<T> lucrariRefs<T extends Object>(
    Expression<T> Function($$LucrariTableAnnotationComposer a) f,
  ) {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.clientId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientiTable,
          ClientiData,
          $$ClientiTableFilterComposer,
          $$ClientiTableOrderingComposer,
          $$ClientiTableAnnotationComposer,
          $$ClientiTableCreateCompanionBuilder,
          $$ClientiTableUpdateCompanionBuilder,
          (ClientiData, $$ClientiTableReferences),
          ClientiData,
          PrefetchHooks Function({bool lucrariRefs})
        > {
  $$ClientiTableTableManager(_$AppDatabase db, $ClientiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> tip = const Value.absent(),
                Value<String> denumire = const Value.absent(),
                Value<String> telefon = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> adresaCorespondenta = const Value.absent(),
                Value<String> cui = const Value.absent(),
                Value<String> regCom = const Value.absent(),
                Value<String> reprezentantLegal = const Value.absent(),
                Value<String> furnizorEnergie = const Value.absent(),
                Value<String> codClientFurnizor = const Value.absent(),
                Value<String> codPod = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientiCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                tip: tip,
                denumire: denumire,
                telefon: telefon,
                email: email,
                adresaCorespondenta: adresaCorespondenta,
                cui: cui,
                regCom: regCom,
                reprezentantLegal: reprezentantLegal,
                furnizorEnergie: furnizorEnergie,
                codClientFurnizor: codClientFurnizor,
                codPod: codPod,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String tip,
                required String denumire,
                Value<String> telefon = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> adresaCorespondenta = const Value.absent(),
                Value<String> cui = const Value.absent(),
                Value<String> regCom = const Value.absent(),
                Value<String> reprezentantLegal = const Value.absent(),
                Value<String> furnizorEnergie = const Value.absent(),
                Value<String> codClientFurnizor = const Value.absent(),
                Value<String> codPod = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ClientiCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                tip: tip,
                denumire: denumire,
                telefon: telefon,
                email: email,
                adresaCorespondenta: adresaCorespondenta,
                cui: cui,
                regCom: regCom,
                reprezentantLegal: reprezentantLegal,
                furnizorEnergie: furnizorEnergie,
                codClientFurnizor: codClientFurnizor,
                codPod: codPod,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lucrariRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (lucrariRefs) db.lucrari],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (lucrariRefs)
                    await $_getPrefetchedData<
                      ClientiData,
                      $ClientiTable,
                      LucrariData
                    >(
                      currentTable: table,
                      referencedTable: $$ClientiTableReferences
                          ._lucrariRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientiTableReferences(db, table, p0).lucrariRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clientId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientiTable,
      ClientiData,
      $$ClientiTableFilterComposer,
      $$ClientiTableOrderingComposer,
      $$ClientiTableAnnotationComposer,
      $$ClientiTableCreateCompanionBuilder,
      $$ClientiTableUpdateCompanionBuilder,
      (ClientiData, $$ClientiTableReferences),
      ClientiData,
      PrefetchHooks Function({bool lucrariRefs})
    >;
typedef $$LucrariTableCreateCompanionBuilder =
    LucrariCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String nrInregistrare,
      required String clientId,
      required String rolClient,
      required String tipLucrare,
      required String stare,
      Value<String> titlu,
      Value<String> observatii,
      required DateTime deschisaLa,
      Value<int> rowid,
    });
typedef $$LucrariTableUpdateCompanionBuilder =
    LucrariCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> nrInregistrare,
      Value<String> clientId,
      Value<String> rolClient,
      Value<String> tipLucrare,
      Value<String> stare,
      Value<String> titlu,
      Value<String> observatii,
      Value<DateTime> deschisaLa,
      Value<int> rowid,
    });

final class $$LucrariTableReferences
    extends BaseReferences<_$AppDatabase, $LucrariTable, LucrariData> {
  $$LucrariTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientiTable _clientIdTable(_$AppDatabase db) =>
      db.clienti.createAlias('lucrari__client_id__clienti__id');

  $$ClientiTableProcessedTableManager get clientId {
    final $_column = $_itemColumn<String>('client_id')!;

    final manager = $$ClientiTableTableManager(
      $_db,
      $_db.clienti,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clientIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LucrariStariTable, List<LucrariStariData>>
  _lucrariStariRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.lucrariStari,
    aliasName: 'lucrari__id__lucrari_stari__lucrare_id',
  );

  $$LucrariStariTableProcessedTableManager get lucrariStariRefs {
    final manager = $$LucrariStariTableTableManager(
      $_db,
      $_db.lucrariStari,
    ).filter((f) => f.lucrareId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_lucrariStariRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocuriConsumTable, List<LocuriConsumData>>
  _locuriConsumRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.locuriConsum,
    aliasName: 'lucrari__id__locuri_consum__lucrare_id',
  );

  $$LocuriConsumTableProcessedTableManager get locuriConsumRefs {
    final manager = $$LocuriConsumTableTableManager(
      $_db,
      $_db.locuriConsum,
    ).filter((f) => f.lucrareId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_locuriConsumRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SolutiiTable, List<SolutiiData>>
  _solutiiRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.solutii,
    aliasName: 'lucrari__id__solutii__lucrare_id',
  );

  $$SolutiiTableProcessedTableManager get solutiiRefs {
    final manager = $$SolutiiTableTableManager(
      $_db,
      $_db.solutii,
    ).filter((f) => f.lucrareId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_solutiiRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DocumenteTable, List<DocumenteData>>
  _documenteRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.documente,
    aliasName: 'lucrari__id__documente__lucrare_id',
  );

  $$DocumenteTableProcessedTableManager get documenteRefs {
    final manager = $$DocumenteTableTableManager(
      $_db,
      $_db.documente,
    ).filter((f) => f.lucrareId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_documenteRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReleveeTable, List<ReleveeData>>
  _releveeRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.relevee,
    aliasName: 'lucrari__id__relevee__lucrare_id',
  );

  $$ReleveeTableProcessedTableManager get releveeRefs {
    final manager = $$ReleveeTableTableManager(
      $_db,
      $_db.relevee,
    ).filter((f) => f.lucrareId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_releveeRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LucrariTableFilterComposer
    extends Composer<_$AppDatabase, $LucrariTable> {
  $$LucrariTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nrInregistrare => $composableBuilder(
    column: $table.nrInregistrare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rolClient => $composableBuilder(
    column: $table.rolClient,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipLucrare => $composableBuilder(
    column: $table.tipLucrare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stare => $composableBuilder(
    column: $table.stare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get titlu => $composableBuilder(
    column: $table.titlu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deschisaLa => $composableBuilder(
    column: $table.deschisaLa,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientiTableFilterComposer get clientId {
    final $$ClientiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clienti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientiTableFilterComposer(
            $db: $db,
            $table: $db.clienti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> lucrariStariRefs(
    Expression<bool> Function($$LucrariStariTableFilterComposer f) f,
  ) {
    final $$LucrariStariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lucrariStari,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariStariTableFilterComposer(
            $db: $db,
            $table: $db.lucrariStari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> locuriConsumRefs(
    Expression<bool> Function($$LocuriConsumTableFilterComposer f) f,
  ) {
    final $$LocuriConsumTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.locuriConsum,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocuriConsumTableFilterComposer(
            $db: $db,
            $table: $db.locuriConsum,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> solutiiRefs(
    Expression<bool> Function($$SolutiiTableFilterComposer f) f,
  ) {
    final $$SolutiiTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.solutii,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SolutiiTableFilterComposer(
            $db: $db,
            $table: $db.solutii,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> documenteRefs(
    Expression<bool> Function($$DocumenteTableFilterComposer f) f,
  ) {
    final $$DocumenteTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documente,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumenteTableFilterComposer(
            $db: $db,
            $table: $db.documente,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> releveeRefs(
    Expression<bool> Function($$ReleveeTableFilterComposer f) f,
  ) {
    final $$ReleveeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableFilterComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LucrariTableOrderingComposer
    extends Composer<_$AppDatabase, $LucrariTable> {
  $$LucrariTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nrInregistrare => $composableBuilder(
    column: $table.nrInregistrare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rolClient => $composableBuilder(
    column: $table.rolClient,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipLucrare => $composableBuilder(
    column: $table.tipLucrare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stare => $composableBuilder(
    column: $table.stare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get titlu => $composableBuilder(
    column: $table.titlu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deschisaLa => $composableBuilder(
    column: $table.deschisaLa,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientiTableOrderingComposer get clientId {
    final $$ClientiTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clienti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientiTableOrderingComposer(
            $db: $db,
            $table: $db.clienti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LucrariTableAnnotationComposer
    extends Composer<_$AppDatabase, $LucrariTable> {
  $$LucrariTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get nrInregistrare => $composableBuilder(
    column: $table.nrInregistrare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rolClient =>
      $composableBuilder(column: $table.rolClient, builder: (column) => column);

  GeneratedColumn<String> get tipLucrare => $composableBuilder(
    column: $table.tipLucrare,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stare =>
      $composableBuilder(column: $table.stare, builder: (column) => column);

  GeneratedColumn<String> get titlu =>
      $composableBuilder(column: $table.titlu, builder: (column) => column);

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deschisaLa => $composableBuilder(
    column: $table.deschisaLa,
    builder: (column) => column,
  );

  $$ClientiTableAnnotationComposer get clientId {
    final $$ClientiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clientId,
      referencedTable: $db.clienti,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientiTableAnnotationComposer(
            $db: $db,
            $table: $db.clienti,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> lucrariStariRefs<T extends Object>(
    Expression<T> Function($$LucrariStariTableAnnotationComposer a) f,
  ) {
    final $$LucrariStariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.lucrariStari,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariStariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrariStari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> locuriConsumRefs<T extends Object>(
    Expression<T> Function($$LocuriConsumTableAnnotationComposer a) f,
  ) {
    final $$LocuriConsumTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.locuriConsum,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocuriConsumTableAnnotationComposer(
            $db: $db,
            $table: $db.locuriConsum,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> solutiiRefs<T extends Object>(
    Expression<T> Function($$SolutiiTableAnnotationComposer a) f,
  ) {
    final $$SolutiiTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.solutii,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SolutiiTableAnnotationComposer(
            $db: $db,
            $table: $db.solutii,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> documenteRefs<T extends Object>(
    Expression<T> Function($$DocumenteTableAnnotationComposer a) f,
  ) {
    final $$DocumenteTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.documente,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DocumenteTableAnnotationComposer(
            $db: $db,
            $table: $db.documente,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> releveeRefs<T extends Object>(
    Expression<T> Function($$ReleveeTableAnnotationComposer a) f,
  ) {
    final $$ReleveeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.lucrareId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableAnnotationComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LucrariTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LucrariTable,
          LucrariData,
          $$LucrariTableFilterComposer,
          $$LucrariTableOrderingComposer,
          $$LucrariTableAnnotationComposer,
          $$LucrariTableCreateCompanionBuilder,
          $$LucrariTableUpdateCompanionBuilder,
          (LucrariData, $$LucrariTableReferences),
          LucrariData,
          PrefetchHooks Function({
            bool clientId,
            bool lucrariStariRefs,
            bool locuriConsumRefs,
            bool solutiiRefs,
            bool documenteRefs,
            bool releveeRefs,
          })
        > {
  $$LucrariTableTableManager(_$AppDatabase db, $LucrariTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LucrariTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LucrariTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LucrariTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> nrInregistrare = const Value.absent(),
                Value<String> clientId = const Value.absent(),
                Value<String> rolClient = const Value.absent(),
                Value<String> tipLucrare = const Value.absent(),
                Value<String> stare = const Value.absent(),
                Value<String> titlu = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<DateTime> deschisaLa = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LucrariCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                nrInregistrare: nrInregistrare,
                clientId: clientId,
                rolClient: rolClient,
                tipLucrare: tipLucrare,
                stare: stare,
                titlu: titlu,
                observatii: observatii,
                deschisaLa: deschisaLa,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String nrInregistrare,
                required String clientId,
                required String rolClient,
                required String tipLucrare,
                required String stare,
                Value<String> titlu = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                required DateTime deschisaLa,
                Value<int> rowid = const Value.absent(),
              }) => LucrariCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                nrInregistrare: nrInregistrare,
                clientId: clientId,
                rolClient: rolClient,
                tipLucrare: tipLucrare,
                stare: stare,
                titlu: titlu,
                observatii: observatii,
                deschisaLa: deschisaLa,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LucrariTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                clientId = false,
                lucrariStariRefs = false,
                locuriConsumRefs = false,
                solutiiRefs = false,
                documenteRefs = false,
                releveeRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (lucrariStariRefs) db.lucrariStari,
                    if (locuriConsumRefs) db.locuriConsum,
                    if (solutiiRefs) db.solutii,
                    if (documenteRefs) db.documente,
                    if (releveeRefs) db.relevee,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clientId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clientId,
                                    referencedTable: $$LucrariTableReferences
                                        ._clientIdTable(db),
                                    referencedColumn: $$LucrariTableReferences
                                        ._clientIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (lucrariStariRefs)
                        await $_getPrefetchedData<
                          LucrariData,
                          $LucrariTable,
                          LucrariStariData
                        >(
                          currentTable: table,
                          referencedTable: $$LucrariTableReferences
                              ._lucrariStariRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LucrariTableReferences(
                                db,
                                table,
                                p0,
                              ).lucrariStariRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lucrareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (locuriConsumRefs)
                        await $_getPrefetchedData<
                          LucrariData,
                          $LucrariTable,
                          LocuriConsumData
                        >(
                          currentTable: table,
                          referencedTable: $$LucrariTableReferences
                              ._locuriConsumRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LucrariTableReferences(
                                db,
                                table,
                                p0,
                              ).locuriConsumRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lucrareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (solutiiRefs)
                        await $_getPrefetchedData<
                          LucrariData,
                          $LucrariTable,
                          SolutiiData
                        >(
                          currentTable: table,
                          referencedTable: $$LucrariTableReferences
                              ._solutiiRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LucrariTableReferences(
                                db,
                                table,
                                p0,
                              ).solutiiRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lucrareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (documenteRefs)
                        await $_getPrefetchedData<
                          LucrariData,
                          $LucrariTable,
                          DocumenteData
                        >(
                          currentTable: table,
                          referencedTable: $$LucrariTableReferences
                              ._documenteRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LucrariTableReferences(
                                db,
                                table,
                                p0,
                              ).documenteRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lucrareId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (releveeRefs)
                        await $_getPrefetchedData<
                          LucrariData,
                          $LucrariTable,
                          ReleveeData
                        >(
                          currentTable: table,
                          referencedTable: $$LucrariTableReferences
                              ._releveeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LucrariTableReferences(
                                db,
                                table,
                                p0,
                              ).releveeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.lucrareId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LucrariTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LucrariTable,
      LucrariData,
      $$LucrariTableFilterComposer,
      $$LucrariTableOrderingComposer,
      $$LucrariTableAnnotationComposer,
      $$LucrariTableCreateCompanionBuilder,
      $$LucrariTableUpdateCompanionBuilder,
      (LucrariData, $$LucrariTableReferences),
      LucrariData,
      PrefetchHooks Function({
        bool clientId,
        bool lucrariStariRefs,
        bool locuriConsumRefs,
        bool solutiiRefs,
        bool documenteRefs,
        bool releveeRefs,
      })
    >;
typedef $$LucrariStariTableCreateCompanionBuilder =
    LucrariStariCompanion Function({
      required String id,
      required String lucrareId,
      Value<String?> stareDin,
      required String stareIn,
      required DateTime la,
      Value<String> deCatre,
      Value<String> observatie,
      Value<int> rowid,
    });
typedef $$LucrariStariTableUpdateCompanionBuilder =
    LucrariStariCompanion Function({
      Value<String> id,
      Value<String> lucrareId,
      Value<String?> stareDin,
      Value<String> stareIn,
      Value<DateTime> la,
      Value<String> deCatre,
      Value<String> observatie,
      Value<int> rowid,
    });

final class $$LucrariStariTableReferences
    extends
        BaseReferences<_$AppDatabase, $LucrariStariTable, LucrariStariData> {
  $$LucrariStariTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LucrariTable _lucrareIdTable(_$AppDatabase db) =>
      db.lucrari.createAlias('lucrari_stari__lucrare_id__lucrari__id');

  $$LucrariTableProcessedTableManager get lucrareId {
    final $_column = $_itemColumn<String>('lucrare_id')!;

    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lucrareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LucrariStariTableFilterComposer
    extends Composer<_$AppDatabase, $LucrariStariTable> {
  $$LucrariStariTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stareDin => $composableBuilder(
    column: $table.stareDin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stareIn => $composableBuilder(
    column: $table.stareIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get la => $composableBuilder(
    column: $table.la,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deCatre => $composableBuilder(
    column: $table.deCatre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatie => $composableBuilder(
    column: $table.observatie,
    builder: (column) => ColumnFilters(column),
  );

  $$LucrariTableFilterComposer get lucrareId {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LucrariStariTableOrderingComposer
    extends Composer<_$AppDatabase, $LucrariStariTable> {
  $$LucrariStariTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stareDin => $composableBuilder(
    column: $table.stareDin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stareIn => $composableBuilder(
    column: $table.stareIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get la => $composableBuilder(
    column: $table.la,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deCatre => $composableBuilder(
    column: $table.deCatre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatie => $composableBuilder(
    column: $table.observatie,
    builder: (column) => ColumnOrderings(column),
  );

  $$LucrariTableOrderingComposer get lucrareId {
    final $$LucrariTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableOrderingComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LucrariStariTableAnnotationComposer
    extends Composer<_$AppDatabase, $LucrariStariTable> {
  $$LucrariStariTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get stareDin =>
      $composableBuilder(column: $table.stareDin, builder: (column) => column);

  GeneratedColumn<String> get stareIn =>
      $composableBuilder(column: $table.stareIn, builder: (column) => column);

  GeneratedColumn<DateTime> get la =>
      $composableBuilder(column: $table.la, builder: (column) => column);

  GeneratedColumn<String> get deCatre =>
      $composableBuilder(column: $table.deCatre, builder: (column) => column);

  GeneratedColumn<String> get observatie => $composableBuilder(
    column: $table.observatie,
    builder: (column) => column,
  );

  $$LucrariTableAnnotationComposer get lucrareId {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LucrariStariTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LucrariStariTable,
          LucrariStariData,
          $$LucrariStariTableFilterComposer,
          $$LucrariStariTableOrderingComposer,
          $$LucrariStariTableAnnotationComposer,
          $$LucrariStariTableCreateCompanionBuilder,
          $$LucrariStariTableUpdateCompanionBuilder,
          (LucrariStariData, $$LucrariStariTableReferences),
          LucrariStariData,
          PrefetchHooks Function({bool lucrareId})
        > {
  $$LucrariStariTableTableManager(_$AppDatabase db, $LucrariStariTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LucrariStariTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LucrariStariTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LucrariStariTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lucrareId = const Value.absent(),
                Value<String?> stareDin = const Value.absent(),
                Value<String> stareIn = const Value.absent(),
                Value<DateTime> la = const Value.absent(),
                Value<String> deCatre = const Value.absent(),
                Value<String> observatie = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LucrariStariCompanion(
                id: id,
                lucrareId: lucrareId,
                stareDin: stareDin,
                stareIn: stareIn,
                la: la,
                deCatre: deCatre,
                observatie: observatie,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lucrareId,
                Value<String?> stareDin = const Value.absent(),
                required String stareIn,
                required DateTime la,
                Value<String> deCatre = const Value.absent(),
                Value<String> observatie = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LucrariStariCompanion.insert(
                id: id,
                lucrareId: lucrareId,
                stareDin: stareDin,
                stareIn: stareIn,
                la: la,
                deCatre: deCatre,
                observatie: observatie,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LucrariStariTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lucrareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lucrareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lucrareId,
                                referencedTable: $$LucrariStariTableReferences
                                    ._lucrareIdTable(db),
                                referencedColumn: $$LucrariStariTableReferences
                                    ._lucrareIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LucrariStariTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LucrariStariTable,
      LucrariStariData,
      $$LucrariStariTableFilterComposer,
      $$LucrariStariTableOrderingComposer,
      $$LucrariStariTableAnnotationComposer,
      $$LucrariStariTableCreateCompanionBuilder,
      $$LucrariStariTableUpdateCompanionBuilder,
      (LucrariStariData, $$LucrariStariTableReferences),
      LucrariStariData,
      PrefetchHooks Function({bool lucrareId})
    >;
typedef $$LocuriConsumTableCreateCompanionBuilder =
    LocuriConsumCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String lucrareId,
      Value<String> adresa,
      Value<String> judet,
      Value<String> localitate,
      Value<double?> lat,
      Value<double?> lon,
      required String operatorDistributie,
      Value<String> codPod,
      Value<String> furnizorEnergie,
      Value<String> codClientFurnizor,
      required String nivelTensiune,
      required String bransament,
      Value<double?> putereAprobataKva,
      Value<double?> putereContractataKw,
      Value<int?> disjunctorGeneralA,
      required String schemaLegarePamant,
      Value<bool> prizaPamantProprie,
      required String contorTip,
      Value<String> contorSerie,
      Value<bool> contorBidirectional,
      required String destinatieCladire,
      Value<int?> anConstructie,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$LocuriConsumTableUpdateCompanionBuilder =
    LocuriConsumCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> lucrareId,
      Value<String> adresa,
      Value<String> judet,
      Value<String> localitate,
      Value<double?> lat,
      Value<double?> lon,
      Value<String> operatorDistributie,
      Value<String> codPod,
      Value<String> furnizorEnergie,
      Value<String> codClientFurnizor,
      Value<String> nivelTensiune,
      Value<String> bransament,
      Value<double?> putereAprobataKva,
      Value<double?> putereContractataKw,
      Value<int?> disjunctorGeneralA,
      Value<String> schemaLegarePamant,
      Value<bool> prizaPamantProprie,
      Value<String> contorTip,
      Value<String> contorSerie,
      Value<bool> contorBidirectional,
      Value<String> destinatieCladire,
      Value<int?> anConstructie,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$LocuriConsumTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocuriConsumTable, LocuriConsumData> {
  $$LocuriConsumTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LucrariTable _lucrareIdTable(_$AppDatabase db) =>
      db.lucrari.createAlias('locuri_consum__lucrare_id__lucrari__id');

  $$LucrariTableProcessedTableManager get lucrareId {
    final $_column = $_itemColumn<String>('lucrare_id')!;

    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lucrareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocuriConsumTableFilterComposer
    extends Composer<_$AppDatabase, $LocuriConsumTable> {
  $$LocuriConsumTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get adresa => $composableBuilder(
    column: $table.adresa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get judet => $composableBuilder(
    column: $table.judet,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localitate => $composableBuilder(
    column: $table.localitate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operatorDistributie => $composableBuilder(
    column: $table.operatorDistributie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codPod => $composableBuilder(
    column: $table.codPod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nivelTensiune => $composableBuilder(
    column: $table.nivelTensiune,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bransament => $composableBuilder(
    column: $table.bransament,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get putereAprobataKva => $composableBuilder(
    column: $table.putereAprobataKva,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get putereContractataKw => $composableBuilder(
    column: $table.putereContractataKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get schemaLegarePamant => $composableBuilder(
    column: $table.schemaLegarePamant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get prizaPamantProprie => $composableBuilder(
    column: $table.prizaPamantProprie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contorTip => $composableBuilder(
    column: $table.contorTip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contorSerie => $composableBuilder(
    column: $table.contorSerie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get contorBidirectional => $composableBuilder(
    column: $table.contorBidirectional,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get destinatieCladire => $composableBuilder(
    column: $table.destinatieCladire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get anConstructie => $composableBuilder(
    column: $table.anConstructie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$LucrariTableFilterComposer get lucrareId {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocuriConsumTableOrderingComposer
    extends Composer<_$AppDatabase, $LocuriConsumTable> {
  $$LocuriConsumTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get adresa => $composableBuilder(
    column: $table.adresa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get judet => $composableBuilder(
    column: $table.judet,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localitate => $composableBuilder(
    column: $table.localitate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lat => $composableBuilder(
    column: $table.lat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lon => $composableBuilder(
    column: $table.lon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operatorDistributie => $composableBuilder(
    column: $table.operatorDistributie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codPod => $composableBuilder(
    column: $table.codPod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nivelTensiune => $composableBuilder(
    column: $table.nivelTensiune,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bransament => $composableBuilder(
    column: $table.bransament,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get putereAprobataKva => $composableBuilder(
    column: $table.putereAprobataKva,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get putereContractataKw => $composableBuilder(
    column: $table.putereContractataKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get schemaLegarePamant => $composableBuilder(
    column: $table.schemaLegarePamant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get prizaPamantProprie => $composableBuilder(
    column: $table.prizaPamantProprie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contorTip => $composableBuilder(
    column: $table.contorTip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contorSerie => $composableBuilder(
    column: $table.contorSerie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get contorBidirectional => $composableBuilder(
    column: $table.contorBidirectional,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get destinatieCladire => $composableBuilder(
    column: $table.destinatieCladire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get anConstructie => $composableBuilder(
    column: $table.anConstructie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$LucrariTableOrderingComposer get lucrareId {
    final $$LucrariTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableOrderingComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocuriConsumTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocuriConsumTable> {
  $$LocuriConsumTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get adresa =>
      $composableBuilder(column: $table.adresa, builder: (column) => column);

  GeneratedColumn<String> get judet =>
      $composableBuilder(column: $table.judet, builder: (column) => column);

  GeneratedColumn<String> get localitate => $composableBuilder(
    column: $table.localitate,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lat =>
      $composableBuilder(column: $table.lat, builder: (column) => column);

  GeneratedColumn<double> get lon =>
      $composableBuilder(column: $table.lon, builder: (column) => column);

  GeneratedColumn<String> get operatorDistributie => $composableBuilder(
    column: $table.operatorDistributie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codPod =>
      $composableBuilder(column: $table.codPod, builder: (column) => column);

  GeneratedColumn<String> get furnizorEnergie => $composableBuilder(
    column: $table.furnizorEnergie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get codClientFurnizor => $composableBuilder(
    column: $table.codClientFurnizor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nivelTensiune => $composableBuilder(
    column: $table.nivelTensiune,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bransament => $composableBuilder(
    column: $table.bransament,
    builder: (column) => column,
  );

  GeneratedColumn<double> get putereAprobataKva => $composableBuilder(
    column: $table.putereAprobataKva,
    builder: (column) => column,
  );

  GeneratedColumn<double> get putereContractataKw => $composableBuilder(
    column: $table.putereContractataKw,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => column,
  );

  GeneratedColumn<String> get schemaLegarePamant => $composableBuilder(
    column: $table.schemaLegarePamant,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get prizaPamantProprie => $composableBuilder(
    column: $table.prizaPamantProprie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contorTip =>
      $composableBuilder(column: $table.contorTip, builder: (column) => column);

  GeneratedColumn<String> get contorSerie => $composableBuilder(
    column: $table.contorSerie,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get contorBidirectional => $composableBuilder(
    column: $table.contorBidirectional,
    builder: (column) => column,
  );

  GeneratedColumn<String> get destinatieCladire => $composableBuilder(
    column: $table.destinatieCladire,
    builder: (column) => column,
  );

  GeneratedColumn<int> get anConstructie => $composableBuilder(
    column: $table.anConstructie,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$LucrariTableAnnotationComposer get lucrareId {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocuriConsumTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocuriConsumTable,
          LocuriConsumData,
          $$LocuriConsumTableFilterComposer,
          $$LocuriConsumTableOrderingComposer,
          $$LocuriConsumTableAnnotationComposer,
          $$LocuriConsumTableCreateCompanionBuilder,
          $$LocuriConsumTableUpdateCompanionBuilder,
          (LocuriConsumData, $$LocuriConsumTableReferences),
          LocuriConsumData,
          PrefetchHooks Function({bool lucrareId})
        > {
  $$LocuriConsumTableTableManager(_$AppDatabase db, $LocuriConsumTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocuriConsumTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocuriConsumTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocuriConsumTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> lucrareId = const Value.absent(),
                Value<String> adresa = const Value.absent(),
                Value<String> judet = const Value.absent(),
                Value<String> localitate = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                Value<String> operatorDistributie = const Value.absent(),
                Value<String> codPod = const Value.absent(),
                Value<String> furnizorEnergie = const Value.absent(),
                Value<String> codClientFurnizor = const Value.absent(),
                Value<String> nivelTensiune = const Value.absent(),
                Value<String> bransament = const Value.absent(),
                Value<double?> putereAprobataKva = const Value.absent(),
                Value<double?> putereContractataKw = const Value.absent(),
                Value<int?> disjunctorGeneralA = const Value.absent(),
                Value<String> schemaLegarePamant = const Value.absent(),
                Value<bool> prizaPamantProprie = const Value.absent(),
                Value<String> contorTip = const Value.absent(),
                Value<String> contorSerie = const Value.absent(),
                Value<bool> contorBidirectional = const Value.absent(),
                Value<String> destinatieCladire = const Value.absent(),
                Value<int?> anConstructie = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocuriConsumCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                lucrareId: lucrareId,
                adresa: adresa,
                judet: judet,
                localitate: localitate,
                lat: lat,
                lon: lon,
                operatorDistributie: operatorDistributie,
                codPod: codPod,
                furnizorEnergie: furnizorEnergie,
                codClientFurnizor: codClientFurnizor,
                nivelTensiune: nivelTensiune,
                bransament: bransament,
                putereAprobataKva: putereAprobataKva,
                putereContractataKw: putereContractataKw,
                disjunctorGeneralA: disjunctorGeneralA,
                schemaLegarePamant: schemaLegarePamant,
                prizaPamantProprie: prizaPamantProprie,
                contorTip: contorTip,
                contorSerie: contorSerie,
                contorBidirectional: contorBidirectional,
                destinatieCladire: destinatieCladire,
                anConstructie: anConstructie,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String lucrareId,
                Value<String> adresa = const Value.absent(),
                Value<String> judet = const Value.absent(),
                Value<String> localitate = const Value.absent(),
                Value<double?> lat = const Value.absent(),
                Value<double?> lon = const Value.absent(),
                required String operatorDistributie,
                Value<String> codPod = const Value.absent(),
                Value<String> furnizorEnergie = const Value.absent(),
                Value<String> codClientFurnizor = const Value.absent(),
                required String nivelTensiune,
                required String bransament,
                Value<double?> putereAprobataKva = const Value.absent(),
                Value<double?> putereContractataKw = const Value.absent(),
                Value<int?> disjunctorGeneralA = const Value.absent(),
                required String schemaLegarePamant,
                Value<bool> prizaPamantProprie = const Value.absent(),
                required String contorTip,
                Value<String> contorSerie = const Value.absent(),
                Value<bool> contorBidirectional = const Value.absent(),
                required String destinatieCladire,
                Value<int?> anConstructie = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocuriConsumCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                lucrareId: lucrareId,
                adresa: adresa,
                judet: judet,
                localitate: localitate,
                lat: lat,
                lon: lon,
                operatorDistributie: operatorDistributie,
                codPod: codPod,
                furnizorEnergie: furnizorEnergie,
                codClientFurnizor: codClientFurnizor,
                nivelTensiune: nivelTensiune,
                bransament: bransament,
                putereAprobataKva: putereAprobataKva,
                putereContractataKw: putereContractataKw,
                disjunctorGeneralA: disjunctorGeneralA,
                schemaLegarePamant: schemaLegarePamant,
                prizaPamantProprie: prizaPamantProprie,
                contorTip: contorTip,
                contorSerie: contorSerie,
                contorBidirectional: contorBidirectional,
                destinatieCladire: destinatieCladire,
                anConstructie: anConstructie,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocuriConsumTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lucrareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lucrareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lucrareId,
                                referencedTable: $$LocuriConsumTableReferences
                                    ._lucrareIdTable(db),
                                referencedColumn: $$LocuriConsumTableReferences
                                    ._lucrareIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocuriConsumTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocuriConsumTable,
      LocuriConsumData,
      $$LocuriConsumTableFilterComposer,
      $$LocuriConsumTableOrderingComposer,
      $$LocuriConsumTableAnnotationComposer,
      $$LocuriConsumTableCreateCompanionBuilder,
      $$LocuriConsumTableUpdateCompanionBuilder,
      (LocuriConsumData, $$LocuriConsumTableReferences),
      LocuriConsumData,
      PrefetchHooks Function({bool lucrareId})
    >;
typedef $$FurnizoriTableCreateCompanionBuilder =
    FurnizoriCompanion Function({
      required String id,
      required String denumire,
      Value<bool> predefinit,
      required DateTime createdAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$FurnizoriTableUpdateCompanionBuilder =
    FurnizoriCompanion Function({
      Value<String> id,
      Value<String> denumire,
      Value<bool> predefinit,
      Value<DateTime> createdAt,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$FurnizoriTableFilterComposer
    extends Composer<_$AppDatabase, $FurnizoriTable> {
  $$FurnizoriTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get predefinit => $composableBuilder(
    column: $table.predefinit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FurnizoriTableOrderingComposer
    extends Composer<_$AppDatabase, $FurnizoriTable> {
  $$FurnizoriTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get predefinit => $composableBuilder(
    column: $table.predefinit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FurnizoriTableAnnotationComposer
    extends Composer<_$AppDatabase, $FurnizoriTable> {
  $$FurnizoriTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get denumire =>
      $composableBuilder(column: $table.denumire, builder: (column) => column);

  GeneratedColumn<bool> get predefinit => $composableBuilder(
    column: $table.predefinit,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$FurnizoriTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FurnizoriTable,
          FurnizoriData,
          $$FurnizoriTableFilterComposer,
          $$FurnizoriTableOrderingComposer,
          $$FurnizoriTableAnnotationComposer,
          $$FurnizoriTableCreateCompanionBuilder,
          $$FurnizoriTableUpdateCompanionBuilder,
          (
            FurnizoriData,
            BaseReferences<_$AppDatabase, $FurnizoriTable, FurnizoriData>,
          ),
          FurnizoriData,
          PrefetchHooks Function()
        > {
  $$FurnizoriTableTableManager(_$AppDatabase db, $FurnizoriTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FurnizoriTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FurnizoriTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FurnizoriTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> denumire = const Value.absent(),
                Value<bool> predefinit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FurnizoriCompanion(
                id: id,
                denumire: denumire,
                predefinit: predefinit,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String denumire,
                Value<bool> predefinit = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FurnizoriCompanion.insert(
                id: id,
                denumire: denumire,
                predefinit: predefinit,
                createdAt: createdAt,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FurnizoriTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FurnizoriTable,
      FurnizoriData,
      $$FurnizoriTableFilterComposer,
      $$FurnizoriTableOrderingComposer,
      $$FurnizoriTableAnnotationComposer,
      $$FurnizoriTableCreateCompanionBuilder,
      $$FurnizoriTableUpdateCompanionBuilder,
      (
        FurnizoriData,
        BaseReferences<_$AppDatabase, $FurnizoriTable, FurnizoriData>,
      ),
      FurnizoriData,
      PrefetchHooks Function()
    >;
typedef $$SolutiiTableCreateCompanionBuilder =
    SolutiiCompanion Function({
      required String id,
      required String lucrareId,
      required int revizie,
      required DateTime creataLa,
      required String intrariJson,
      required String rezultatJson,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$SolutiiTableUpdateCompanionBuilder =
    SolutiiCompanion Function({
      Value<String> id,
      Value<String> lucrareId,
      Value<int> revizie,
      Value<DateTime> creataLa,
      Value<String> intrariJson,
      Value<String> rezultatJson,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$SolutiiTableReferences
    extends BaseReferences<_$AppDatabase, $SolutiiTable, SolutiiData> {
  $$SolutiiTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LucrariTable _lucrareIdTable(_$AppDatabase db) =>
      db.lucrari.createAlias('solutii__lucrare_id__lucrari__id');

  $$LucrariTableProcessedTableManager get lucrareId {
    final $_column = $_itemColumn<String>('lucrare_id')!;

    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lucrareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SolutiiTableFilterComposer
    extends Composer<_$AppDatabase, $SolutiiTable> {
  $$SolutiiTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revizie => $composableBuilder(
    column: $table.revizie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creataLa => $composableBuilder(
    column: $table.creataLa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intrariJson => $composableBuilder(
    column: $table.intrariJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rezultatJson => $composableBuilder(
    column: $table.rezultatJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$LucrariTableFilterComposer get lucrareId {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SolutiiTableOrderingComposer
    extends Composer<_$AppDatabase, $SolutiiTable> {
  $$SolutiiTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revizie => $composableBuilder(
    column: $table.revizie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creataLa => $composableBuilder(
    column: $table.creataLa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intrariJson => $composableBuilder(
    column: $table.intrariJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rezultatJson => $composableBuilder(
    column: $table.rezultatJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$LucrariTableOrderingComposer get lucrareId {
    final $$LucrariTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableOrderingComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SolutiiTableAnnotationComposer
    extends Composer<_$AppDatabase, $SolutiiTable> {
  $$SolutiiTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get revizie =>
      $composableBuilder(column: $table.revizie, builder: (column) => column);

  GeneratedColumn<DateTime> get creataLa =>
      $composableBuilder(column: $table.creataLa, builder: (column) => column);

  GeneratedColumn<String> get intrariJson => $composableBuilder(
    column: $table.intrariJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rezultatJson => $composableBuilder(
    column: $table.rezultatJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$LucrariTableAnnotationComposer get lucrareId {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SolutiiTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SolutiiTable,
          SolutiiData,
          $$SolutiiTableFilterComposer,
          $$SolutiiTableOrderingComposer,
          $$SolutiiTableAnnotationComposer,
          $$SolutiiTableCreateCompanionBuilder,
          $$SolutiiTableUpdateCompanionBuilder,
          (SolutiiData, $$SolutiiTableReferences),
          SolutiiData,
          PrefetchHooks Function({bool lucrareId})
        > {
  $$SolutiiTableTableManager(_$AppDatabase db, $SolutiiTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SolutiiTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SolutiiTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SolutiiTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lucrareId = const Value.absent(),
                Value<int> revizie = const Value.absent(),
                Value<DateTime> creataLa = const Value.absent(),
                Value<String> intrariJson = const Value.absent(),
                Value<String> rezultatJson = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SolutiiCompanion(
                id: id,
                lucrareId: lucrareId,
                revizie: revizie,
                creataLa: creataLa,
                intrariJson: intrariJson,
                rezultatJson: rezultatJson,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lucrareId,
                required int revizie,
                required DateTime creataLa,
                required String intrariJson,
                required String rezultatJson,
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SolutiiCompanion.insert(
                id: id,
                lucrareId: lucrareId,
                revizie: revizie,
                creataLa: creataLa,
                intrariJson: intrariJson,
                rezultatJson: rezultatJson,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SolutiiTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lucrareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lucrareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lucrareId,
                                referencedTable: $$SolutiiTableReferences
                                    ._lucrareIdTable(db),
                                referencedColumn: $$SolutiiTableReferences
                                    ._lucrareIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SolutiiTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SolutiiTable,
      SolutiiData,
      $$SolutiiTableFilterComposer,
      $$SolutiiTableOrderingComposer,
      $$SolutiiTableAnnotationComposer,
      $$SolutiiTableCreateCompanionBuilder,
      $$SolutiiTableUpdateCompanionBuilder,
      (SolutiiData, $$SolutiiTableReferences),
      SolutiiData,
      PrefetchHooks Function({bool lucrareId})
    >;
typedef $$DocumenteTableCreateCompanionBuilder =
    DocumenteCompanion Function({
      required String id,
      required String lucrareId,
      Value<String?> solutieId,
      required String tip,
      required int versiune,
      required DateTime emisLa,
      required String cale,
      required String sha256,
      Value<int> marimeBytes,
      Value<int> rowid,
    });
typedef $$DocumenteTableUpdateCompanionBuilder =
    DocumenteCompanion Function({
      Value<String> id,
      Value<String> lucrareId,
      Value<String?> solutieId,
      Value<String> tip,
      Value<int> versiune,
      Value<DateTime> emisLa,
      Value<String> cale,
      Value<String> sha256,
      Value<int> marimeBytes,
      Value<int> rowid,
    });

final class $$DocumenteTableReferences
    extends BaseReferences<_$AppDatabase, $DocumenteTable, DocumenteData> {
  $$DocumenteTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LucrariTable _lucrareIdTable(_$AppDatabase db) =>
      db.lucrari.createAlias('documente__lucrare_id__lucrari__id');

  $$LucrariTableProcessedTableManager get lucrareId {
    final $_column = $_itemColumn<String>('lucrare_id')!;

    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lucrareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DocumenteTableFilterComposer
    extends Composer<_$AppDatabase, $DocumenteTable> {
  $$DocumenteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get solutieId => $composableBuilder(
    column: $table.solutieId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get versiune => $composableBuilder(
    column: $table.versiune,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get emisLa => $composableBuilder(
    column: $table.emisLa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cale => $composableBuilder(
    column: $table.cale,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get marimeBytes => $composableBuilder(
    column: $table.marimeBytes,
    builder: (column) => ColumnFilters(column),
  );

  $$LucrariTableFilterComposer get lucrareId {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumenteTableOrderingComposer
    extends Composer<_$AppDatabase, $DocumenteTable> {
  $$DocumenteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get solutieId => $composableBuilder(
    column: $table.solutieId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get versiune => $composableBuilder(
    column: $table.versiune,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get emisLa => $composableBuilder(
    column: $table.emisLa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cale => $composableBuilder(
    column: $table.cale,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sha256 => $composableBuilder(
    column: $table.sha256,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get marimeBytes => $composableBuilder(
    column: $table.marimeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  $$LucrariTableOrderingComposer get lucrareId {
    final $$LucrariTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableOrderingComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumenteTableAnnotationComposer
    extends Composer<_$AppDatabase, $DocumenteTable> {
  $$DocumenteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get solutieId =>
      $composableBuilder(column: $table.solutieId, builder: (column) => column);

  GeneratedColumn<String> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<int> get versiune =>
      $composableBuilder(column: $table.versiune, builder: (column) => column);

  GeneratedColumn<DateTime> get emisLa =>
      $composableBuilder(column: $table.emisLa, builder: (column) => column);

  GeneratedColumn<String> get cale =>
      $composableBuilder(column: $table.cale, builder: (column) => column);

  GeneratedColumn<String> get sha256 =>
      $composableBuilder(column: $table.sha256, builder: (column) => column);

  GeneratedColumn<int> get marimeBytes => $composableBuilder(
    column: $table.marimeBytes,
    builder: (column) => column,
  );

  $$LucrariTableAnnotationComposer get lucrareId {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DocumenteTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DocumenteTable,
          DocumenteData,
          $$DocumenteTableFilterComposer,
          $$DocumenteTableOrderingComposer,
          $$DocumenteTableAnnotationComposer,
          $$DocumenteTableCreateCompanionBuilder,
          $$DocumenteTableUpdateCompanionBuilder,
          (DocumenteData, $$DocumenteTableReferences),
          DocumenteData,
          PrefetchHooks Function({bool lucrareId})
        > {
  $$DocumenteTableTableManager(_$AppDatabase db, $DocumenteTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DocumenteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DocumenteTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DocumenteTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> lucrareId = const Value.absent(),
                Value<String?> solutieId = const Value.absent(),
                Value<String> tip = const Value.absent(),
                Value<int> versiune = const Value.absent(),
                Value<DateTime> emisLa = const Value.absent(),
                Value<String> cale = const Value.absent(),
                Value<String> sha256 = const Value.absent(),
                Value<int> marimeBytes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumenteCompanion(
                id: id,
                lucrareId: lucrareId,
                solutieId: solutieId,
                tip: tip,
                versiune: versiune,
                emisLa: emisLa,
                cale: cale,
                sha256: sha256,
                marimeBytes: marimeBytes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String lucrareId,
                Value<String?> solutieId = const Value.absent(),
                required String tip,
                required int versiune,
                required DateTime emisLa,
                required String cale,
                required String sha256,
                Value<int> marimeBytes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DocumenteCompanion.insert(
                id: id,
                lucrareId: lucrareId,
                solutieId: solutieId,
                tip: tip,
                versiune: versiune,
                emisLa: emisLa,
                cale: cale,
                sha256: sha256,
                marimeBytes: marimeBytes,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DocumenteTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({lucrareId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (lucrareId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.lucrareId,
                                referencedTable: $$DocumenteTableReferences
                                    ._lucrareIdTable(db),
                                referencedColumn: $$DocumenteTableReferences
                                    ._lucrareIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DocumenteTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DocumenteTable,
      DocumenteData,
      $$DocumenteTableFilterComposer,
      $$DocumenteTableOrderingComposer,
      $$DocumenteTableAnnotationComposer,
      $$DocumenteTableCreateCompanionBuilder,
      $$DocumenteTableUpdateCompanionBuilder,
      (DocumenteData, $$DocumenteTableReferences),
      DocumenteData,
      PrefetchHooks Function({bool lucrareId})
    >;
typedef $$ReleveeTableCreateCompanionBuilder =
    ReleveeCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String lucrareId,
      required DateTime data,
      Value<String> operator,
      Value<double?> temperaturaAmbientaC,
      Value<double?> zapadaSkKnM2,
      Value<double?> vantQbKpa,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$ReleveeTableUpdateCompanionBuilder =
    ReleveeCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> lucrareId,
      Value<DateTime> data,
      Value<String> operator,
      Value<double?> temperaturaAmbientaC,
      Value<double?> zapadaSkKnM2,
      Value<double?> vantQbKpa,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$ReleveeTableReferences
    extends BaseReferences<_$AppDatabase, $ReleveeTable, ReleveeData> {
  $$ReleveeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LucrariTable _lucrareIdTable(_$AppDatabase db) =>
      db.lucrari.createAlias('relevee__lucrare_id__lucrari__id');

  $$LucrariTableProcessedTableManager get lucrareId {
    final $_column = $_itemColumn<String>('lucrare_id')!;

    final manager = $$LucrariTableTableManager(
      $_db,
      $_db.lucrari,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_lucrareIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlaneMontajTable, List<PlaneMontajData>>
  _planeMontajRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.planeMontaj,
    aliasName: 'relevee__id__plane_montaj__releveu_id',
  );

  $$PlaneMontajTableProcessedTableManager get planeMontajRefs {
    final manager = $$PlaneMontajTableTableManager(
      $_db,
      $_db.planeMontaj,
    ).filter((f) => f.releveuId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_planeMontajRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TablouriExistenteTable,
    List<TablouriExistenteData>
  >
  _tablouriExistenteRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.tablouriExistente,
        aliasName: 'relevee__id__tablouri_existente__releveu_id',
      );

  $$TablouriExistenteTableProcessedTableManager get tablouriExistenteRefs {
    final manager = $$TablouriExistenteTableTableManager(
      $_db,
      $_db.tablouriExistente,
    ).filter((f) => f.releveuId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _tablouriExistenteRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TraseeTable, List<TraseeData>> _traseeRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trasee,
    aliasName: 'relevee__id__trasee__releveu_id',
  );

  $$TraseeTableProcessedTableManager get traseeRefs {
    final manager = $$TraseeTableTableManager(
      $_db,
      $_db.trasee,
    ).filter((f) => f.releveuId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_traseeRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReleveeTableFilterComposer
    extends Composer<_$AppDatabase, $ReleveeTable> {
  $$ReleveeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operator => $composableBuilder(
    column: $table.operator,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperaturaAmbientaC => $composableBuilder(
    column: $table.temperaturaAmbientaC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get zapadaSkKnM2 => $composableBuilder(
    column: $table.zapadaSkKnM2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get vantQbKpa => $composableBuilder(
    column: $table.vantQbKpa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$LucrariTableFilterComposer get lucrareId {
    final $$LucrariTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableFilterComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> planeMontajRefs(
    Expression<bool> Function($$PlaneMontajTableFilterComposer f) f,
  ) {
    final $$PlaneMontajTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planeMontaj,
      getReferencedColumn: (t) => t.releveuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaneMontajTableFilterComposer(
            $db: $db,
            $table: $db.planeMontaj,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tablouriExistenteRefs(
    Expression<bool> Function($$TablouriExistenteTableFilterComposer f) f,
  ) {
    final $$TablouriExistenteTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tablouriExistente,
      getReferencedColumn: (t) => t.releveuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TablouriExistenteTableFilterComposer(
            $db: $db,
            $table: $db.tablouriExistente,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> traseeRefs(
    Expression<bool> Function($$TraseeTableFilterComposer f) f,
  ) {
    final $$TraseeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trasee,
      getReferencedColumn: (t) => t.releveuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TraseeTableFilterComposer(
            $db: $db,
            $table: $db.trasee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReleveeTableOrderingComposer
    extends Composer<_$AppDatabase, $ReleveeTable> {
  $$ReleveeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get data => $composableBuilder(
    column: $table.data,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operator => $composableBuilder(
    column: $table.operator,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperaturaAmbientaC => $composableBuilder(
    column: $table.temperaturaAmbientaC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get zapadaSkKnM2 => $composableBuilder(
    column: $table.zapadaSkKnM2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get vantQbKpa => $composableBuilder(
    column: $table.vantQbKpa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$LucrariTableOrderingComposer get lucrareId {
    final $$LucrariTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableOrderingComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReleveeTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReleveeTable> {
  $$ReleveeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<DateTime> get data =>
      $composableBuilder(column: $table.data, builder: (column) => column);

  GeneratedColumn<String> get operator =>
      $composableBuilder(column: $table.operator, builder: (column) => column);

  GeneratedColumn<double> get temperaturaAmbientaC => $composableBuilder(
    column: $table.temperaturaAmbientaC,
    builder: (column) => column,
  );

  GeneratedColumn<double> get zapadaSkKnM2 => $composableBuilder(
    column: $table.zapadaSkKnM2,
    builder: (column) => column,
  );

  GeneratedColumn<double> get vantQbKpa =>
      $composableBuilder(column: $table.vantQbKpa, builder: (column) => column);

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$LucrariTableAnnotationComposer get lucrareId {
    final $$LucrariTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.lucrareId,
      referencedTable: $db.lucrari,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LucrariTableAnnotationComposer(
            $db: $db,
            $table: $db.lucrari,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> planeMontajRefs<T extends Object>(
    Expression<T> Function($$PlaneMontajTableAnnotationComposer a) f,
  ) {
    final $$PlaneMontajTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.planeMontaj,
      getReferencedColumn: (t) => t.releveuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaneMontajTableAnnotationComposer(
            $db: $db,
            $table: $db.planeMontaj,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> tablouriExistenteRefs<T extends Object>(
    Expression<T> Function($$TablouriExistenteTableAnnotationComposer a) f,
  ) {
    final $$TablouriExistenteTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.tablouriExistente,
          getReferencedColumn: (t) => t.releveuId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TablouriExistenteTableAnnotationComposer(
                $db: $db,
                $table: $db.tablouriExistente,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> traseeRefs<T extends Object>(
    Expression<T> Function($$TraseeTableAnnotationComposer a) f,
  ) {
    final $$TraseeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trasee,
      getReferencedColumn: (t) => t.releveuId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TraseeTableAnnotationComposer(
            $db: $db,
            $table: $db.trasee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReleveeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReleveeTable,
          ReleveeData,
          $$ReleveeTableFilterComposer,
          $$ReleveeTableOrderingComposer,
          $$ReleveeTableAnnotationComposer,
          $$ReleveeTableCreateCompanionBuilder,
          $$ReleveeTableUpdateCompanionBuilder,
          (ReleveeData, $$ReleveeTableReferences),
          ReleveeData,
          PrefetchHooks Function({
            bool lucrareId,
            bool planeMontajRefs,
            bool tablouriExistenteRefs,
            bool traseeRefs,
          })
        > {
  $$ReleveeTableTableManager(_$AppDatabase db, $ReleveeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReleveeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReleveeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReleveeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> lucrareId = const Value.absent(),
                Value<DateTime> data = const Value.absent(),
                Value<String> operator = const Value.absent(),
                Value<double?> temperaturaAmbientaC = const Value.absent(),
                Value<double?> zapadaSkKnM2 = const Value.absent(),
                Value<double?> vantQbKpa = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReleveeCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                lucrareId: lucrareId,
                data: data,
                operator: operator,
                temperaturaAmbientaC: temperaturaAmbientaC,
                zapadaSkKnM2: zapadaSkKnM2,
                vantQbKpa: vantQbKpa,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String lucrareId,
                required DateTime data,
                Value<String> operator = const Value.absent(),
                Value<double?> temperaturaAmbientaC = const Value.absent(),
                Value<double?> zapadaSkKnM2 = const Value.absent(),
                Value<double?> vantQbKpa = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReleveeCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                lucrareId: lucrareId,
                data: data,
                operator: operator,
                temperaturaAmbientaC: temperaturaAmbientaC,
                zapadaSkKnM2: zapadaSkKnM2,
                vantQbKpa: vantQbKpa,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ReleveeTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                lucrareId = false,
                planeMontajRefs = false,
                tablouriExistenteRefs = false,
                traseeRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (planeMontajRefs) db.planeMontaj,
                    if (tablouriExistenteRefs) db.tablouriExistente,
                    if (traseeRefs) db.trasee,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (lucrareId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.lucrareId,
                                    referencedTable: $$ReleveeTableReferences
                                        ._lucrareIdTable(db),
                                    referencedColumn: $$ReleveeTableReferences
                                        ._lucrareIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (planeMontajRefs)
                        await $_getPrefetchedData<
                          ReleveeData,
                          $ReleveeTable,
                          PlaneMontajData
                        >(
                          currentTable: table,
                          referencedTable: $$ReleveeTableReferences
                              ._planeMontajRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReleveeTableReferences(
                                db,
                                table,
                                p0,
                              ).planeMontajRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.releveuId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tablouriExistenteRefs)
                        await $_getPrefetchedData<
                          ReleveeData,
                          $ReleveeTable,
                          TablouriExistenteData
                        >(
                          currentTable: table,
                          referencedTable: $$ReleveeTableReferences
                              ._tablouriExistenteRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReleveeTableReferences(
                                db,
                                table,
                                p0,
                              ).tablouriExistenteRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.releveuId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (traseeRefs)
                        await $_getPrefetchedData<
                          ReleveeData,
                          $ReleveeTable,
                          TraseeData
                        >(
                          currentTable: table,
                          referencedTable: $$ReleveeTableReferences
                              ._traseeRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReleveeTableReferences(
                                db,
                                table,
                                p0,
                              ).traseeRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.releveuId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReleveeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReleveeTable,
      ReleveeData,
      $$ReleveeTableFilterComposer,
      $$ReleveeTableOrderingComposer,
      $$ReleveeTableAnnotationComposer,
      $$ReleveeTableCreateCompanionBuilder,
      $$ReleveeTableUpdateCompanionBuilder,
      (ReleveeData, $$ReleveeTableReferences),
      ReleveeData,
      PrefetchHooks Function({
        bool lucrareId,
        bool planeMontajRefs,
        bool tablouriExistenteRefs,
        bool traseeRefs,
      })
    >;
typedef $$PlaneMontajTableCreateCompanionBuilder =
    PlaneMontajCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String releveuId,
      required String denumire,
      required String tip,
      required String invelitoare,
      Value<double> inclinareGrade,
      Value<double> azimutGrade,
      Value<double> lungimeM,
      Value<double> latimeM,
      Value<double?> inaltimeStreasinaM,
      Value<String> capriorSectiune,
      Value<double?> capriorInteraxCm,
      required String stare,
      Value<double> factorUmbrire,
      Value<String> observatii,
      Value<int> ordine,
      Value<int> rowid,
    });
typedef $$PlaneMontajTableUpdateCompanionBuilder =
    PlaneMontajCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> releveuId,
      Value<String> denumire,
      Value<String> tip,
      Value<String> invelitoare,
      Value<double> inclinareGrade,
      Value<double> azimutGrade,
      Value<double> lungimeM,
      Value<double> latimeM,
      Value<double?> inaltimeStreasinaM,
      Value<String> capriorSectiune,
      Value<double?> capriorInteraxCm,
      Value<String> stare,
      Value<double> factorUmbrire,
      Value<String> observatii,
      Value<int> ordine,
      Value<int> rowid,
    });

final class $$PlaneMontajTableReferences
    extends BaseReferences<_$AppDatabase, $PlaneMontajTable, PlaneMontajData> {
  $$PlaneMontajTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReleveeTable _releveuIdTable(_$AppDatabase db) =>
      db.relevee.createAlias('plane_montaj__releveu_id__relevee__id');

  $$ReleveeTableProcessedTableManager get releveuId {
    final $_column = $_itemColumn<String>('releveu_id')!;

    final manager = $$ReleveeTableTableManager(
      $_db,
      $_db.relevee,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_releveuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ObstacoleTable, List<ObstacoleData>>
  _obstacoleRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.obstacole,
    aliasName: 'plane_montaj__id__obstacole__plan_id',
  );

  $$ObstacoleTableProcessedTableManager get obstacoleRefs {
    final manager = $$ObstacoleTableTableManager(
      $_db,
      $_db.obstacole,
    ).filter((f) => f.planId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_obstacoleRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlaneMontajTableFilterComposer
    extends Composer<_$AppDatabase, $PlaneMontajTable> {
  $$PlaneMontajTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invelitoare => $composableBuilder(
    column: $table.invelitoare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get inclinareGrade => $composableBuilder(
    column: $table.inclinareGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lungimeM => $composableBuilder(
    column: $table.lungimeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latimeM => $composableBuilder(
    column: $table.latimeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get inaltimeStreasinaM => $composableBuilder(
    column: $table.inaltimeStreasinaM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get capriorSectiune => $composableBuilder(
    column: $table.capriorSectiune,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get capriorInteraxCm => $composableBuilder(
    column: $table.capriorInteraxCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get stare => $composableBuilder(
    column: $table.stare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get factorUmbrire => $composableBuilder(
    column: $table.factorUmbrire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordine => $composableBuilder(
    column: $table.ordine,
    builder: (column) => ColumnFilters(column),
  );

  $$ReleveeTableFilterComposer get releveuId {
    final $$ReleveeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableFilterComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> obstacoleRefs(
    Expression<bool> Function($$ObstacoleTableFilterComposer f) f,
  ) {
    final $$ObstacoleTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.obstacole,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObstacoleTableFilterComposer(
            $db: $db,
            $table: $db.obstacole,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaneMontajTableOrderingComposer
    extends Composer<_$AppDatabase, $PlaneMontajTable> {
  $$PlaneMontajTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get denumire => $composableBuilder(
    column: $table.denumire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invelitoare => $composableBuilder(
    column: $table.invelitoare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inclinareGrade => $composableBuilder(
    column: $table.inclinareGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lungimeM => $composableBuilder(
    column: $table.lungimeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latimeM => $composableBuilder(
    column: $table.latimeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inaltimeStreasinaM => $composableBuilder(
    column: $table.inaltimeStreasinaM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get capriorSectiune => $composableBuilder(
    column: $table.capriorSectiune,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get capriorInteraxCm => $composableBuilder(
    column: $table.capriorInteraxCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get stare => $composableBuilder(
    column: $table.stare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get factorUmbrire => $composableBuilder(
    column: $table.factorUmbrire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordine => $composableBuilder(
    column: $table.ordine,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReleveeTableOrderingComposer get releveuId {
    final $$ReleveeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableOrderingComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlaneMontajTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlaneMontajTable> {
  $$PlaneMontajTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get denumire =>
      $composableBuilder(column: $table.denumire, builder: (column) => column);

  GeneratedColumn<String> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<String> get invelitoare => $composableBuilder(
    column: $table.invelitoare,
    builder: (column) => column,
  );

  GeneratedColumn<double> get inclinareGrade => $composableBuilder(
    column: $table.inclinareGrade,
    builder: (column) => column,
  );

  GeneratedColumn<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => column,
  );

  GeneratedColumn<double> get lungimeM =>
      $composableBuilder(column: $table.lungimeM, builder: (column) => column);

  GeneratedColumn<double> get latimeM =>
      $composableBuilder(column: $table.latimeM, builder: (column) => column);

  GeneratedColumn<double> get inaltimeStreasinaM => $composableBuilder(
    column: $table.inaltimeStreasinaM,
    builder: (column) => column,
  );

  GeneratedColumn<String> get capriorSectiune => $composableBuilder(
    column: $table.capriorSectiune,
    builder: (column) => column,
  );

  GeneratedColumn<double> get capriorInteraxCm => $composableBuilder(
    column: $table.capriorInteraxCm,
    builder: (column) => column,
  );

  GeneratedColumn<String> get stare =>
      $composableBuilder(column: $table.stare, builder: (column) => column);

  GeneratedColumn<double> get factorUmbrire => $composableBuilder(
    column: $table.factorUmbrire,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ordine =>
      $composableBuilder(column: $table.ordine, builder: (column) => column);

  $$ReleveeTableAnnotationComposer get releveuId {
    final $$ReleveeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableAnnotationComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> obstacoleRefs<T extends Object>(
    Expression<T> Function($$ObstacoleTableAnnotationComposer a) f,
  ) {
    final $$ObstacoleTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.obstacole,
      getReferencedColumn: (t) => t.planId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ObstacoleTableAnnotationComposer(
            $db: $db,
            $table: $db.obstacole,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlaneMontajTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlaneMontajTable,
          PlaneMontajData,
          $$PlaneMontajTableFilterComposer,
          $$PlaneMontajTableOrderingComposer,
          $$PlaneMontajTableAnnotationComposer,
          $$PlaneMontajTableCreateCompanionBuilder,
          $$PlaneMontajTableUpdateCompanionBuilder,
          (PlaneMontajData, $$PlaneMontajTableReferences),
          PlaneMontajData,
          PrefetchHooks Function({bool releveuId, bool obstacoleRefs})
        > {
  $$PlaneMontajTableTableManager(_$AppDatabase db, $PlaneMontajTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlaneMontajTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlaneMontajTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlaneMontajTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> releveuId = const Value.absent(),
                Value<String> denumire = const Value.absent(),
                Value<String> tip = const Value.absent(),
                Value<String> invelitoare = const Value.absent(),
                Value<double> inclinareGrade = const Value.absent(),
                Value<double> azimutGrade = const Value.absent(),
                Value<double> lungimeM = const Value.absent(),
                Value<double> latimeM = const Value.absent(),
                Value<double?> inaltimeStreasinaM = const Value.absent(),
                Value<String> capriorSectiune = const Value.absent(),
                Value<double?> capriorInteraxCm = const Value.absent(),
                Value<String> stare = const Value.absent(),
                Value<double> factorUmbrire = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> ordine = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaneMontajCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                denumire: denumire,
                tip: tip,
                invelitoare: invelitoare,
                inclinareGrade: inclinareGrade,
                azimutGrade: azimutGrade,
                lungimeM: lungimeM,
                latimeM: latimeM,
                inaltimeStreasinaM: inaltimeStreasinaM,
                capriorSectiune: capriorSectiune,
                capriorInteraxCm: capriorInteraxCm,
                stare: stare,
                factorUmbrire: factorUmbrire,
                observatii: observatii,
                ordine: ordine,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String releveuId,
                required String denumire,
                required String tip,
                required String invelitoare,
                Value<double> inclinareGrade = const Value.absent(),
                Value<double> azimutGrade = const Value.absent(),
                Value<double> lungimeM = const Value.absent(),
                Value<double> latimeM = const Value.absent(),
                Value<double?> inaltimeStreasinaM = const Value.absent(),
                Value<String> capriorSectiune = const Value.absent(),
                Value<double?> capriorInteraxCm = const Value.absent(),
                required String stare,
                Value<double> factorUmbrire = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> ordine = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlaneMontajCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                denumire: denumire,
                tip: tip,
                invelitoare: invelitoare,
                inclinareGrade: inclinareGrade,
                azimutGrade: azimutGrade,
                lungimeM: lungimeM,
                latimeM: latimeM,
                inaltimeStreasinaM: inaltimeStreasinaM,
                capriorSectiune: capriorSectiune,
                capriorInteraxCm: capriorInteraxCm,
                stare: stare,
                factorUmbrire: factorUmbrire,
                observatii: observatii,
                ordine: ordine,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlaneMontajTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({releveuId = false, obstacoleRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (obstacoleRefs) db.obstacole],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (releveuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.releveuId,
                                referencedTable: $$PlaneMontajTableReferences
                                    ._releveuIdTable(db),
                                referencedColumn: $$PlaneMontajTableReferences
                                    ._releveuIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (obstacoleRefs)
                    await $_getPrefetchedData<
                      PlaneMontajData,
                      $PlaneMontajTable,
                      ObstacoleData
                    >(
                      currentTable: table,
                      referencedTable: $$PlaneMontajTableReferences
                          ._obstacoleRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$PlaneMontajTableReferences(
                            db,
                            table,
                            p0,
                          ).obstacoleRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.planId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlaneMontajTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlaneMontajTable,
      PlaneMontajData,
      $$PlaneMontajTableFilterComposer,
      $$PlaneMontajTableOrderingComposer,
      $$PlaneMontajTableAnnotationComposer,
      $$PlaneMontajTableCreateCompanionBuilder,
      $$PlaneMontajTableUpdateCompanionBuilder,
      (PlaneMontajData, $$PlaneMontajTableReferences),
      PlaneMontajData,
      PrefetchHooks Function({bool releveuId, bool obstacoleRefs})
    >;
typedef $$ObstacoleTableCreateCompanionBuilder =
    ObstacoleCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String planId,
      required String tip,
      Value<double> inaltimeM,
      Value<double> distantaM,
      Value<double?> azimutGrade,
      Value<double?> latimeM,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$ObstacoleTableUpdateCompanionBuilder =
    ObstacoleCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> planId,
      Value<String> tip,
      Value<double> inaltimeM,
      Value<double> distantaM,
      Value<double?> azimutGrade,
      Value<double?> latimeM,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$ObstacoleTableReferences
    extends BaseReferences<_$AppDatabase, $ObstacoleTable, ObstacoleData> {
  $$ObstacoleTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PlaneMontajTable _planIdTable(_$AppDatabase db) =>
      db.planeMontaj.createAlias('obstacole__plan_id__plane_montaj__id');

  $$PlaneMontajTableProcessedTableManager get planId {
    final $_column = $_itemColumn<String>('plan_id')!;

    final manager = $$PlaneMontajTableTableManager(
      $_db,
      $_db.planeMontaj,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_planIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ObstacoleTableFilterComposer
    extends Composer<_$AppDatabase, $ObstacoleTable> {
  $$ObstacoleTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get inaltimeM => $composableBuilder(
    column: $table.inaltimeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get distantaM => $composableBuilder(
    column: $table.distantaM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latimeM => $composableBuilder(
    column: $table.latimeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$PlaneMontajTableFilterComposer get planId {
    final $$PlaneMontajTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.planeMontaj,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaneMontajTableFilterComposer(
            $db: $db,
            $table: $db.planeMontaj,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstacoleTableOrderingComposer
    extends Composer<_$AppDatabase, $ObstacoleTable> {
  $$ObstacoleTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tip => $composableBuilder(
    column: $table.tip,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get inaltimeM => $composableBuilder(
    column: $table.inaltimeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get distantaM => $composableBuilder(
    column: $table.distantaM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latimeM => $composableBuilder(
    column: $table.latimeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlaneMontajTableOrderingComposer get planId {
    final $$PlaneMontajTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.planeMontaj,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaneMontajTableOrderingComposer(
            $db: $db,
            $table: $db.planeMontaj,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstacoleTableAnnotationComposer
    extends Composer<_$AppDatabase, $ObstacoleTable> {
  $$ObstacoleTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get tip =>
      $composableBuilder(column: $table.tip, builder: (column) => column);

  GeneratedColumn<double> get inaltimeM =>
      $composableBuilder(column: $table.inaltimeM, builder: (column) => column);

  GeneratedColumn<double> get distantaM =>
      $composableBuilder(column: $table.distantaM, builder: (column) => column);

  GeneratedColumn<double> get azimutGrade => $composableBuilder(
    column: $table.azimutGrade,
    builder: (column) => column,
  );

  GeneratedColumn<double> get latimeM =>
      $composableBuilder(column: $table.latimeM, builder: (column) => column);

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$PlaneMontajTableAnnotationComposer get planId {
    final $$PlaneMontajTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.planId,
      referencedTable: $db.planeMontaj,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlaneMontajTableAnnotationComposer(
            $db: $db,
            $table: $db.planeMontaj,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ObstacoleTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ObstacoleTable,
          ObstacoleData,
          $$ObstacoleTableFilterComposer,
          $$ObstacoleTableOrderingComposer,
          $$ObstacoleTableAnnotationComposer,
          $$ObstacoleTableCreateCompanionBuilder,
          $$ObstacoleTableUpdateCompanionBuilder,
          (ObstacoleData, $$ObstacoleTableReferences),
          ObstacoleData,
          PrefetchHooks Function({bool planId})
        > {
  $$ObstacoleTableTableManager(_$AppDatabase db, $ObstacoleTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ObstacoleTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ObstacoleTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ObstacoleTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> planId = const Value.absent(),
                Value<String> tip = const Value.absent(),
                Value<double> inaltimeM = const Value.absent(),
                Value<double> distantaM = const Value.absent(),
                Value<double?> azimutGrade = const Value.absent(),
                Value<double?> latimeM = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObstacoleCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                planId: planId,
                tip: tip,
                inaltimeM: inaltimeM,
                distantaM: distantaM,
                azimutGrade: azimutGrade,
                latimeM: latimeM,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String planId,
                required String tip,
                Value<double> inaltimeM = const Value.absent(),
                Value<double> distantaM = const Value.absent(),
                Value<double?> azimutGrade = const Value.absent(),
                Value<double?> latimeM = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ObstacoleCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                planId: planId,
                tip: tip,
                inaltimeM: inaltimeM,
                distantaM: distantaM,
                azimutGrade: azimutGrade,
                latimeM: latimeM,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ObstacoleTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({planId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (planId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.planId,
                                referencedTable: $$ObstacoleTableReferences
                                    ._planIdTable(db),
                                referencedColumn: $$ObstacoleTableReferences
                                    ._planIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ObstacoleTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ObstacoleTable,
      ObstacoleData,
      $$ObstacoleTableFilterComposer,
      $$ObstacoleTableOrderingComposer,
      $$ObstacoleTableAnnotationComposer,
      $$ObstacoleTableCreateCompanionBuilder,
      $$ObstacoleTableUpdateCompanionBuilder,
      (ObstacoleData, $$ObstacoleTableReferences),
      ObstacoleData,
      PrefetchHooks Function({bool planId})
    >;
typedef $$TablouriExistenteTableCreateCompanionBuilder =
    TablouriExistenteCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String releveuId,
      Value<int?> pozitiiLibere,
      Value<int?> disjunctorGeneralA,
      Value<String> disjunctorCurba,
      Value<double?> icuKa,
      required String ddrExistent,
      Value<int?> ddrIdnMa,
      Value<bool> spdExistent,
      Value<bool> baraPeSeparata,
      Value<double?> sectiuneColoanaMm2,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$TablouriExistenteTableUpdateCompanionBuilder =
    TablouriExistenteCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> releveuId,
      Value<int?> pozitiiLibere,
      Value<int?> disjunctorGeneralA,
      Value<String> disjunctorCurba,
      Value<double?> icuKa,
      Value<String> ddrExistent,
      Value<int?> ddrIdnMa,
      Value<bool> spdExistent,
      Value<bool> baraPeSeparata,
      Value<double?> sectiuneColoanaMm2,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$TablouriExistenteTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $TablouriExistenteTable,
          TablouriExistenteData
        > {
  $$TablouriExistenteTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ReleveeTable _releveuIdTable(_$AppDatabase db) =>
      db.relevee.createAlias('tablouri_existente__releveu_id__relevee__id');

  $$ReleveeTableProcessedTableManager get releveuId {
    final $_column = $_itemColumn<String>('releveu_id')!;

    final manager = $$ReleveeTableTableManager(
      $_db,
      $_db.relevee,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_releveuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TablouriExistenteTableFilterComposer
    extends Composer<_$AppDatabase, $TablouriExistenteTable> {
  $$TablouriExistenteTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get pozitiiLibere => $composableBuilder(
    column: $table.pozitiiLibere,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get disjunctorCurba => $composableBuilder(
    column: $table.disjunctorCurba,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get icuKa => $composableBuilder(
    column: $table.icuKa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ddrExistent => $composableBuilder(
    column: $table.ddrExistent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ddrIdnMa => $composableBuilder(
    column: $table.ddrIdnMa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get spdExistent => $composableBuilder(
    column: $table.spdExistent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get baraPeSeparata => $composableBuilder(
    column: $table.baraPeSeparata,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get sectiuneColoanaMm2 => $composableBuilder(
    column: $table.sectiuneColoanaMm2,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$ReleveeTableFilterComposer get releveuId {
    final $$ReleveeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableFilterComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TablouriExistenteTableOrderingComposer
    extends Composer<_$AppDatabase, $TablouriExistenteTable> {
  $$TablouriExistenteTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get pozitiiLibere => $composableBuilder(
    column: $table.pozitiiLibere,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get disjunctorCurba => $composableBuilder(
    column: $table.disjunctorCurba,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get icuKa => $composableBuilder(
    column: $table.icuKa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ddrExistent => $composableBuilder(
    column: $table.ddrExistent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ddrIdnMa => $composableBuilder(
    column: $table.ddrIdnMa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get spdExistent => $composableBuilder(
    column: $table.spdExistent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get baraPeSeparata => $composableBuilder(
    column: $table.baraPeSeparata,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get sectiuneColoanaMm2 => $composableBuilder(
    column: $table.sectiuneColoanaMm2,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReleveeTableOrderingComposer get releveuId {
    final $$ReleveeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableOrderingComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TablouriExistenteTableAnnotationComposer
    extends Composer<_$AppDatabase, $TablouriExistenteTable> {
  $$TablouriExistenteTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<int> get pozitiiLibere => $composableBuilder(
    column: $table.pozitiiLibere,
    builder: (column) => column,
  );

  GeneratedColumn<int> get disjunctorGeneralA => $composableBuilder(
    column: $table.disjunctorGeneralA,
    builder: (column) => column,
  );

  GeneratedColumn<String> get disjunctorCurba => $composableBuilder(
    column: $table.disjunctorCurba,
    builder: (column) => column,
  );

  GeneratedColumn<double> get icuKa =>
      $composableBuilder(column: $table.icuKa, builder: (column) => column);

  GeneratedColumn<String> get ddrExistent => $composableBuilder(
    column: $table.ddrExistent,
    builder: (column) => column,
  );

  GeneratedColumn<int> get ddrIdnMa =>
      $composableBuilder(column: $table.ddrIdnMa, builder: (column) => column);

  GeneratedColumn<bool> get spdExistent => $composableBuilder(
    column: $table.spdExistent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get baraPeSeparata => $composableBuilder(
    column: $table.baraPeSeparata,
    builder: (column) => column,
  );

  GeneratedColumn<double> get sectiuneColoanaMm2 => $composableBuilder(
    column: $table.sectiuneColoanaMm2,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$ReleveeTableAnnotationComposer get releveuId {
    final $$ReleveeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableAnnotationComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TablouriExistenteTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TablouriExistenteTable,
          TablouriExistenteData,
          $$TablouriExistenteTableFilterComposer,
          $$TablouriExistenteTableOrderingComposer,
          $$TablouriExistenteTableAnnotationComposer,
          $$TablouriExistenteTableCreateCompanionBuilder,
          $$TablouriExistenteTableUpdateCompanionBuilder,
          (TablouriExistenteData, $$TablouriExistenteTableReferences),
          TablouriExistenteData,
          PrefetchHooks Function({bool releveuId})
        > {
  $$TablouriExistenteTableTableManager(
    _$AppDatabase db,
    $TablouriExistenteTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TablouriExistenteTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TablouriExistenteTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TablouriExistenteTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> releveuId = const Value.absent(),
                Value<int?> pozitiiLibere = const Value.absent(),
                Value<int?> disjunctorGeneralA = const Value.absent(),
                Value<String> disjunctorCurba = const Value.absent(),
                Value<double?> icuKa = const Value.absent(),
                Value<String> ddrExistent = const Value.absent(),
                Value<int?> ddrIdnMa = const Value.absent(),
                Value<bool> spdExistent = const Value.absent(),
                Value<bool> baraPeSeparata = const Value.absent(),
                Value<double?> sectiuneColoanaMm2 = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TablouriExistenteCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                pozitiiLibere: pozitiiLibere,
                disjunctorGeneralA: disjunctorGeneralA,
                disjunctorCurba: disjunctorCurba,
                icuKa: icuKa,
                ddrExistent: ddrExistent,
                ddrIdnMa: ddrIdnMa,
                spdExistent: spdExistent,
                baraPeSeparata: baraPeSeparata,
                sectiuneColoanaMm2: sectiuneColoanaMm2,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String releveuId,
                Value<int?> pozitiiLibere = const Value.absent(),
                Value<int?> disjunctorGeneralA = const Value.absent(),
                Value<String> disjunctorCurba = const Value.absent(),
                Value<double?> icuKa = const Value.absent(),
                required String ddrExistent,
                Value<int?> ddrIdnMa = const Value.absent(),
                Value<bool> spdExistent = const Value.absent(),
                Value<bool> baraPeSeparata = const Value.absent(),
                Value<double?> sectiuneColoanaMm2 = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TablouriExistenteCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                pozitiiLibere: pozitiiLibere,
                disjunctorGeneralA: disjunctorGeneralA,
                disjunctorCurba: disjunctorCurba,
                icuKa: icuKa,
                ddrExistent: ddrExistent,
                ddrIdnMa: ddrIdnMa,
                spdExistent: spdExistent,
                baraPeSeparata: baraPeSeparata,
                sectiuneColoanaMm2: sectiuneColoanaMm2,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TablouriExistenteTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({releveuId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (releveuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.releveuId,
                                referencedTable:
                                    $$TablouriExistenteTableReferences
                                        ._releveuIdTable(db),
                                referencedColumn:
                                    $$TablouriExistenteTableReferences
                                        ._releveuIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TablouriExistenteTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TablouriExistenteTable,
      TablouriExistenteData,
      $$TablouriExistenteTableFilterComposer,
      $$TablouriExistenteTableOrderingComposer,
      $$TablouriExistenteTableAnnotationComposer,
      $$TablouriExistenteTableCreateCompanionBuilder,
      $$TablouriExistenteTableUpdateCompanionBuilder,
      (TablouriExistenteData, $$TablouriExistenteTableReferences),
      TablouriExistenteData,
      PrefetchHooks Function({bool releveuId})
    >;
typedef $$TraseeTableCreateCompanionBuilder =
    TraseeCompanion Function({
      required String id,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      required String releveuId,
      required String segment,
      Value<double> lungimeM,
      Value<String> modPozare,
      Value<double?> temperaturaMaximaC,
      Value<String> observatii,
      Value<int> rowid,
    });
typedef $$TraseeTableUpdateCompanionBuilder =
    TraseeCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> deletedAt,
      Value<int> version,
      Value<String> releveuId,
      Value<String> segment,
      Value<double> lungimeM,
      Value<String> modPozare,
      Value<double?> temperaturaMaximaC,
      Value<String> observatii,
      Value<int> rowid,
    });

final class $$TraseeTableReferences
    extends BaseReferences<_$AppDatabase, $TraseeTable, TraseeData> {
  $$TraseeTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReleveeTable _releveuIdTable(_$AppDatabase db) =>
      db.relevee.createAlias('trasee__releveu_id__relevee__id');

  $$ReleveeTableProcessedTableManager get releveuId {
    final $_column = $_itemColumn<String>('releveu_id')!;

    final manager = $$ReleveeTableTableManager(
      $_db,
      $_db.relevee,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_releveuIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TraseeTableFilterComposer
    extends Composer<_$AppDatabase, $TraseeTable> {
  $$TraseeTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get segment => $composableBuilder(
    column: $table.segment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get lungimeM => $composableBuilder(
    column: $table.lungimeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modPozare => $composableBuilder(
    column: $table.modPozare,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get temperaturaMaximaC => $composableBuilder(
    column: $table.temperaturaMaximaC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnFilters(column),
  );

  $$ReleveeTableFilterComposer get releveuId {
    final $$ReleveeTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableFilterComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TraseeTableOrderingComposer
    extends Composer<_$AppDatabase, $TraseeTable> {
  $$TraseeTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get segment => $composableBuilder(
    column: $table.segment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get lungimeM => $composableBuilder(
    column: $table.lungimeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modPozare => $composableBuilder(
    column: $table.modPozare,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get temperaturaMaximaC => $composableBuilder(
    column: $table.temperaturaMaximaC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReleveeTableOrderingComposer get releveuId {
    final $$ReleveeTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableOrderingComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TraseeTableAnnotationComposer
    extends Composer<_$AppDatabase, $TraseeTable> {
  $$TraseeTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get segment =>
      $composableBuilder(column: $table.segment, builder: (column) => column);

  GeneratedColumn<double> get lungimeM =>
      $composableBuilder(column: $table.lungimeM, builder: (column) => column);

  GeneratedColumn<String> get modPozare =>
      $composableBuilder(column: $table.modPozare, builder: (column) => column);

  GeneratedColumn<double> get temperaturaMaximaC => $composableBuilder(
    column: $table.temperaturaMaximaC,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observatii => $composableBuilder(
    column: $table.observatii,
    builder: (column) => column,
  );

  $$ReleveeTableAnnotationComposer get releveuId {
    final $$ReleveeTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.releveuId,
      referencedTable: $db.relevee,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReleveeTableAnnotationComposer(
            $db: $db,
            $table: $db.relevee,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TraseeTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TraseeTable,
          TraseeData,
          $$TraseeTableFilterComposer,
          $$TraseeTableOrderingComposer,
          $$TraseeTableAnnotationComposer,
          $$TraseeTableCreateCompanionBuilder,
          $$TraseeTableUpdateCompanionBuilder,
          (TraseeData, $$TraseeTableReferences),
          TraseeData,
          PrefetchHooks Function({bool releveuId})
        > {
  $$TraseeTableTableManager(_$AppDatabase db, $TraseeTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TraseeTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TraseeTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TraseeTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> releveuId = const Value.absent(),
                Value<String> segment = const Value.absent(),
                Value<double> lungimeM = const Value.absent(),
                Value<String> modPozare = const Value.absent(),
                Value<double?> temperaturaMaximaC = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TraseeCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                segment: segment,
                lungimeM: lungimeM,
                modPozare: modPozare,
                temperaturaMaximaC: temperaturaMaximaC,
                observatii: observatii,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                required String releveuId,
                required String segment,
                Value<double> lungimeM = const Value.absent(),
                Value<String> modPozare = const Value.absent(),
                Value<double?> temperaturaMaximaC = const Value.absent(),
                Value<String> observatii = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TraseeCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                deletedAt: deletedAt,
                version: version,
                releveuId: releveuId,
                segment: segment,
                lungimeM: lungimeM,
                modPozare: modPozare,
                temperaturaMaximaC: temperaturaMaximaC,
                observatii: observatii,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TraseeTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({releveuId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (releveuId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.releveuId,
                                referencedTable: $$TraseeTableReferences
                                    ._releveuIdTable(db),
                                referencedColumn: $$TraseeTableReferences
                                    ._releveuIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TraseeTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TraseeTable,
      TraseeData,
      $$TraseeTableFilterComposer,
      $$TraseeTableOrderingComposer,
      $$TraseeTableAnnotationComposer,
      $$TraseeTableCreateCompanionBuilder,
      $$TraseeTableUpdateCompanionBuilder,
      (TraseeData, $$TraseeTableReferences),
      TraseeData,
      PrefetchHooks Function({bool releveuId})
    >;
typedef $$SetariTableCreateCompanionBuilder =
    SetariCompanion Function({
      required String cheie,
      required String valoare,
      Value<int> rowid,
    });
typedef $$SetariTableUpdateCompanionBuilder =
    SetariCompanion Function({
      Value<String> cheie,
      Value<String> valoare,
      Value<int> rowid,
    });

class $$SetariTableFilterComposer
    extends Composer<_$AppDatabase, $SetariTable> {
  $$SetariTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get cheie => $composableBuilder(
    column: $table.cheie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valoare => $composableBuilder(
    column: $table.valoare,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SetariTableOrderingComposer
    extends Composer<_$AppDatabase, $SetariTable> {
  $$SetariTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get cheie => $composableBuilder(
    column: $table.cheie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valoare => $composableBuilder(
    column: $table.valoare,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SetariTableAnnotationComposer
    extends Composer<_$AppDatabase, $SetariTable> {
  $$SetariTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get cheie =>
      $composableBuilder(column: $table.cheie, builder: (column) => column);

  GeneratedColumn<String> get valoare =>
      $composableBuilder(column: $table.valoare, builder: (column) => column);
}

class $$SetariTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SetariTable,
          SetariData,
          $$SetariTableFilterComposer,
          $$SetariTableOrderingComposer,
          $$SetariTableAnnotationComposer,
          $$SetariTableCreateCompanionBuilder,
          $$SetariTableUpdateCompanionBuilder,
          (SetariData, BaseReferences<_$AppDatabase, $SetariTable, SetariData>),
          SetariData,
          PrefetchHooks Function()
        > {
  $$SetariTableTableManager(_$AppDatabase db, $SetariTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SetariTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SetariTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SetariTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> cheie = const Value.absent(),
                Value<String> valoare = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) =>
                  SetariCompanion(cheie: cheie, valoare: valoare, rowid: rowid),
          createCompanionCallback:
              ({
                required String cheie,
                required String valoare,
                Value<int> rowid = const Value.absent(),
              }) => SetariCompanion.insert(
                cheie: cheie,
                valoare: valoare,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SetariTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SetariTable,
      SetariData,
      $$SetariTableFilterComposer,
      $$SetariTableOrderingComposer,
      $$SetariTableAnnotationComposer,
      $$SetariTableCreateCompanionBuilder,
      $$SetariTableUpdateCompanionBuilder,
      (SetariData, BaseReferences<_$AppDatabase, $SetariTable, SetariData>),
      SetariData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientiTableTableManager get clienti =>
      $$ClientiTableTableManager(_db, _db.clienti);
  $$LucrariTableTableManager get lucrari =>
      $$LucrariTableTableManager(_db, _db.lucrari);
  $$LucrariStariTableTableManager get lucrariStari =>
      $$LucrariStariTableTableManager(_db, _db.lucrariStari);
  $$LocuriConsumTableTableManager get locuriConsum =>
      $$LocuriConsumTableTableManager(_db, _db.locuriConsum);
  $$FurnizoriTableTableManager get furnizori =>
      $$FurnizoriTableTableManager(_db, _db.furnizori);
  $$SolutiiTableTableManager get solutii =>
      $$SolutiiTableTableManager(_db, _db.solutii);
  $$DocumenteTableTableManager get documente =>
      $$DocumenteTableTableManager(_db, _db.documente);
  $$ReleveeTableTableManager get relevee =>
      $$ReleveeTableTableManager(_db, _db.relevee);
  $$PlaneMontajTableTableManager get planeMontaj =>
      $$PlaneMontajTableTableManager(_db, _db.planeMontaj);
  $$ObstacoleTableTableManager get obstacole =>
      $$ObstacoleTableTableManager(_db, _db.obstacole);
  $$TablouriExistenteTableTableManager get tablouriExistente =>
      $$TablouriExistenteTableTableManager(_db, _db.tablouriExistente);
  $$TraseeTableTableManager get trasee =>
      $$TraseeTableTableManager(_db, _db.trasee);
  $$SetariTableTableManager get setari =>
      $$SetariTableTableManager(_db, _db.setari);
}
