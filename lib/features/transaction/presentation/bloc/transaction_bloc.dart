import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/create_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/get_filtered_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/get_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/update_transaction.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

typedef _Emit = Emitter<TransactionState>;

/// [TransactionBloc] is a class.
/// That extends [Bloc] and handles the business logic.
class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  /// [TransactionBloc] constructor.
  TransactionBloc(
    this._getTransactions,
    this._createTransaction,
    this._updateTransaction,
    this._deleteTransaction,
    this._getFilteredTransactions,
  ) : super(const TransactionInitialState()) {
    on<_GetTransactionsEvent>(_onGetTransactions);
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<GetFilteredTransactionsEvent>(_onGetFilteredTransactions);
    add(const _GetTransactionsEvent());
  }

  final GetTransactions _getTransactions;
  final CreateTransaction _createTransaction;
  final UpdateTransaction _updateTransaction;
  final DeleteTransaction _deleteTransaction;
  final GetFilteredTransactions _getFilteredTransactions;

  Future<void> _onGetTransactions(
    _GetTransactionsEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionLoadingState());

    final result = await _getTransactions.call(NoParams());

    result.fold(
      onSuccess: (transactions) {
        emit(
          TransactionLoadedState(transactions.data ?? []),
        );

        if (transactions.data?.isEmpty ?? true) {
          emit(const TransactionInitialState());
        }
      },
      onFailure: (failure) => emit(
        TransactionErrorState(failure.message),
      ),
    );
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionLoadingState());

    final result = await _createTransaction.call(
      CreateTransactionParams(
        transaction: event.transaction,
      ),
    );

    result.fold(
      onSuccess: (_) => add(const _GetTransactionsEvent()),
      onFailure: (failure) => emit(
        TransactionErrorState(failure.message),
      ),
    );
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionLoadingState());

    final result = await _updateTransaction.call(
      UpdateTransactionParams(
        transaction: event.transaction,
      ),
    );

    result.fold(
      onSuccess: (_) => add(const _GetTransactionsEvent()),
      onFailure: (failure) => emit(
        TransactionErrorState(failure.message),
      ),
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionLoadingState());

    final result = await _deleteTransaction.call(
      DeleteTransactionParams(
        id: event.id,
      ),
    );

    result.fold(
      onSuccess: (_) => add(const _GetTransactionsEvent()),
      onFailure: (failure) => emit(
        TransactionErrorState(failure.message),
      ),
    );
  }

  Future<void> _onGetFilteredTransactions(
    GetFilteredTransactionsEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionLoadingState());

    final result = await _getFilteredTransactions.call(
      GetFilteredTransactionsParams(
        category: event.params.category,
        type: event.params.type,
        date: event.params.date,
        valueFilter: event.params.valueFilter,
      ),
    );

    result.fold(
      onSuccess: (transactions) {
        emit(
          TransactionLoadedState(transactions.data ?? []),
        );

        if (transactions.data?.isEmpty ?? true) {
          emit(const TransactionInitialState());
        }
      },
      onFailure: (failure) => emit(
        TransactionErrorState(failure.message),
      ),
    );
  }
}
