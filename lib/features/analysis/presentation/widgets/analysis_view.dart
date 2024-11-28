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
                SizedBox(
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

    return analysisByCategory
        .map(
          (category) => PieChartSectionData(
            color: category.category.getColor(context),
            value: category.total,
            title: '${category.total}\$',
            radius: 50.0,
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
