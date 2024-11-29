part of 'transactions_bloc.dart';

/// [TransactionsEvent] is a class.
/// That represents the events that can be triggered in the [TransactionsBloc].
sealed class TransactionsEvent {
  const TransactionsEvent();
}

/// [GetTransactionsEvent] is a class.
/// That represents the event to get transactions.
final class GetTransactionsEvent extends TransactionsEvent {
  /// [GetTransactionsEvent] constructor.
  const GetTransactionsEvent();
}

/// [CreateTransactionEvent] is a class.
/// That represents the event to create a transaction.
final class CreateTransactionEvent extends TransactionsEvent {
  /// [CreateTransactionEvent] constructor.
  const CreateTransactionEvent(this.transaction);

  /// [transaction] is the transaction to be created.
  final Transaction transaction;
}

/// [DeleteTransactionEvent] is a class.
/// That represents the event to delete a transaction.
final class DeleteTransactionEvent extends TransactionsEvent {
  /// [DeleteTransactionEvent] constructor.
  const DeleteTransactionEvent(this.id);

  /// [id] is the id of the transaction to be deleted.
  final int id;
}

/// [GetFilteredTransactionsEvent] is a class.
/// That represents the event to get filtered transactions.
final class GetFilteredTransactionsEvent extends TransactionsEvent {
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
final class SearchTransactionsEvent extends TransactionsEvent {
  /// [SearchTransactionsEvent] constructor.
  const SearchTransactionsEvent(this.query);

  /// [query] is the query to search transactions.
  final String query;
}
