import 'package:flutter/material.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';
import 'package:tracker/features/analysis/presentation/widgets/incomes_chart.dart';

/// [AnalysisContent] is a class.
/// That extends [StatelessWidget] and builds the analysis content.
class AnalysisContent extends StatelessWidget {
  /// [AnalysisContent] constructor.
  const AnalysisContent({
    required this.analysisByCategory,
    super.key,
  });

  /// [analysisByCategory] is the analysis by category.
  final List<AnalysisByCategory> analysisByCategory;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    final negativeTotal = analysisByCategory.every((category) {
      return category.total <= 0;
    });

    return SingleChildScrollView(
      child: Column(
        children: [
          if (!negativeTotal)
            IncomesChart(analysisByCategory: analysisByCategory),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.commonSize24,
            ),
            child: Text(
              context.tr.incomesAndExpensesByCategories,
              textAlign: TextAlign.center,
              style: theme.primaryTextTheme.headlineSmall?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
          ),
          Column(
            children: analysisByCategory.map(
              (category) {
                if (category.total == 0) {
                  return const SizedBox.shrink();
                }

                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: category.category.getColor(context),
                    radius: AppConstants.commonSize20,
                    child: Icon(
                      category.category.getIcon(),
                      color:
                          theme.appColors.textColors.mainColor.withOpacity(0.8),
                    ),
                  ),
                  title: Text(
                    category.category.getName(context),
                  ),
                  trailing: Text(
                    '${category.total}',
                    style: theme.primaryTextTheme.bodyMedium?.copyWith(
                      color: category.total < 0
                          ? theme.appColors.mainColors.redColor
                          : theme.appColors.mainColors.greenColor,
                    ),
                  ),
                );
              },
            ).toList(),
          ),
          const SizedBox(
            height: AppConstants.commonSize24,
          ),
        ],
      ),
    );
  }
}
