import 'package:drift/drift.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';

/// [TransactionDriftEntity] is a class.
class TransactionDriftEntity extends Table {
  /// [id] is a unique identifier.
  IntColumn get id => integer().autoIncrement()();

  /// [title] is the title of the transaction.
  TextColumn get title => text()();

  /// [value] is the amount of the transaction.
  RealColumn get value => real()();

  /// [type] is the type of the transaction.
  TextColumn get type => textEnum<TransactionType>()();

  /// [category] is the category of the transaction.
  TextColumn get category => textEnum<TransactionCategory>()();

  /// [createdAt] is the date of creation of the transaction.
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// [updatedAt] is the date of the last update of the transaction.
  DateTimeColumn get updatedAt => dateTime().nullable()();

  /// [limit] is the limit of the transaction.
  RealColumn get limit => real().nullable()();
}
