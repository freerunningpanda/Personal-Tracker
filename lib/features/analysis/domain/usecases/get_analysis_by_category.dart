import 'package:tracker/core/output/result.dart';
import 'package:tracker/core/usecase/usecase.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';
import 'package:tracker/features/analysis/domain/repositories/analysis_repository.dart';

/// [GetAnalysisByCategory] class is a class that gets the analysis by category.
class GetAnalysisByCategory
    implements UseCase<List<AnalysisByCategory>, NoParams> {
  /// [GetAnalysisByCategory] constructor.
  const GetAnalysisByCategory(this._repository);

  final AnalysisRepository _repository;

  @override
  Future<Result<List<AnalysisByCategory>>> call(NoParams params) =>
      _repository.getAnalysisByCategory();
}
