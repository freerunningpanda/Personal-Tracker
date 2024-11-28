import 'package:tracker/core/output/result.dart';
import 'package:tracker/features/analysis/domain/entities/analysis_by_category.dart';

/// [AnalysisRepository] is an abstract class.
/// That defines the methods that any analysis repository should implement.
abstract interface class AnalysisRepository {
  /// [getAnalysisByCategory] method.
  /// That returns the analysis by category.
  Future<Result<List<AnalysisByCategory>>> getAnalysisByCategory();
}
