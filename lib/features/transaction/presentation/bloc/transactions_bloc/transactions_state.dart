part of 'transactions_bloc.dart';

/// [TransactionsState] is a class.
/// That represents the states that can be triggered in the [TransactionsBloc].
sealed class TransactionsState extends Equatable {
  const TransactionsState();

  @override
  List<Object> get props => [];
}

/// [TransactionsInitialState] is a class.
/// That represents the initial state of the [TransactionsBloc].
final class TransactionsInitialState extends TransactionsState {
  /// [TransactionsInitialState] constructor.
  const TransactionsInitialState();
}

/// [TransactionsLoadingState] is a class.
/// That represents the loading state of the [TransactionsBloc].
final class TransactionsLoadingState extends TransactionsState {
  /// [TransactionsLoadingState] constructor.
  const TransactionsLoadingState();
}

/// [TransactionsLoadedState] is a class.
/// That represents the loaded state of the [TransactionsBloc].
final class TransactionsLoadedState extends TransactionsState {
  /// [TransactionsLoadedState] constructor.
  const TransactionsLoadedState(this.transactions);

  /// [transactions] is the list of transactions.
  final List<Transaction> transactions;

  @override
  List<Object> get props => [transactions];
}

/// [TransactionsErrorState] is a class.
/// That represents the error state of the [TransactionsBloc].
final class TransactionsErrorState extends TransactionsState {
  /// [TransactionsErrorState] constructor.
  const TransactionsErrorState(this.message);

  /// [message] is the error message.
  final String message;

  @override
  List<Object> get props => [message];
}
