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
    required this.orangeColor,
    required this.yellowColor,
    required this.purpleColor,
    required this.pinkColor,
  });

  /// [greenColor] getter.
  final Color greenColor;

  /// [blueColor] getter.
  final Color blueColor;

  /// [redColor] getter.
  final Color redColor;

  /// [blackColor] getter.
  final Color blackColor;

  /// [orangeColor] getter.
  final Color orangeColor;

  /// [yellowColor] getter.
  final Color yellowColor;

  /// [purpleColor] getter.
  final Color purpleColor;

  /// [pinkColor] getter.
  final Color pinkColor;
}
