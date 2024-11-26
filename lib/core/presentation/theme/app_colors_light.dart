import 'package:flutter/material.dart';
import 'package:tracker/core/presentation/theme/colors/base_colors.dart';
import 'package:tracker/core/presentation/theme/colors/main_colors.dart';
import 'package:tracker/core/presentation/theme/colors/other_colors.dart';
import 'package:tracker/core/presentation/theme/colors/text_colors.dart';

/// [AppColorsLight] is a class that extends [BaseColors].
class AppColorsLight extends BaseColors<AppColorsLight> {
  /// [AppColorsLight] constructor.
  const AppColorsLight()
      : super(
          mainColors: const _MainColors(),
          textColors: const _TextColors(),
          otherColors: const _OtherColors(),
        );

  @override
  ThemeExtension<AppColorsLight> copyWith() => const AppColorsLight();

  @override
  ThemeExtension<AppColorsLight> lerp(
    covariant ThemeExtension<AppColorsLight>? other,
    double t,
  ) {
    if (other! is AppColorsLight) return this;
    return const AppColorsLight();
  }
}

class _MainColors extends MainColors {
  const _MainColors()
      : super(
          greenColor: const Color(0xFF81C784),
          redColor: const Color(0xFFE57373),
          blueColor: const Color(0xFF64B5F6),
          blackColor: const Color(0xFF000000),
        );
}

class _TextColors extends TextColors {
  const _TextColors()
      : super(
          mainColor: const Color(0xFF212121),
          secondaryColor: const Color(0xFF757575),
        );
}

class _OtherColors extends OtherColors {
  const _OtherColors()
      : super(
          transparent: const Color(0x00000000),
        );
}
