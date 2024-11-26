import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart'
    as cubit;

/// [MainScreen] is a class.
/// That extends [StatelessWidget] and builds the main screen.

@RoutePage()
class MainScreen extends StatelessWidget {
  /// [MainScreen] constructor.
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (_, state) => switch (state) {
          TransactionInitialState _ => const Center(
              child: Text('No transactions yet.'),
            ),
          TransactionLoadingState _ => const Center(
              child: CircularProgressIndicator(),
            ),
          TransactionLoadedState _ => Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.transactions.length,
                    itemBuilder: (_, index) {
                      final transaction = state.transactions[index];
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        key: UniqueKey(),
                        onDismissed: (_) => context.read<TransactionBloc>().add(
                              DeleteTransactionEvent(transaction.id!),
                            ),
                        background: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.delete,
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        child: ListTile(
                          title: Text(transaction.title),
                          subtitle: Text(transaction.value.toString()),
                          trailing: InkWell(
                            onTap: () => transaction.id != null
                                ? showDialog<TransactionDialog>(
                                    context: context,
                                    builder: (_) => TransactionDialog(
                                      transaction: transaction,
                                      isUpdate: true,
                                    ),
                                  )
                                : null,
                            child: const Icon(Icons.edit),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          TransactionErrorState _ => Center(
              child: Text(state.message),
            ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog<TransactionDialog>(
          context: context,
          builder: (_) => const TransactionDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}

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

class TransactionFormContent extends StatelessWidget {
  const TransactionFormContent({
    required this.formKey,
    required this.transaction,
    required this.type,
    required this.category,
    super.key,
  });

  final GlobalKey<FormBuilderState> formKey;
  final Transaction? transaction;
  final TransactionType type;
  final TransactionCategory category;

  @override
  Widget build(BuildContext context) {
    final titleFocusNode = FocusNode();
    final valueFocusNode = FocusNode();
    final localCubit = context.read<cubit.FormCubit>();
    final dateFormat = DateFormat('yyyy-MM-dd');

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
