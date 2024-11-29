part of 'transaction_bloc.dart';

/// [TranscationEvent] is a class.
/// That represents the events that can be triggered in the [TransactionBloc].
sealed class TranscationEvent {
  const TranscationEvent();
}

/// [EditTransactionEvent] is a class.
/// That represents the event to edit a transaction.
final class EditTransactionEvent extends TranscationEvent {
  /// [EditTransactionEvent] constructor.
  const EditTransactionEvent({required this.transaction});

  /// [transaction] is the transaction to be edited.
  final Transaction transaction;
}

/// [UpdateTransactionEvent] is a class.
/// That represents the event to update a transaction.
final class UpdateTransactionEvent extends TranscationEvent {
  /// [UpdateTransactionEvent] constructor.
  const UpdateTransactionEvent({required this.transaction});

  /// [transaction] is the transaction to be updated.
  final Transaction transaction;
}
