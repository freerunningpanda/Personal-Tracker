import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart';

/// [TransactionFormContent] is a class.
/// That extends [StatelessWidget] and builds the transaction form content.
class TransactionFormContent extends StatelessWidget {
  /// [TransactionFormContent] constructor.
  const TransactionFormContent({
    required this.formKey,
    this.transaction,
    super.key,
  });

  /// [formKey] is the form key.
  final GlobalKey<FormBuilderState> formKey;

  /// [transaction] is the transaction for update.
  final Transaction? transaction;

  @override
  Widget build(BuildContext context) {
    final titleFocusNode = FocusNode();
    final valueFocusNode = FocusNode();
    final localCubit = context.read<FormCubit>();
    final dateFormat = DateTimeHelper.dateFormat;
    final now = DateTime.now();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
            initialValue: transaction?.title,
            focusNode: titleFocusNode,
            name: AppConstants.titleField,
            decoration: InputDecoration(
              labelText: context.tr.title,
              suffixIcon: const Icon(Icons.title),
            ),
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              localCubit.validateForm(
                isFormValid: formKey.currentState?.validate() ?? false,
              );
              titleFocusNode.requestFocus();
            },
            onSubmitted: (_) => valueFocusNode.requestFocus(),
            validator: (value) => value == null || value.isEmpty
                ? context.tr.pleaseEnterATitle
                : null,
          ),
          FormBuilderTextField(
            initialValue: transaction?.value.toString(),
            name: AppConstants.valueField,
            keyboardType: TextInputType.number,
            focusNode: valueFocusNode,
            onChanged: (value) {
              localCubit.validateForm(
                isFormValid: formKey.currentState?.validate() ?? false,
              );
              valueFocusNode.requestFocus();
            },
            decoration: InputDecoration(
              labelText: context.tr.value,
              suffixIcon: const Icon(Icons.attach_money),
            ),
            validator: (value) => value == null || value.isEmpty
                ? context.tr.pleaseEnterAValue
                : null,
          ),
          FormBuilderDateTimePicker(
            name: AppConstants.dateTimeField,
            initialValue:
                transaction?.updatedAt ?? dateFormat.tryParse(now.toString()),
            inputType: InputType.date,
            format: dateFormat,
            decoration: InputDecoration(
              labelText: context.tr.date,
              suffixIcon: const Icon(Icons.calendar_today),
            ),
          ),
          TransactionDropdowns(
            transaction: transaction,
          ),
        ],
      ),
    );
  }
}

class TransactionDropdowns extends StatelessWidget {
  final Transaction? transaction;
  const TransactionDropdowns({
    this.transaction,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final formCubit = context.read<FormCubit>();
    final transactionBloc = context.read<TransactionBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: AppConstants.commonSize16),
          child: DropdownButton<TransactionType>(
            value: transaction?.type ?? formCubit.state.type,
            items: TransactionType.values
                .where((type) => type != TransactionType.all)
                .map(
                  (type) => DropdownMenuItem(
                    value: type,
                    child: Text(type.toString().split('.').last),
                  ),
                )
                .toList(),
            onChanged: (type) {
              if (transaction != null) {
                transactionBloc.add(
                  EditTransactionEvent(
                    transaction: transaction!.copyWith(type: type),
                  ),
                );

                return;
              }
              formCubit.setType(
                type: type,
              );

              log('Type: $type');
            },
          ),
        ),
        DropdownButton<TransactionCategory>(
          value: transaction?.category ?? formCubit.state.category,
          items: TransactionCategory.values
              .where((category) => category != TransactionCategory.all)
              .toList()
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.toString().split('.').last),
                ),
              )
              .toList(),
          onChanged: (category) {
            if (transaction != null) {
              context.read<TransactionBloc>().add(
                    EditTransactionEvent(
                      transaction: transaction!.copyWith(
                        category: category,
                      ),
                    ),
                  );

              return;
            }
            formCubit.setCategory(
              category: category,
            );
            log('Category: $category');
          },
        ),
      ],
    );
  }
}
