import 'package:flutter/material.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';

/// [TransactionCategory] is an enum class.
/// Contains all the categories of transactions.
enum TransactionCategory {
  /// [all] categories.
  all,

  /// [food] category.
  food,

  /// [travelling] category.
  travelling,

  /// [transport] category.
  transport,

  /// [shopping] category.
  shopping,

  /// [health] category.
  health,

  /// [entertainment] category.
  entertainment,

  /// [education] category.
  education,

  /// [other] category.
  other;

  /// [getIcon] method.
  /// Returns the icon data for the category.
  IconData? getIcon() => switch (this) {
        food => Icons.fastfood,
        travelling => Icons.flight,
        transport => Icons.directions_bus,
        shopping => Icons.shopping_cart,
        health => Icons.local_hospital,
        entertainment => Icons.movie,
        education => Icons.school,
        other => Icons.category,
        _ => null,
      };

  /// [getColor] method.
  /// Returns the color of the category.
  Color? getColor(BuildContext context) {
    // final color = context.theme.appColors.mainColors;

    return switch (this) {
      food => Colors.orange,
      travelling => Colors.blue,
      transport => Colors.purple,
      shopping => Colors.green,
      health => Colors.red,
      entertainment => Colors.yellow,
      education => Colors.pink,
      _ => null,
    };
  }

  /// [getName] method.
  /// Returns the name of the category.
  String getName(BuildContext context) => switch (this) {
        food => context.tr.food,
        travelling => context.tr.travelling,
        transport => context.tr.transport,
        shopping => context.tr.shopping,
        health => context.tr.health,
        entertainment => context.tr.entertainment,
        education => context.tr.education,
        other => context.tr.other,
        _ => context.tr.all,
      };
}
