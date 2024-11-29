import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';

/// [IncomesChart] is a class.
/// That extends [StatelessWidget] and builds the incomes chart.
class IncomesChart extends StatelessWidget {
  /// [IncomesChart] constructor.
  const IncomesChart({
    required this.analysisByCategory,
    super.key,
  });

  /// [analysisByCategory] is the analysis by category.
  final List<AnalysisByCategory> analysisByCategory;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppConstants.commonSize24,
          ),
          child: Column(
            children: [
              Text(
                context.tr.incomeDiagram,
                style: theme.primaryTextTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.appColors.textColors.mainColor,
                ),
              ),
              Text(
                context.tr.forAllTime,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  color: theme.appColors.textColors.secondaryColor,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppConstants.commonSize24,
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.6,
            child: PieChart(
              PieChartData(
                sections: _getSections(
                  context,
                  analysisByCategory: analysisByCategory,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData>? _getSections(
    BuildContext context, {
    required List<AnalysisByCategory> analysisByCategory,
  }) {
    final theme = context.theme;
    const radius = 50.0;

    return analysisByCategory
        .where((category) => category.total > 0)
        .map(
          (category) => PieChartSectionData(
            color: category.category.getColor(context),
            value: category.total,
            title: category.category.getName(context),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: AppConstants.commonSize16,
              fontWeight: FontWeight.bold,
              color: theme.appColors.textColors.mainColor,
            ),
          ),
        )
        .toList();
  }
}
