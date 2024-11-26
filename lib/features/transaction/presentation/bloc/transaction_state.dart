part of 'transaction_bloc.dart';

/// [TransactionState] is a class.
/// That represents the states that can be triggered in the [TransactionBloc].
sealed class TransactionState extends Equatable {
  const TransactionState();

  @override
  List<Object> get props => [];
}

/// [TransactionInitialState] is a class.
/// That represents the initial state of the [TransactionBloc].
final class TransactionInitialState extends TransactionState {
  /// [TransactionInitialState] constructor.
  const TransactionInitialState();
}

/// [TransactionLoadingState] is a class.
/// That represents the loading state of the [TransactionBloc].
final class TransactionLoadingState extends TransactionState {
  /// [TransactionLoadingState] constructor.
  const TransactionLoadingState();
}

/// [TransactionLoadedState] is a class.
/// That represents the loaded state of the [TransactionBloc].
final class TransactionLoadedState extends TransactionState {
  /// [TransactionLoadedState] constructor.
  const TransactionLoadedState(this.transactions);

  /// [transactions] is the list of transactions.
  final List<Transaction> transactions;

  @override
  List<Object> get props => [transactions];
}

/// [TransactionErrorState] is a class.
/// That represents the error state of the [TransactionBloc].
final class TransactionErrorState extends TransactionState {
  /// [TransactionErrorState] constructor.
  const TransactionErrorState(this.message);

  /// [message] is the error message.
  final String message;

  @override
  List<Object> get props => [message];
}
