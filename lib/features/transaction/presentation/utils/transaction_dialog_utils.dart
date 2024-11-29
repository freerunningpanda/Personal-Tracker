part of 'core.dart';

/// shows a message if the limit is exceeded
void _showLimitMessage(
  BuildContext context, {
  required double parsedLimit,
  required double parsedValue,
  required TransactionCategory category,
  required TransactionType type,
}) {
  if (type != TransactionType.expense) {
    return;
  }
  if (parsedLimit < parsedValue) {
    AppSnackbar.show(
      context,
      title: context.tr.attention,
      message: context.tr.exceededTheLimit(
        category.getName(context),
      ),
    );
  }
}

/// creates a transaction
void _createTransaction(
  BuildContext context, {
  required GlobalKey<FormBuilderState> formKey,
  required TransactionCategory category,
  required TransactionType type,
}) {
  final isValid = formKey.currentState?.saveAndValidate();

  if (!isValid!) {
    return;
  }
  final title = formKey.currentState?.value[AppConstants.titleField] as String?;
  final value = formKey.currentState?.value[AppConstants.valueField] as String?;

  final createdAt =
      formKey.currentState?.value[AppConstants.dateTimeField] as DateTime?;

  final parsedValue = double.tryParse(value ?? '');

  final limit = formKey.currentState?.value[AppConstants.limitField] as String?;

  final parsedLimit = double.tryParse(limit ?? '');

  context
    ..read<TransactionsBloc>().add(
      CreateTransactionEvent(
        Transaction(
          title: title ?? '',
          value: parsedValue ?? 0.0,
          category: category,
          type: type,
          createdAt: createdAt,
          limit: parsedLimit,
        ),
      ),
    )
    ..maybePop();

  context.read<AnalysisBloc>().add(const GetAnalysisEvent());

  _showLimitMessage(
    context,
    parsedLimit: parsedLimit ?? 0.0,
    parsedValue: parsedValue ?? 0.0,
    category: category,
    type: type,
  );
}

/// updates a transaction
void _updateTransaction(
  BuildContext context, {
  required GlobalKey<FormBuilderState> formKey,
  Transaction? transaction,
}) {
  final isValid = formKey.currentState?.saveAndValidate();

  if (!isValid!) {
    return;
  }

  final title = formKey.currentState?.value[AppConstants.titleField] as String?;
  final value = formKey.currentState?.value[AppConstants.valueField] as String?;

  final updatedAt =
      formKey.currentState?.value[AppConstants.dateTimeField] as DateTime?;

  final parsedValue = double.tryParse(value ?? '');

  final limit = formKey.currentState?.value[AppConstants.limitField] as String?;

  final parsedLimit = double.tryParse(limit ?? '');

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
          limit: parsedLimit,
        ),
      ),
    )
    ..maybePop();

  context.read<AnalysisBloc>().add(const GetAnalysisEvent());

  _showLimitMessage(
    context,
    parsedLimit: parsedLimit ?? 0.0,
    parsedValue: parsedValue ?? 0.0,
    category: transaction.category,
    type: transaction.type,
  );
}
