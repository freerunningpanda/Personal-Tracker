import 'package:drift/drift.dart';
import 'package:tracker/core/data/datasources/local/local_datasource.dart';
import 'package:tracker/core/database/app_database.dart';
import 'package:tracker/features/transaction/data/models/transaction_model.dart';
import 'package:tracker/features/transaction/domain/usecases/get_filtered_transactions.dart';

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
              limit: Value(transaction.limit),
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
          limit: Value(transaction.limit),
        ),
      );
    }
  }

  @override
  Future<List<TransactionModel>> getFilteredTransactions(
    GetFilteredTransactionsParams params,
  ) async {
    final trasactions =
        await _drift.select(_drift.transactionDriftEntity).get();

    final transactionsModel =
        trasactions.map(TransactionModel.fromDriftEntity).toList();

    // transactionsModel.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));
    final filteredList = transactionsModel.where((transaction) {
      final matchesCategory =
          params.category == null || params.category == transaction.category;
      final matchesType =
          params.type == null || params.type == transaction.type;
      final matchesDate = params.date == null ||
          (transaction.updatedAt != null
              ? params.date?.day == transaction.updatedAt?.day
              : params.date?.day == transaction.createdAt?.day);

      return matchesCategory && matchesType && matchesDate;
    }).toList();

    if (params.valueFilter?.name == 'less') {
      filteredList.sort((a, b) => a.value.compareTo(b.value));
    } else if (params.valueFilter?.name == 'more') {
      filteredList.sort((a, b) => b.value.compareTo(a.value));
    }

    return filteredList;
  }
}
