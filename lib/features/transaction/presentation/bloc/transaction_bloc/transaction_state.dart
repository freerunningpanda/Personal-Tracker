part of 'transaction_bloc.dart';

/// [TransactionState] is a class.
/// That represents the states that can be triggered in the [TransactionBloc].
class TransactionState extends Equatable {
  /// [TransactionState] constructor.
  const TransactionState({this.transaction});

  /// [transaction] is the transaction.
  final Transaction? transaction;

  @override
  List<Object?> get props => [transaction];
}
