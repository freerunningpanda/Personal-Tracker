import 'package:tracker/core/data/datasources/local/local_datasource.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/output/result.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';
import 'package:tracker/features/analysis/domain/repositories/analysis_repository.dart';

/// [AnalysisRepositoryImpl] is a class.
/// That implements [AnalysisRepository] interface.
class AnalysisRepositoryImpl implements AnalysisRepository {
  /// [AnalysisRepositoryImpl] constructor.
  AnalysisRepositoryImpl(this._localDatasource);

  /// [LocalDatasource] instance.
  final LocalDatasource _localDatasource;

  @override
  Future<Result<List<AnalysisByCategory>>> getAnalysisByCategory() async {
    try {
      final transactions = await _localDatasource.getTransactions();

      // Filter transactions by type.
      final expenses =
          transactions.where((t) => t.type == TransactionType.expense).toList();
      final incomes =
          transactions.where((t) => t.type == TransactionType.income).toList();

      // Group transactions by category.
      // Calculate the sum for each category.
      final expenseTotals = <TransactionCategory, double>{};
      for (final expense in expenses) {
        final category = expense.category;
        final value = expense.value;

        if (expenseTotals.containsKey(category)) {
          expenseTotals[category] = (expenseTotals[category] ?? 0) + value;
        } else {
          expenseTotals[category] = value;
        }
      }

      final incomeTotals = <TransactionCategory, double>{};
      for (final income in incomes) {
        final category = income.category;
        final value = income.value;

        if (incomeTotals.containsKey(category)) {
          incomeTotals[category] = (incomeTotals[category] ?? 0) + value;
        } else {
          incomeTotals[category] = value;
        }
      }

      final analysis = TransactionCategory.values
          .where((category) => category != TransactionCategory.all);
      // Forming an analysis list by categories except for the 'all' category.
      final formedAnalysis = analysis.map((category) {
        final income = incomeTotals[category] ?? 0;
        final expense = expenseTotals[category] ?? 0;

        return AnalysisByCategory(
          category: category,
          income: income,
          expense: expense,
          total: income - expense,
        );
      }).toList();

      return Success(data: formedAnalysis);
    } catch (e) {
      return Failure(e.toString());
    }
  }
}
