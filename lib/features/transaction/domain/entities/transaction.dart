import 'package:equatable/equatable.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';

/// [Transaction] is a class.
/// For UI purposes, it is used to represent a transaction.
class Transaction extends Equatable {
  /// [Transaction] constructor.
  const Transaction({
    required this.title,
    required this.value,
    required this.type,
    required this.category,
    this.limit,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  /// [id] is a unique identifier.
  final int? id;

  /// [title] is the title of the transaction.
  final String title;

  /// [value] is the amount of the transaction.
  final double value;

  /// [type] is the type of the transaction.
  final TransactionType type;

  /// [category] is the category of the transaction.
  final TransactionCategory category;

  /// [createdAt] is the date of creation of the transaction.
  final DateTime? createdAt;

  /// [updatedAt] is the date of the last update of the transaction.
  final DateTime? updatedAt;

  /// [limit] is the limit of the transaction.
  final double? limit;

  @override
  List<Object?> get props => [
        id,
        title,
        value,
        type,
        category,
        createdAt,
        updatedAt,
        limit,
      ];

  /// [copyWith] method is used to create a new instance of [Transaction].

  Transaction copyWith({
    int? id,
    String? title,
    double? value,
    TransactionType? type,
    TransactionCategory? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? limit,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      type: type ?? this.type,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      limit: limit ?? this.limit,
    );
  }

  @override
  String toString() =>
      // ignore: lines_longer_than_80_chars
      'Transaction(id: $id, title: $title, value: $value, type: $type, category: $category, createdAt: $createdAt, updatedAt: $updatedAt, limit: $limit)\n';
}
