import 'dart:async';

/// [Result] is a sealed class that represents the result of an operation.
sealed class Result<T> {
  /// [fold] method is used to handle the result of an operation.
  FutureOr<void> fold({
    required FutureOr<void> Function(Success<T> result) onSuccess,
    required FutureOr<void> Function(Failure<T> failure) onFailure,
  }) async =>
      switch (this) {
        final Success<T> success => await onSuccess(success),
        final Failure<T> failure => await onFailure(failure),
      };
}

/// [Success] class is a subclass of [Result] class.
final class Success<T> extends Result<T> {
  /// [Success] constructor
  Success({this.data});

  /// [data] is the data of type [T].
  final T? data;
}

/// [Failure] class is a subclass of [Result] class.
final class Failure<T> extends Result<T> {
  /// [Failure] constructor
  Failure(this.message);

  /// [message] is the error message.
  final String message;
}
