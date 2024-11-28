import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';
import 'package:tracker/features/analysis/domain/usecases/get_analysis_by_category.dart';

part 'analysis_event.dart';
part 'analysis_state.dart';

typedef _Emit = Emitter<AnalysisState>;

/// [AnalysisBloc] class.
/// That manages the analysis state.
class AnalysisBloc extends Bloc<AnalysisEvent, AnalysisState> {
  /// [AnalysisBloc] constructor.
  AnalysisBloc(this._getAnalysisByCategory) : super(const AnalysisInitial()) {
    on<GetAnalysisEvent>(_onGetAnanlysis);

    add(const GetAnalysisEvent());
  }

  final GetAnalysisByCategory _getAnalysisByCategory;

  Future<void> _onGetAnanlysis(
    AnalysisEvent event,
    _Emit emit,
  ) async {
    emit(const AnalysisLoading());

    final result = await _getAnalysisByCategory.call(NoParams());

    result.fold(
      onSuccess: (analysisByCategory) {
        final allZero = analysisByCategory.data?.every(
          (category) => category.total == 0,
        );

        if (allZero ?? true) {
          emit(const AnalysisInitial());
          return;
        }

        emit(
          AnalysisLoaded(analysisByCategory: analysisByCategory.data ?? []),
        );
      },
      onFailure: (message) {
        emit(AnalysisError(message: message.toString()));
      },
    );
  }
}
