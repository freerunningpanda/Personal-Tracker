import 'package:flutter/material.dart';

/// [BuildContextExt] is an extension class.
extension BuildContextExt on BuildContext {
  /// [theme] getter.
  ThemeData get theme => Theme.of(this);

  // S get tr => S.of(this);
}
