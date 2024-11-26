import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [GetTransactions] is a class.
/// It is a use case class that gets a list of transactions.
class GetTransactions implements UseCase<List<Transaction>, NoParams> {
  /// [GetTransactions] constructor.
  const GetTransactions(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Result<List<Transaction>>> call(NoParams params) =>
      _repository.getTransactions();
}
