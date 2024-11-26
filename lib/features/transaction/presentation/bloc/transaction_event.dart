part of 'transaction_bloc.dart';

/// [TransactionEvent] is a class.
/// That represents the events that can be triggered in the [TransactionBloc].
sealed class TransactionEvent {
  const TransactionEvent();
}

/// [_GetTransactionsEvent] is a class.
/// That represents the event to get transactions.
class _GetTransactionsEvent extends TransactionEvent {
  /// [_GetTransactionsEvent] constructor.
  const _GetTransactionsEvent();
}

/// [CreateTransactionEvent] is a class.
/// That represents the event to create a transaction.
class CreateTransactionEvent extends TransactionEvent {
  /// [CreateTransactionEvent] constructor.
  const CreateTransactionEvent(this.transaction);

  /// [transaction] is the transaction to be created.
  final Transaction transaction;
}

/// [UpdateTransactionEvent] is a class.
/// That represents the event to update a transaction.
class UpdateTransactionEvent extends TransactionEvent {
  /// [UpdateTransactionEvent] constructor.
  const UpdateTransactionEvent(this.transaction);

  /// [transaction] is the transaction to be updated.
  final Transaction transaction;
}

/// [DeleteTransactionEvent] is a class.
/// That represents the event to delete a transaction.
class DeleteTransactionEvent extends TransactionEvent {
  /// [DeleteTransactionEvent] constructor.
  const DeleteTransactionEvent(this.id);

  /// [id] is the id of the transaction to be deleted.
  final int id;
}
