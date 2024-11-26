import 'package:equatable/equatable.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [DeleteTransaction] is a class.
/// It is a use case class that deletes a transaction.
class DeleteTransaction implements UseCase<void, DeleteTransactionParams> {
  /// [DeleteTransaction] constructor.
  const DeleteTransaction(this._repository);

  /// [TransactionRepository] instance.
  final TransactionRepository _repository;

  @override
  Future<Result<void>> call(DeleteTransactionParams params) =>
      _repository.deleteTransaction(params);
}

/// [DeleteTransactionParams] is a class.
/// It is used to pass the required parameters to the [DeleteTransaction] class.
class DeleteTransactionParams extends Equatable {
  /// [DeleteTransactionParams] constructor.
  const DeleteTransactionParams({
    required this.id,
  });

  /// [id] is the id of the transaction.
  final int id;

  @override
  List<Object?> get props => [id];
}
