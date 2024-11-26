// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TransactionDriftEntityTable extends TransactionDriftEntity
    with TableInfo<$TransactionDriftEntityTable, TransactionDriftEntityData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionDriftEntityTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TransactionType>(
              $TransactionDriftEntityTable.$convertertype);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumnWithTypeConverter<TransactionCategory, String>
      category = GeneratedColumn<String>('category', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<TransactionCategory>(
              $TransactionDriftEntityTable.$convertercategory);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, value, type, category, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transaction_drift_entity';
  @override
  VerificationContext validateIntegrity(
      Insertable<TransactionDriftEntityData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    context.handle(_categoryMeta, const VerificationResult.success());
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TransactionDriftEntityData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TransactionDriftEntityData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      type: $TransactionDriftEntityTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      category: $TransactionDriftEntityTable.$convertercategory.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}category'])!),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at']),
    );
  }

  @override
  $TransactionDriftEntityTable createAlias(String alias) {
    return $TransactionDriftEntityTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, String, String> $convertertype =
      const EnumNameConverter<TransactionType>(TransactionType.values);
  static JsonTypeConverter2<TransactionCategory, String, String>
      $convertercategory =
      const EnumNameConverter<TransactionCategory>(TransactionCategory.values);
}

class TransactionDriftEntityData extends DataClass
    implements Insertable<TransactionDriftEntityData> {
  /// [id] is a unique identifier.
  final int id;

  /// [title] is the title of the transaction.
  final String title;

  /// [value] is the amount of the transaction.
  final double value;

  /// [type] is the type of the transaction.
  final TransactionType type;

  /// [category] is the category of the transaction.
  final TransactionCategory category;

  /// [createdAt] is the date of creation of the transaction.
  final DateTime createdAt;

  /// [updatedAt] is the date of the last update of the transaction.
  final DateTime? updatedAt;
  const TransactionDriftEntityData(
      {required this.id,
      required this.title,
      required this.value,
      required this.type,
      required this.category,
      required this.createdAt,
      this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['value'] = Variable<double>(value);
    {
      map['type'] = Variable<String>(
          $TransactionDriftEntityTable.$convertertype.toSql(type));
    }
    {
      map['category'] = Variable<String>(
          $TransactionDriftEntityTable.$convertercategory.toSql(category));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  TransactionDriftEntityCompanion toCompanion(bool nullToAbsent) {
    return TransactionDriftEntityCompanion(
      id: Value(id),
      title: Value(title),
      value: Value(value),
      type: Value(type),
      category: Value(category),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory TransactionDriftEntityData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TransactionDriftEntityData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      value: serializer.fromJson<double>(json['value']),
      type: $TransactionDriftEntityTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      category: $TransactionDriftEntityTable.$convertercategory
          .fromJson(serializer.fromJson<String>(json['category'])),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'value': serializer.toJson<double>(value),
      'type': serializer.toJson<String>(
          $TransactionDriftEntityTable.$convertertype.toJson(type)),
      'category': serializer.toJson<String>(
          $TransactionDriftEntityTable.$convertercategory.toJson(category)),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  TransactionDriftEntityData copyWith(
          {int? id,
          String? title,
          double? value,
          TransactionType? type,
          TransactionCategory? category,
          DateTime? createdAt,
          Value<DateTime?> updatedAt = const Value.absent()}) =>
      TransactionDriftEntityData(
        id: id ?? this.id,
        title: title ?? this.title,
        value: value ?? this.value,
        type: type ?? this.type,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
      );
  TransactionDriftEntityData copyWithCompanion(
      TransactionDriftEntityCompanion data) {
    return TransactionDriftEntityData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      value: data.value.present ? data.value.value : this.value,
      type: data.type.present ? data.type.value : this.type,
      category: data.category.present ? data.category.value : this.category,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TransactionDriftEntityData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, value, type, category, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TransactionDriftEntityData &&
          other.id == this.id &&
          other.title == this.title &&
          other.value == this.value &&
          other.type == this.type &&
          other.category == this.category &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TransactionDriftEntityCompanion
    extends UpdateCompanion<TransactionDriftEntityData> {
  final Value<int> id;
  final Value<String> title;
  final Value<double> value;
  final Value<TransactionType> type;
  final Value<TransactionCategory> category;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  const TransactionDriftEntityCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.value = const Value.absent(),
    this.type = const Value.absent(),
    this.category = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  TransactionDriftEntityCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required double value,
    required TransactionType type,
    required TransactionCategory category,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  })  : title = Value(title),
        value = Value(value),
        type = Value(type),
        category = Value(category);
  static Insertable<TransactionDriftEntityData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<double>? value,
    Expression<String>? type,
    Expression<String>? category,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (value != null) 'value': value,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  TransactionDriftEntityCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<double>? value,
      Value<TransactionType>? type,
      Value<TransactionCategory>? category,
      Value<DateTime>? createdAt,
      Value<DateTime?>? updatedAt}) {
    return TransactionDriftEntityCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      type: type ?? this.type,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
          $TransactionDriftEntityTable.$convertertype.toSql(type.value));
    }
    if (category.present) {
      map['category'] = Variable<String>($TransactionDriftEntityTable
          .$convertercategory
          .toSql(category.value));
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionDriftEntityCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('value: $value, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TransactionDriftEntityTable transactionDriftEntity =
      $TransactionDriftEntityTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [transactionDriftEntity];
}

typedef $$TransactionDriftEntityTableCreateCompanionBuilder
    = TransactionDriftEntityCompanion Function({
  Value<int> id,
  required String title,
  required double value,
  required TransactionType type,
  required TransactionCategory category,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});
typedef $$TransactionDriftEntityTableUpdateCompanionBuilder
    = TransactionDriftEntityCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<double> value,
  Value<TransactionType> type,
  Value<TransactionCategory> category,
  Value<DateTime> createdAt,
  Value<DateTime?> updatedAt,
});

class $$TransactionDriftEntityTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionDriftEntityTable> {
  $$TransactionDriftEntityTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
      get type => $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<TransactionCategory, TransactionCategory,
          String>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionDriftEntityTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionDriftEntityTable> {
  $$TransactionDriftEntityTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionDriftEntityTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionDriftEntityTable> {
  $$TransactionDriftEntityTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionCategory, String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$TransactionDriftEntityTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionDriftEntityTable,
    TransactionDriftEntityData,
    $$TransactionDriftEntityTableFilterComposer,
    $$TransactionDriftEntityTableOrderingComposer,
    $$TransactionDriftEntityTableAnnotationComposer,
    $$TransactionDriftEntityTableCreateCompanionBuilder,
    $$TransactionDriftEntityTableUpdateCompanionBuilder,
    (
      TransactionDriftEntityData,
      BaseReferences<_$AppDatabase, $TransactionDriftEntityTable,
          TransactionDriftEntityData>
    ),
    TransactionDriftEntityData,
    PrefetchHooks Function()> {
  $$TransactionDriftEntityTableTableManager(
      _$AppDatabase db, $TransactionDriftEntityTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionDriftEntityTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionDriftEntityTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionDriftEntityTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<TransactionType> type = const Value.absent(),
            Value<TransactionCategory> category = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              TransactionDriftEntityCompanion(
            id: id,
            title: title,
            value: value,
            type: type,
            category: category,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required double value,
            required TransactionType type,
            required TransactionCategory category,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> updatedAt = const Value.absent(),
          }) =>
              TransactionDriftEntityCompanion.insert(
            id: id,
            title: title,
            value: value,
            type: type,
            category: category,
            createdAt: createdAt,
            updatedAt: updatedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionDriftEntityTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $TransactionDriftEntityTable,
        TransactionDriftEntityData,
        $$TransactionDriftEntityTableFilterComposer,
        $$TransactionDriftEntityTableOrderingComposer,
        $$TransactionDriftEntityTableAnnotationComposer,
        $$TransactionDriftEntityTableCreateCompanionBuilder,
        $$TransactionDriftEntityTableUpdateCompanionBuilder,
        (
          TransactionDriftEntityData,
          BaseReferences<_$AppDatabase, $TransactionDriftEntityTable,
              TransactionDriftEntityData>
        ),
        TransactionDriftEntityData,
        PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TransactionDriftEntityTableTableManager get transactionDriftEntity =>
      $$TransactionDriftEntityTableTableManager(
          _db, _db.transactionDriftEntity);
}
