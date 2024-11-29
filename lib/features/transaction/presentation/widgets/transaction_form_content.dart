import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
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

  String? _validateValueAndNegative(
    BuildContext context, {
    required String? value,
  }) {
    if (value == null || value.isEmpty) {
      return context.tr.pleaseEnterAValue;
    }
    final numValue = double.tryParse(value);
    if (numValue != null) {
      if (numValue < 0) {
        return context.tr.cannotBeNegative;
      }
    }
    return null;
  }

  String? _validateNegative(
    BuildContext context, {
    required String? value,
  }) {
    final numValue = double.tryParse(value ?? '');
    if (numValue != null) {
      if (numValue < 0) {
        return context.tr.cannotBeNegative;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final titleFocusNode = FocusNode();
    final valueFocusNode = FocusNode();
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
            onChanged: (value) => titleFocusNode.requestFocus(),
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
            onChanged: (value) => valueFocusNode.requestFocus(),
            decoration: InputDecoration(
              labelText: context.tr.value,
              suffixIcon: const Icon(Icons.attach_money),
            ),
            validator: (value) => _validateValueAndNegative(
              context,
              value: value,
            ),
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
          FormBuilderTextField(
            initialValue: transaction?.limit != null
                ? transaction!.limit!.toString()
                : '',
            name: AppConstants.limitField,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: context.tr.limit,
              suffixIcon: const Icon(Icons.warning),
            ),
            validator: (value) => _validateNegative(
              context,
              value: value,
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

/// [TransactionDropdowns] is a class.
/// That extends [StatelessWidget] and builds the transaction dropdowns.
class TransactionDropdowns extends StatelessWidget {
  /// [TransactionDropdowns] constructor.
  const TransactionDropdowns({
    this.transaction,
    super.key,
  });

  /// [TransactionDropdowns] constructor.
  final Transaction? transaction;

  void _onChangedType(BuildContext context, {required TransactionType? type}) {
    final formCubit = context.read<FormCubit>();
    final transactionBloc = context.read<TransactionBloc>();

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
  }

  void _onChangedCategory(
    BuildContext context, {
    required TransactionCategory? category,
  }) {
    final formCubit = context.read<FormCubit>();
    final transactionBloc = context.read<TransactionBloc>();

    if (transaction != null) {
      transactionBloc.add(
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final formCubit = context.read<FormCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.commonSize16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.tr.type,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  color: theme.appColors.textColors.mainColor,
                ),
              ),
              DropdownButton<TransactionType>(
                isExpanded: true,
                value: transaction?.type ?? formCubit.state.type,
                items: TransactionType.values
                    .where((type) => type != TransactionType.all)
                    .map(
                      (type) => DropdownMenuItem(
                        value: type,
                        child: Text(type.getName(context)),
                      ),
                    )
                    .toList(),
                onChanged: (type) => _onChangedType(
                  context,
                  type: type,
                ),
              ),
            ],
          ),
        ),
        Text(
          context.tr.category,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            color: theme.appColors.textColors.mainColor,
          ),
        ),
        DropdownButton<TransactionCategory>(
          isExpanded: true,
          value: transaction?.category ?? formCubit.state.category,
          items: TransactionCategory.values
              .where((category) => category != TransactionCategory.all)
              .toList()
              .map(
                (category) => DropdownMenuItem(
                  value: category,
                  child: Text(category.getName(context)),
                ),
              )
              .toList(),
          onChanged: (category) => _onChangedCategory(
            context,
            category: category,
          ),
        ),
      ],
    );
  }
}
