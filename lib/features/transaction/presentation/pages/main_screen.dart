import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/transaction_dialog.dart';

/// [MainScreen] is a class.
/// That extends [StatelessWidget] and builds the main screen.

@RoutePage()
class MainScreen extends StatelessWidget {
  /// [MainScreen] constructor.
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (_, state) => switch (state) {
          TransactionInitialState _ => Center(
              child: Text(
                'No transactions yet',
                style: TextStyle(
                  color: theme.appColors.textColors.secondaryColor,
                ),
              ),
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
                      final date =
                          transaction.updatedAt ?? transaction.createdAt;

                      final dateFormat = DateTimeHelper.dateFormat;

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
                        child: Card(
                          color: transaction.type.getColor(context),
                          child: ListTile(
                            leading: Icon(transaction.category.getIcon()),
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
                                Text(dateFormat.format(date ?? DateTime.now())),
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
        backgroundColor: theme.appColors.mainColors.greenColor,
        onPressed: () => showDialog<TransactionDialog>(
          context: context,
          builder: (_) => const TransactionDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
