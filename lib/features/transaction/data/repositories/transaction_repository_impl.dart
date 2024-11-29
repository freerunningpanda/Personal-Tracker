import 'package:tracker/core/data/datasources/local/local_datasource.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/features/transaction/data/models/transaction_model.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';
import 'package:tracker/features/transaction/domain/usecases/create_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/get_filtered_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/search_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/update_transaction.dart';

/// [TransactionRepositoryImpl] is a class.
/// That implements [TransactionRepository] interface.
class TransactionRepositoryImpl implements TransactionRepository {
  /// [TransactionRepositoryImpl] constructor.
  TransactionRepositoryImpl(this._localDatasource);

  final LocalDatasource _localDatasource;

  final _transactions = <Transaction>[];

  @override
  Future<Result<void>> createTransaction(CreateTransactionParams params) async {
    try {
      await _localDatasource.writeTransaction(
        TransactionModel.fromUIEntity(
          params.transaction,
        ),
      );

      return Success();
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<void>> deleteTransaction(DeleteTransactionParams params) async {
    try {
      await _localDatasource.deleteTransaction(params.id);

      return Success();
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactions() async {
    try {
      _transactions.clear();
      final transactions = await _localDatasource.getTransactions();

      _transactions.addAll(transactions);

      return Success(data: _transactions);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<void>> updateTransaction(UpdateTransactionParams params) async {
    try {
      await _localDatasource.updateTransaction(
        TransactionModel.fromUIEntity(
          params.transaction,
        ),
      );

      return Success();
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<List<Transaction>>> getFilteredTransactions(
    GetFilteredTransactionsParams params,
  ) async {
    try {
      _transactions.clear();
      final transactions =
          await _localDatasource.getFilteredTransactions(params);

      _transactions.addAll(transactions);

      return Success(data: _transactions);
    } catch (e) {
      return Failure(e.toString());
    }
  }

  @override
  Future<Result<List<Transaction>>> searchTransactions(
    SearchTransactionsParams params,
  ) async {
    try {
      final foundedTransactions = _transactions
          .where((transaction) => transaction.title.contains(params.query))
          .toList();

      return Success(data: foundedTransactions);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
