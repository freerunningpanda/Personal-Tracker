import 'package:equatable/equatable.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/enums/value_filter.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [GetFilteredTransactions] use case class.
/// That gets the filtered transactions.
class GetFilteredTransactions
    implements UseCase<List<Transaction>, GetFilteredTransactionsParams> {
  /// [GetFilteredTransactions] constructor.
  GetFilteredTransactions(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Result<List<Transaction>>> call(
    GetFilteredTransactionsParams params,
  ) =>
      _repository.getFilteredTransactions(params);
}

/// [GetFilteredTransactionsParams] is a class.
/// That contains the parameters for the [GetFilteredTransactions] use case.
class GetFilteredTransactionsParams extends Equatable {
  /// [GetFilteredTransactionsParams] constructor.
  const GetFilteredTransactionsParams({
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

  @override
  List<Object?> get props => [
        category,
        type,
        date,
        valueFilter,
      ];

  /// [copyWith] method.
  GetFilteredTransactionsParams copyWith({
    TransactionCategory? category,
    TransactionType? type,
    DateTime? date,
    ValueFilter? valueFilter,
  }) {
    return GetFilteredTransactionsParams(
      category: category ?? this.category,
      type: type ?? this.type,
      date: date ?? this.date,
      valueFilter: valueFilter ?? this.valueFilter,
    );
  }
}
