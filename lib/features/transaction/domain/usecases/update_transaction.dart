import 'package:equatable/equatable.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [UpdateTransaction] is a class.
/// It is a use case class that updates a transaction.
class UpdateTransaction implements UseCase<void, UpdateTransactionParams> {
  /// [UpdateTransaction] constructor.
  const UpdateTransaction(this._repository);

  /// [TransactionRepository] instance.
  final TransactionRepository _repository;

  @override
  Future<Result<void>> call(UpdateTransactionParams params) =>
      _repository.updateTransaction(params);
}

/// [UpdateTransactionParams] is a class.
/// It is used to pass the required parameters to the [UpdateTransaction] class.
class UpdateTransactionParams extends Equatable {
  /// [UpdateTransactionParams] constructor.
  const UpdateTransactionParams({required this.transaction});

  /// [transaction] is the transaction to be updated.
  final Transaction transaction;

  @override
  List<Object?> get props => [transaction];
}
