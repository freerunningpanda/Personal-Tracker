import 'package:tracker/core/database/app_database.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';

/// [TransactionModel] is a class.
/// It is used as a data layer model.
class TransactionModel extends Transaction {
  /// [TransactionModel] constructor.
  const TransactionModel({
    required super.id,
    required super.title,
    required super.value,
    required super.type,
    required super.category,
    super.createdAt,
    super.updatedAt,
  });

  /// [TransactionModel.fromDriftEntity] is a factory constructor.
  /// It is used to create a [TransactionModel].
  /// Instance from a [TransactionDriftEntityData] instance.
  factory TransactionModel.fromDriftEntity(TransactionDriftEntityData entity) =>
      TransactionModel(
        id: entity.id,
        title: entity.title,
        value: entity.value,
        type: entity.type,
        category: entity.category,
        createdAt: entity.createdAt,
        updatedAt: entity.updatedAt,
      );

  /// [TransactionModel.fromUIEntity] is a factory constructor.
  /// It is used to create a [TransactionModel].
  factory TransactionModel.fromUIEntity(Transaction transaction) =>
      TransactionModel(
        id: transaction.id,
        title: transaction.title,
        value: transaction.value,
        type: transaction.type,
        category: transaction.category,
        createdAt: transaction.createdAt,
        updatedAt: transaction.updatedAt,
      );
}
