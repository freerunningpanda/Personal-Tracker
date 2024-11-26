import 'package:flutter/material.dart';
import 'package:tracker/core/presentation/theme/colors/main_colors.dart';
import 'package:tracker/core/presentation/theme/colors/other_colors.dart';
import 'package:tracker/core/presentation/theme/colors/text_colors.dart';

/// [BaseColors] is an abstract class.
/// Contains the main colors of the application.
abstract class BaseColors<T extends BaseColors<T>> extends ThemeExtension<T> {
  /// [BaseColors] constructor.
  const BaseColors({
    required this.mainColors,
    required this.textColors,
    required this.otherColors,
  });

  /// [mainColors] getter.
  final MainColors mainColors;

  /// [textColors] getter.
  final TextColors textColors;

  /// [otherColors] getter.
  final OtherColors otherColors;
}
