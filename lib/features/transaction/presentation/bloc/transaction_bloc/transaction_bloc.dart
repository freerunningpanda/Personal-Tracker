import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/usecases/update_transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';

part 'transaction_state.dart';
part 'transaction_event.dart';

typedef _Emit = Emitter<TransactionState>;

/// [TransactionBloc] is a class.
/// That extends [Bloc] and handles the business logic.
class TransactionBloc extends Bloc<TranscationEvent, TransactionState> {
  /// [TransactionBloc] constructor.
  TransactionBloc(
    this._updateTransaction,
    this._transactionsBloc,
    this._filtersBloc,
  ) : super(const TransactionState()) {
    on<EditTransactionEvent>(_onEditTransactionEvent);
    on<UpdateTransactionEvent>(_onUpdateTransaction);
  }

  final UpdateTransaction _updateTransaction;
  final TransactionsBloc _transactionsBloc;
  final FiltersBloc _filtersBloc;

  Future<void> _onEditTransactionEvent(
    EditTransactionEvent event,
    _Emit emit,
  ) async {
    emit(TransactionState(transaction: event.transaction));

    log('Edited transaction: ${event.transaction}');
  }

  Future<void> _onUpdateTransaction(
    UpdateTransactionEvent event,
    _Emit emit,
  ) async {
    emit(const TransactionState());

    final result = await _updateTransaction.call(
      UpdateTransactionParams(
        transaction: event.transaction,
      ),
    );

    result.fold(
      onSuccess: (_) => _transactionsBloc.add(
        GetFilteredTransactionsEvent(
          category: _filtersBloc.state.category,
          type: _filtersBloc.state.type,
          date: _filtersBloc.state.date,
          valueFilter: _filtersBloc.state.valueFilter,
        ),
      ),
      onFailure: (_) => emit(const TransactionState()),
    );
  }
}
