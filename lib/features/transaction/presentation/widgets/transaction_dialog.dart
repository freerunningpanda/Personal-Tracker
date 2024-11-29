part of '../utils/core.dart';

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
              TextButton(
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
            ],
          ),
        ),
      ),
    );
  }
}
