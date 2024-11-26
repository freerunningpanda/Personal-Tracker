import 'package:flutter/material.dart';

/// [TransactionCategory] is an enum class.
/// Contains all the categories of transactions.
enum TransactionCategory {
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
  IconData getIcon() => switch (this) {
        food => Icons.fastfood,
        travelling => Icons.flight,
        transport => Icons.directions_bus,
        shopping => Icons.shopping_cart,
        health => Icons.local_hospital,
        entertainment => Icons.movie,
        education => Icons.school,
        other => Icons.category,
      };
}
