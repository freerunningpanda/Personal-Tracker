import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:tracker/features/analysis/presentation/widgets/analysis_content.dart';

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
        AnalysisLoaded _ => AnalysisContent(
            analysisByCategory: state.analysisByCategory,
          ),
        AnalysisError _ => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(context.tr.errorLoadingAnalysis),
              Text(context.tr.pleaseTryAgainLater),
            ],
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
