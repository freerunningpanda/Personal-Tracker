part of 'transaction_bloc.dart';

/// [TransactionEvent] is a class.
/// That represents the events that can be triggered in the [TransactionBloc].
sealed class TransactionEvent {
  const TransactionEvent();
}

/// [GetTransactionsEvent] is a class.
/// That represents the event to get transactions.
class GetTransactionsEvent extends TransactionEvent {
  /// [GetTransactionsEvent] constructor.
  const GetTransactionsEvent();
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

/// [GetFilteredTransactionsEvent] is a class.
/// That represents the event to get filtered transactions.
class GetFilteredTransactionsEvent extends TransactionEvent {
  /// [GetFilteredTransactionsEvent] constructor.
  const GetFilteredTransactionsEvent({
    this.category,
    this.type,
    this.date,
    this.valueFilter,
  });

  /// [category] is the transaction category.
  final TransactionCategory? category;

  /// [type] is the transaction type.
  final TransactionType? type;

  /// [date] is the date to filter the transactions.
  final DateTime? date;

  /// [valueFilter] is the value filter to filter the transactions.
  final ValueFilter? valueFilter;
}

/// [SearchTransactionsEvent] is a class.
/// That represents the event to search transactions by name.
class SearchTransactionsEvent extends TransactionEvent {
  /// [SearchTransactionsEvent] constructor.
  const SearchTransactionsEvent(this.query);

  /// [query] is the query to search transactions.
  final String query;
}
