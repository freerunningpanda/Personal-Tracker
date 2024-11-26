import 'dart:ui';

/// [MainColors] is an abstract class.
/// Contains the main colors of the app.
abstract class MainColors {
  /// [MainColors] constructor.
  const MainColors({
    required this.greenColor,
    required this.blueColor,
    required this.redColor,
    required this.blackColor,
  });

  /// [greenColor] getter.
  final Color greenColor;

  /// [blueColor] getter.
  final Color blueColor;

  /// [redColor] getter.
  final Color redColor;

  /// [blackColor] getter.
  final Color blackColor;
}
