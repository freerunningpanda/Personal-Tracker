import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/features/transaction/data/datasources/drift_tables/transaction_drift_entity.dart';

part 'app_database.g.dart';

@DriftDatabase(tables: [TransactionDriftEntity])

/// [AppDatabase] is a database class.
/// It is used to create a database instance.
class AppDatabase extends _$AppDatabase {
  /// [AppDatabase] constructor
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() => driftDatabase(name: 'app_database');
}
