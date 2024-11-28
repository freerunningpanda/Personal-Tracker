import 'package:equatable/equatable.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/domain/repositories/transaction_repository.dart';

/// [SearchTransactions] class.
/// This class is a use case that searches for transactions.
class SearchTransactions
    implements UseCase<List<Transaction>, SearchTransactionsParams> {
  /// [SearchTransactions] constructor.
  const SearchTransactions(this._repository);

  final TransactionRepository _repository;

  @override
  Future<Result<List<Transaction>>> call(SearchTransactionsParams params) =>
      _repository.searchTransactions(params);
}

/// [SearchTransactionsParams] class.
/// Contains a [query] parameter.
class SearchTransactionsParams extends Equatable {
  /// [SearchTransactionsParams] constructor.
  const SearchTransactionsParams({required this.query});

  /// [query] is the search query.
  final String query;

  @override
  List<Object?> get props => [query];
}
