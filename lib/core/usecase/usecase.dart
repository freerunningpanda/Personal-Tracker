import 'package:equatable/equatable.dart';
import 'package:tracker/core/output/result.dart';

/// [UseCase] is an interface that defines the use case.
abstract interface class UseCase<Type, Params> {
  /// [call] function is used to call the use case.
  Future<Result<Type>> call(Params params);
}

/// [NoParams] class is a class that holds no parameters.
class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}
