part of 'analysis_bloc.dart';

/// [AnalysisEvent] is a class.
/// That extends [AnalysisEvent] and represents the analysis event.
abstract class AnalysisState extends Equatable {
  /// [AnalysisState] constructor.
  const AnalysisState();

  @override
  List<Object> get props => [];
}

/// [AnalysisInitial] is a class.
/// That represents the initial state of the [AnalysisBloc].
final class AnalysisInitial extends AnalysisState {
  /// [AnalysisInitial] constructor.
  const AnalysisInitial();
}

/// [AnalysisLoading] is a class.
/// That represents the loading state of the [AnalysisBloc].
final class AnalysisLoading extends AnalysisState {
  /// [AnalysisLoading] constructor.
  const AnalysisLoading();
}

/// [AnalysisLoaded] is a class.
/// That represents the loaded state of the [AnalysisBloc].
final class AnalysisLoaded extends AnalysisState {
  /// [AnalysisLoaded] constructor.
  const AnalysisLoaded({
    required this.analysisByCategory,
  });

  /// [analysisByCategory] is the analysis by category.
  final List<AnalysisByCategory> analysisByCategory;

  @override
  List<Object> get props => [analysisByCategory];
}

/// [AnalysisError] is a class.
/// That represents the error state of the [AnalysisBloc].
final class AnalysisError extends AnalysisState {
  /// [AnalysisError] constructor.
  const AnalysisError({
    required this.message,
  });

  /// [message] is the error message.
  final String message;

  @override
  List<Object> get props => [message];
}
