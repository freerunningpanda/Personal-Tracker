import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/transaction_dialog.dart';

/// [TransactionsView] is a class.
/// That extends [StatelessWidget] and builds the transactions view.
class TransactionsView extends StatelessWidget {
  /// [TransactionsView] constructor.
  const TransactionsView({
    required this.transactions,
    super.key,
  });

  /// [transactions] is the list of transactions.
  final List<Transaction> transactions;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ListView.builder(
      itemCount: transactions.length,
      itemBuilder: (_, index) {
        final transaction = transactions[index];
        final date = transaction.updatedAt ?? transaction.createdAt;

        final dateFormat = DateTimeHelper.dateFormat;

        return Dismissible(
          direction: DismissDirection.endToStart,
          key: UniqueKey(),
          onDismissed: (_) => context.read<TransactionBloc>().add(
                DeleteTransactionEvent(
                  transaction.id!,
                ),
              ),
          background: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.delete,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
          child: Card(
            color: transaction.type.getColor(context),
            child: ListTile(
              leading: Icon(
                transaction.category.getIcon(),
              ),
              title: Text(
                transaction.title,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.appColors.textColors.mainColor,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${transaction.value} \$'),
                  Text(
                    dateFormat.format(
                      date ?? DateTime.now(),
                    ),
                  ),
                ],
              ),
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
          ),
        );
      },
    );
  }
}