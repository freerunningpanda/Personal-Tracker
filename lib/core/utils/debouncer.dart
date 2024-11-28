import 'dart:async';

import 'package:flutter/material.dart';

/// [Debouncer] is a class.
/// Used to debounce the user input.
class Debouncer {
  /// [Debouncer] constructor.
  Debouncer({required this.delay});

  /// [delay] property.
  final Duration delay;
  Timer? _timer;

  /// [run] method.
  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  /// [dispose] method.
  void dispose() {
    _timer?.cancel();
  }
}
