import 'package:flutter/material.dart';
import 'package:tracker/generated/l10n.dart';

/// [BuildContextExt] is an extension class.
extension BuildContextExt on BuildContext {
  /// [theme] getter.
  ThemeData get theme => Theme.of(this);

  /// [tr] getter.
  /// It returns the [S] instance.
  /// It is used to get the translations.
  S get tr => S.of(this);
}
