import 'package:tracker/core/output/result.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/create_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/update_transaction.dart';

/// [TransactionRepository] is an interface class.
abstract interface class TransactionRepository {
  /// method [createTransaction] creates a transaction.
  Future<Result<void>> createTransaction(CreateTransactionParams params);

  /// method [updateTransaction] updates a transaction.
  Future<Result<void>> updateTransaction(UpdateTransactionParams params);

  /// method [deleteTransaction] deletes a transaction.
  Future<Result<void>> deleteTransaction(DeleteTransactionParams params);

  /// method [getTransactions] gets a list of transactions.
  Future<Result<List<Transaction>>> getTransactions();
}
