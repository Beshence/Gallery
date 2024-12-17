// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'media.dart';

// ignore_for_file: type=lint
class $LocalMediaTable extends LocalMedia
    with TableInfo<$LocalMediaTable, LocalMediaData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalMediaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _modifiedAtMeta =
      const VerificationMeta('modifiedAt');
  @override
  late final GeneratedColumn<DateTime> modifiedAt = GeneratedColumn<DateTime>(
      'modified_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, modifiedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_media';
  @override
  VerificationContext validateIntegrity(Insertable<LocalMediaData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('modified_at')) {
      context.handle(
          _modifiedAtMeta,
          modifiedAt.isAcceptableOrUnknown(
              data['modified_at']!, _modifiedAtMeta));
    } else if (isInserting) {
      context.missing(_modifiedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalMediaData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalMediaData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      modifiedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}modified_at'])!,
    );
  }

  @override
  $LocalMediaTable createAlias(String alias) {
    return $LocalMediaTable(attachedDatabase, alias);
  }
}

class LocalMediaData extends DataClass implements Insertable<LocalMediaData> {
  final String id;
  final String name;
  final DateTime modifiedAt;
  const LocalMediaData(
      {required this.id, required this.name, required this.modifiedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['modified_at'] = Variable<DateTime>(modifiedAt);
    return map;
  }

  LocalMediaCompanion toCompanion(bool nullToAbsent) {
    return LocalMediaCompanion(
      id: Value(id),
      name: Value(name),
      modifiedAt: Value(modifiedAt),
    );
  }

  factory LocalMediaData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalMediaData(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      modifiedAt: serializer.fromJson<DateTime>(json['modifiedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'modifiedAt': serializer.toJson<DateTime>(modifiedAt),
    };
  }

  LocalMediaData copyWith({String? id, String? name, DateTime? modifiedAt}) =>
      LocalMediaData(
        id: id ?? this.id,
        name: name ?? this.name,
        modifiedAt: modifiedAt ?? this.modifiedAt,
      );
  LocalMediaData copyWithCompanion(LocalMediaCompanion data) {
    return LocalMediaData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      modifiedAt:
          data.modifiedAt.present ? data.modifiedAt.value : this.modifiedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalMediaData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modifiedAt: $modifiedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, modifiedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalMediaData &&
          other.id == this.id &&
          other.name == this.name &&
          other.modifiedAt == this.modifiedAt);
}

class LocalMediaCompanion extends UpdateCompanion<LocalMediaData> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> modifiedAt;
  final Value<int> rowid;
  const LocalMediaCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.modifiedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalMediaCompanion.insert({
    required String id,
    required String name,
    required DateTime modifiedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        name = Value(name),
        modifiedAt = Value(modifiedAt);
  static Insertable<LocalMediaData> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? modifiedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (modifiedAt != null) 'modified_at': modifiedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalMediaCompanion copyWith(
      {Value<String>? id,
      Value<String>? name,
      Value<DateTime>? modifiedAt,
      Value<int>? rowid}) {
    return LocalMediaCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (modifiedAt.present) {
      map['modified_at'] = Variable<DateTime>(modifiedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalMediaCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('modifiedAt: $modifiedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$MediaDatabase extends GeneratedDatabase {
  _$MediaDatabase(QueryExecutor e) : super(e);
  $MediaDatabaseManager get managers => $MediaDatabaseManager(this);
  late final $LocalMediaTable localMedia = $LocalMediaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [localMedia];
}

typedef $$LocalMediaTableCreateCompanionBuilder = LocalMediaCompanion Function({
  required String id,
  required String name,
  required DateTime modifiedAt,
  Value<int> rowid,
});
typedef $$LocalMediaTableUpdateCompanionBuilder = LocalMediaCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<DateTime> modifiedAt,
  Value<int> rowid,
});

class $$LocalMediaTableFilterComposer
    extends Composer<_$MediaDatabase, $LocalMediaTable> {
  $$LocalMediaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalMediaTableOrderingComposer
    extends Composer<_$MediaDatabase, $LocalMediaTable> {
  $$LocalMediaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalMediaTableAnnotationComposer
    extends Composer<_$MediaDatabase, $LocalMediaTable> {
  $$LocalMediaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get modifiedAt => $composableBuilder(
      column: $table.modifiedAt, builder: (column) => column);
}

class $$LocalMediaTableTableManager extends RootTableManager<
    _$MediaDatabase,
    $LocalMediaTable,
    LocalMediaData,
    $$LocalMediaTableFilterComposer,
    $$LocalMediaTableOrderingComposer,
    $$LocalMediaTableAnnotationComposer,
    $$LocalMediaTableCreateCompanionBuilder,
    $$LocalMediaTableUpdateCompanionBuilder,
    (
      LocalMediaData,
      BaseReferences<_$MediaDatabase, $LocalMediaTable, LocalMediaData>
    ),
    LocalMediaData,
    PrefetchHooks Function()> {
  $$LocalMediaTableTableManager(_$MediaDatabase db, $LocalMediaTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalMediaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalMediaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalMediaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<DateTime> modifiedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalMediaCompanion(
            id: id,
            name: name,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String name,
            required DateTime modifiedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalMediaCompanion.insert(
            id: id,
            name: name,
            modifiedAt: modifiedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalMediaTableProcessedTableManager = ProcessedTableManager<
    _$MediaDatabase,
    $LocalMediaTable,
    LocalMediaData,
    $$LocalMediaTableFilterComposer,
    $$LocalMediaTableOrderingComposer,
    $$LocalMediaTableAnnotationComposer,
    $$LocalMediaTableCreateCompanionBuilder,
    $$LocalMediaTableUpdateCompanionBuilder,
    (
      LocalMediaData,
      BaseReferences<_$MediaDatabase, $LocalMediaTable, LocalMediaData>
    ),
    LocalMediaData,
    PrefetchHooks Function()>;

class $MediaDatabaseManager {
  final _$MediaDatabase _db;
  $MediaDatabaseManager(this._db);
  $$LocalMediaTableTableManager get localMedia =>
      $$LocalMediaTableTableManager(_db, _db.localMedia);
}
