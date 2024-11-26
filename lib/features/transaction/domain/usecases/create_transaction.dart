import 'package:equatable/equatable.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [CreateTransaction] is a class.
/// It is a use case class that creates a transaction.
class CreateTransaction implements UseCase<void, CreateTransactionParams> {
  /// [CreateTransaction] constructor.
  const CreateTransaction(this._repository);

  /// [TransactionRepository] instance.
  final TransactionRepository _repository;

  @override
  Future<Result<void>> call(CreateTransactionParams params) =>
      _repository.createTransaction(params);
}

/// [CreateTransactionParams] is a class.
/// It is used to pass the required parameters to the [CreateTransaction] class.
class CreateTransactionParams extends Equatable {
  /// [CreateTransactionParams] constructor.
  const CreateTransactionParams({
    required this.transaction,
  });

  /// [transaction] is the transaction to be created.
  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}
