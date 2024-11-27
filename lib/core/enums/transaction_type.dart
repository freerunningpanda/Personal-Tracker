import 'package:flutter/material.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';

/// [TransactionType] is an enum class.
/// Contains two values: [income] and [expense].
enum TransactionType {
  /// [all] types.
  all,

  /// [expense] type.
  expense,

  /// [income] type.
  income;

  /// [getColor] method.
  /// Returns the color of the transaction type.
  Color? getColor(BuildContext context) {
    final color = context.theme.appColors.mainColors;

    return switch (this) {
      expense => color.redColor,
      income => color.greenColor,
      _ => null,
    };
  }
}
