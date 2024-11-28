import 'package:equatable/equatable.dart';
import 'package:tracker/core/enums/transaction_category.dart';

/// [AnalysisByCategory] is a class.
/// That extends [Equatable] and represents the analysis by category.
class AnalysisByCategory extends Equatable {
  /// [AnalysisByCategory] constructor.
  const AnalysisByCategory({
    required this.category,
    required this.income,
    required this.expense,
    required this.total,
  });

  /// [category] is the transaction category.
  final TransactionCategory category;

  /// [income] is the total income.
  final double income;

  /// [expense] is the total expense.
  final double expense;

  /// [total] is the total amount.
  final double total;

  @override
  List<Object?> get props => [
        category,
        income,
        expense,
        total,
      ];
}
