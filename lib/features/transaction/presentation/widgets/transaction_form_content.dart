import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart';

/// [TransactionFormContent] is a class.
/// That extends [StatelessWidget] and builds the transaction form content.
class TransactionFormContent extends StatelessWidget {
  /// [TransactionFormContent] constructor.
  const TransactionFormContent({
    required this.formKey,
    required this.transaction,
    required this.type,
    required this.category,
    super.key,
  });

  /// [formKey] is the form key.
  final GlobalKey<FormBuilderState> formKey;

  /// [transaction] is the transaction for update.
  final Transaction? transaction;

  /// [type] is the transaction type from state.
  final TransactionType type;

  /// [category] is the transaction category from state.
  final TransactionCategory category;

  @override
  Widget build(BuildContext context) {
    final titleFocusNode = FocusNode();
    final valueFocusNode = FocusNode();
    final localCubit = context.read<FormCubit>();
    final dateFormat = DateTimeHelper.dateFormat;
    final now = DateTime.now();

    return Column(
      children: [
        FormBuilderTextField(
          initialValue: transaction?.title,
          focusNode: titleFocusNode,
          name: AppConstants.titleField,
          decoration: const InputDecoration(labelText: 'Title'),
          textInputAction: TextInputAction.next,
          onChanged: (value) {
            localCubit.checkFormStatus(
              isFormValid: formKey.currentState?.validate() ?? false,
            );
            titleFocusNode.requestFocus();
          },
          onSubmitted: (_) => valueFocusNode.requestFocus(),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter a title' : null,
        ),
        FormBuilderTextField(
          initialValue: transaction?.value.toString(),
          name: AppConstants.valueField,
          keyboardType: TextInputType.number,
          focusNode: valueFocusNode,
          onChanged: (value) {
            localCubit.checkFormStatus(
              isFormValid: formKey.currentState?.validate() ?? false,
            );
            valueFocusNode.requestFocus();
          },
          decoration: const InputDecoration(labelText: 'Value'),
          validator: (value) =>
              value == null || value.isEmpty ? 'Please enter a value' : null,
        ),
        FormBuilderDateTimePicker(
          name: 'dateTime',
          initialValue:
              transaction?.updatedAt ?? dateFormat.tryParse(now.toString()),
          inputType: InputType.date,
          format: dateFormat,
          decoration: const InputDecoration(labelText: 'Date'),
        ),
        DropdownButton<TransactionType>(
          value: type,
          items: TransactionType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: (type) => localCubit.setType(
            type: type,
          ),
        ),
        DropdownButton<TransactionCategory>(
          value: category,
          items: TransactionCategory.values
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: (category) => localCubit.setCategory(
            category: category,
          ),
        ),
      ],
    );
  }
}
