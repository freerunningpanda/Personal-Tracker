import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/enums/value_filter.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/create_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/delete_transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/get_filtered_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/get_transactions.dart';
import 'package:tracker/features/transaction/domain/usecases/search_transactions.dart';

part 'transactions_event.dart';
part 'transactions_state.dart';

typedef _Emit = Emitter<TransactionsState>;

/// [TransactionsBloc] is a class.
/// That extends [Bloc] and handles the business logic.
class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  /// [TransactionsBloc] constructor.
  TransactionsBloc(
    this._getTransactions,
    this._createTransaction,
    this._deleteTransaction,
    this._getFilteredTransactions,
    this._searchTransactions,
    this._analysisBloc,
  ) : super(const TransactionsInitialState()) {
    on<GetTransactionsEvent>(_onGetTransactions);
    on<CreateTransactionEvent>(_onCreateTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<GetFilteredTransactionsEvent>(_onGetFilteredTransactions);
    on<SearchTransactionsEvent>(_onSearchTransactions);
    add(const GetTransactionsEvent());
  }

  final GetTransactions _getTransactions;
  final CreateTransaction _createTransaction;
  final DeleteTransaction _deleteTransaction;
  final GetFilteredTransactions _getFilteredTransactions;
  final SearchTransactions _searchTransactions;
  final AnalysisBloc _analysisBloc;

  Future<void> _onGetTransactions(
    GetTransactionsEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionsLoadingState());

    final result = await _getTransactions.call(NoParams());

    result.fold(
      onSuccess: (transactions) {
        if (transactions.data?.isEmpty ?? true) {
          emit(const TransactionsInitialState());

          return;
        }
        emit(
          TransactionsLoadedState(transactions.data ?? []),
        );

        _analysisBloc.add(const GetAnalysisEvent());
      },
      onFailure: (failure) => emit(
        TransactionsErrorState(failure.message),
      ),
    );
  }

  Future<void> _onCreateTransaction(
    CreateTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionsLoadingState());

    final result = await _createTransaction.call(
      CreateTransactionParams(
        transaction: event.transaction,
      ),
    );

    result.fold(
      onSuccess: (_) => add(const GetTransactionsEvent()),
      onFailure: (failure) => emit(
        TransactionsErrorState(failure.message),
      ),
    );
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionsLoadingState());

    final result = await _deleteTransaction.call(
      DeleteTransactionParams(
        id: event.id,
      ),
    );

    result.fold(
      onSuccess: (_) => add(const GetTransactionsEvent()),
      onFailure: (failure) => emit(
        TransactionsErrorState(failure.message),
      ),
    );
  }

  Future<void> _onGetFilteredTransactions(
    GetFilteredTransactionsEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionsLoadingState());

    final result = await _getFilteredTransactions.call(
      GetFilteredTransactionsParams(
        category: event.category,
        type: event.type,
        date: event.date,
        valueFilter: event.valueFilter,
      ),
    );

    result.fold(
      onSuccess: (transactions) {
        emit(
          TransactionsLoadedState(transactions.data ?? []),
        );

        _analysisBloc.add(const GetAnalysisEvent());
      },
      onFailure: (failure) => emit(
        TransactionsErrorState(failure.message),
      ),
    );
  }

  Future<void> _onSearchTransactions(
    SearchTransactionsEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionsLoadingState());

    final result = await _searchTransactions.call(
      SearchTransactionsParams(
        query: event.query,
      ),
    );

    result.fold(
      onSuccess: (transactions) {
        emit(
          TransactionsLoadedState(transactions.data ?? []),
        );
      },
      onFailure: (failure) => emit(
        TransactionsErrorState(failure.message),
      ),
    );
  }
}
