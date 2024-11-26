import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart'
    as cubit;
import 'package:tracker/features/transaction/presentation/widgets/transaction_form_content.dart';

/// [TransactionDialog] is a class.
/// That extends [StatelessWidget] and builds the transaction dialog.
class TransactionDialog extends StatelessWidget {
  /// [TransactionDialog] constructor.
  const TransactionDialog({
    this.transaction,
    this.isUpdate = false,
    super.key,
  });

  /// [transaction] is the transaction for update.
  final Transaction? transaction;

  /// [isUpdate] is a flag to determine if the transaction is to be updated.
  final bool isUpdate;

  void _createTransaction(
    BuildContext context, {
    required GlobalKey<FormBuilderState> formKey,
    required TransactionCategory category,
    required TransactionType type,
  }) {
    formKey.currentState?.saveAndValidate();

    final title =
        formKey.currentState?.value[AppConstants.titleField] as String?;
    final value =
        formKey.currentState?.value[AppConstants.valueField] as String?;

    final createdAt = formKey.currentState?.value['dateTime'] as DateTime?;

    final parsedValue = double.tryParse(value ?? '');

    context
      ..read<TransactionBloc>().add(
        CreateTransactionEvent(
          Transaction(
            title: title ?? '',
            value: parsedValue ?? 0.0,
            category: category,
            type: type,
            createdAt: createdAt,
          ),
        ),
      )
      ..maybePop();
  }

  void _updateTransaction(
    BuildContext context, {
    required GlobalKey<FormBuilderState> formKey,
    Transaction? transaction,
    TransactionCategory? category,
    TransactionType? type,
  }) {
    formKey.currentState?.saveAndValidate();

    final title =
        formKey.currentState?.value[AppConstants.titleField] as String?;
    final value =
        formKey.currentState?.value[AppConstants.valueField] as String?;

    final updatedAt = formKey.currentState?.value['dateTime'] as DateTime?;

    final parsedValue = double.tryParse(value ?? '');

    if (transaction == null) {
      return;
    }

    context
      ..read<TransactionBloc>().add(
        UpdateTransactionEvent(
          transaction.copyWith(
            title: title,
            value: parsedValue ?? 0.0,
            type: type,
            category: category,
            updatedAt: updatedAt,
          ),
        ),
      )
      ..maybePop();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: formKey,
      child: BlocBuilder<cubit.FormCubit, cubit.FormState>(
        builder: (_, state) => AlertDialog(
          title: Text(
            transaction != null
                ? 'Update a transaction'
                : 'Create a transaction',
          ),
          content: TransactionFormContent(
            formKey: formKey,
            transaction: transaction,
            type: state.type,
            category: state.category,
          ),
          actions: [
            TextButton(
              onPressed: () => context.maybePop(),
              child: const Text('Cancel'),
            ),
            Visibility(
              visible: state.isFormValid,
              replacement: TextButton(
                onPressed: null,
                child: Text(
                  !isUpdate ? 'Create' : 'Update',
                ),
              ),
              child: TextButton(
                onPressed: () => !isUpdate
                    ? _createTransaction(
                        context,
                        formKey: formKey,
                        category: state.category,
                        type: state.type,
                      )
                    : _updateTransaction(
                        context,
                        formKey: formKey,
                        transaction: transaction,
                        category: state.category,
                        type: state.type,
                      ),
                child: Text(!isUpdate ? 'Create' : 'Update'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
