part of 'analysis_bloc.dart';

/// [AnalysisEvent] is a class.
/// That extends [AnalysisEvent] and represents the analysis event.
sealed class AnalysisEvent {
  const AnalysisEvent();
}

/// [GetAnalysisEvent] is a class.
/// That represents the event to get the analysis.
final class GetAnalysisEvent extends AnalysisEvent {
  /// [GetAnalysisEvent] constructor.
  const GetAnalysisEvent();
}
