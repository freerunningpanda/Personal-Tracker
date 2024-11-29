import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart'
    as cubit;
import 'package:tracker/features/transaction/presentation/widgets/transaction_form_content.dart';

/// [TransactionDialog] is a class.
/// That extends [StatelessWidget] and builds the transaction dialog.
class TransactionDialog extends StatelessWidget {
  /// [TransactionDialog] constructor.
  const TransactionDialog({
    this.transaction,
    super.key,
  });

  /// [transaction] is the transaction for update.
  final Transaction? transaction;

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

    final createdAt =
        formKey.currentState?.value[AppConstants.dateTimeField] as DateTime?;

    final parsedValue = double.tryParse(value ?? '');

    context
      ..read<TransactionsBloc>().add(
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

    context.read<cubit.FormCubit>().validateForm(
          isFormValid: false,
        );

    context.read<AnalysisBloc>().add(const GetAnalysisEvent());
  }

  void _updateTransaction(
    BuildContext context, {
    required GlobalKey<FormBuilderState> formKey,
    Transaction? transaction,
  }) {
    formKey.currentState?.saveAndValidate();

    final title =
        formKey.currentState?.value[AppConstants.titleField] as String?;
    final value =
        formKey.currentState?.value[AppConstants.valueField] as String?;

    final updatedAt =
        formKey.currentState?.value[AppConstants.dateTimeField] as DateTime?;

    final parsedValue = double.tryParse(value ?? '');

    if (transaction == null) {
      return;
    }

    context
      ..read<TransactionBloc>().add(
        UpdateTransactionEvent(
          transaction: transaction.copyWith(
            title: title,
            value: parsedValue ?? 0.0,
            type: transaction.type,
            category: transaction.category,
            updatedAt: updatedAt,
          ),
        ),
      )
      ..maybePop();

    context.read<cubit.FormCubit>().validateForm(
          isFormValid: false,
        );

    context.read<AnalysisBloc>().add(const GetAnalysisEvent());
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final theme = context.theme;

    return FormBuilder(
      key: formKey,
      child: BlocBuilder<cubit.FormCubit, cubit.FormState>(
        builder: (_, state) => BlocBuilder<TransactionBloc, TransactionState>(
          builder: (_, transactionState) => AlertDialog(
            title: Text(
              transaction != null
                  ? context.tr.updateATransaction
                  : context.tr.createATransaction,
              style: theme.primaryTextTheme.headlineMedium?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
            content: TransactionFormContent(
              formKey: formKey,
              transaction: transactionState.transaction ?? transaction,
            ),
            actions: [
              TextButton(
                onPressed: () => context.maybePop(),
                child: Text(
                  MaterialLocalizations.of(context).cancelButtonLabel,
                  style: theme.primaryTextTheme.bodyMedium?.copyWith(
                    color: theme.appColors.textColors.mainColor,
                  ),
                ),
              ),
              Visibility(
                visible: state.isFormValid,
                replacement: TextButton(
                  onPressed: null,
                  child: Text(
                    transaction != null ? context.tr.update : context.tr.create,
                    style: theme.primaryTextTheme.bodyMedium?.copyWith(
                      color:
                          theme.appColors.textColors.mainColor.withOpacity(0.4),
                    ),
                  ),
                ),
                child: TextButton(
                  onPressed: () => transaction != null
                      ? _updateTransaction(
                          context,
                          formKey: formKey,
                          transaction:
                              transactionState.transaction ?? transaction,
                        )
                      : _createTransaction(
                          context,
                          formKey: formKey,
                          category: state.category,
                          type: state.type,
                        ),
                  child: Text(
                    transaction != null ? context.tr.update : context.tr.create,
                    style: theme.primaryTextTheme.bodyMedium?.copyWith(
                      color: theme.appColors.textColors.mainColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
