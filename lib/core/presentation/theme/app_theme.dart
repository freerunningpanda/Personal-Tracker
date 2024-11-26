import 'package:flutter/material.dart';
import 'package:tracker/core/core.dart';
import 'package:tracker/core/presentation/theme/app_colors_light.dart';

/// [AppTheme] is a class.
/// That contains the app theme.
class AppTheme {
  /// [AppTheme] constructor.
  AppTheme(this._appColorsLight);

  final AppColorsLight _appColorsLight;

  static final _lightThemeColors = sl<AppColorsLight>();

  /// [lightTheme] getter.
  ThemeData get lightTheme => ThemeData.light().copyWith(
        extensions: <ThemeExtension>[
          _appColorsLight,
        ],
      );
}

/// [AppColorsExtension] is an extension class.
extension AppColorsExtension on ThemeData {
  /// [appColors] getter.
  AppColorsLight get appColors => AppTheme._lightThemeColors;
}
