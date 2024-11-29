import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';

/// [AnalysisView] is a class.
/// That extends [StatelessWidget] and builds the analysis view.
class AnalysisView extends StatelessWidget {
  /// [AnalysisView] constructor.
  const AnalysisView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    return BlocBuilder<AnalysisBloc, AnalysisState>(
      builder: (_, state) => switch (state) {
        AnalysisInitial _ => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.tr.analysisIsEmpty,
                style: TextStyle(
                  color: theme.appColors.textColors.secondaryColor,
                ),
              ),
              Text(
                context.tr.pleaseAddSomeTransactions,
                style: TextStyle(
                  color: theme.appColors.textColors.secondaryColor,
                ),
              ),
            ],
          ),
        AnalysisLoading _ => const Center(
            child: CircularProgressIndicator(),
          ),
        AnalysisLoaded _ => SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.commonSize24,
                  ),
                  child: Text(
                    context.tr.incomeDiagram,
                    style: theme.primaryTextTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.appColors.textColors.mainColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppConstants.commonSize24,
                  ),
                  child: SizedBox(
                    height: 300,
                    child: PieChart(
                      PieChartData(
                        sections: _getSections(
                          context,
                          analysisByCategory: state.analysisByCategory,
                        ),
                      ),
                    ),
                  ),
                ),
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
                  children: state.analysisByCategory.map(
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
                            color: theme.appColors.textColors.mainColor
                                .withOpacity(0.8),
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
          ),
        AnalysisError _ => const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error loading analysis'),
              Text('Please try again later'),
            ],
          ),
        _ => const SizedBox.shrink(),
      },
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
