import 'package:drift/drift.dart';
import 'package:tracker/core/data/datasources/local/local_datasource.dart';
import 'package:tracker/core/database/app_database.dart';
import 'package:tracker/features/transaction/data/models/transaction_model.dart';

/// [LocalDatasourceImpl] is a class.
/// It is an implementation of the [LocalDatasource] interface.
class LocalDatasourceImpl implements LocalDatasource {
  /// [LocalDatasourceImpl] constructor.
  LocalDatasourceImpl(this._drift);

  final AppDatabase _drift;

  @override
  Future<List<TransactionModel>> getTransactions() async {
    final trasactions =
        await _drift.select(_drift.transactionDriftEntity).get();

    return trasactions.map(TransactionModel.fromDriftEntity).toList();
  }

  @override
  Future<void> deleteTransaction(int id) async =>
      (_drift.delete(_drift.transactionDriftEntity)
            ..where((t) => t.id.equals(id)))
          .go();

  @override
  Future<void> writeTransaction(TransactionModel transaction) async =>
      _drift.into(_drift.transactionDriftEntity).insert(
            TransactionDriftEntityCompanion.insert(
              title: transaction.title,
              value: transaction.value,
              type: transaction.type,
              category: transaction.category,
              createdAt: Value(transaction.createdAt ?? DateTime.now()),
            ),
          );

  @override
  Future<void> updateTransaction(TransactionModel transaction) async {
    if (transaction.id == null) {
      return;
    }
    final existingTransactions =
        await (_drift.select(_drift.transactionDriftEntity)
              ..where((tbl) => tbl.id.equals(transaction.id!)))
            .getSingleOrNull();

    if (existingTransactions != null) {
      await (_drift.update(_drift.transactionDriftEntity)
            ..where((t) => t.id.equals(transaction.id!)))
          .write(
        TransactionDriftEntityCompanion(
          title: Value(transaction.title),
          value: Value(transaction.value),
          type: Value(transaction.type),
          category: Value(transaction.category),
          updatedAt: Value(
            transaction.updatedAt ?? DateTime.now(),
          ),
        ),
      );
    }
  }
}
