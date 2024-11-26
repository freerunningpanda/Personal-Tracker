import 'dart:ui';

/// [TextColors] is an abstract class.
/// Contains the text colors of the app.
abstract class TextColors {
  /// [TextColors] constructor.
  const TextColors({
    required this.mainColor,
    required this.secondaryColor,
  });

  /// [mainColor] getter.
  final Color mainColor;

  /// [secondaryColor] getter.
  final Color secondaryColor;
}
