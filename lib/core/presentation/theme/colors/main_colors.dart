import 'dart:ui';

/// [MainColors] is an abstract class.
/// Contains the main colors of the app.
abstract class MainColors {
  /// [MainColors] constructor.
  const MainColors({
    required this.greenColor,
    required this.redColor,
  });

  /// [greenColor] getter.
  final Color greenColor;

  /// [redColor] getter.
  final Color redColor;
}
