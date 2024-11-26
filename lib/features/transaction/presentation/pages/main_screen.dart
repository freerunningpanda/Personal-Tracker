import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/presentation/widgets/app_tap_bar.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/transaction_dialog.dart';

/// [MainScreen] is a class.
/// That extends [StatelessWidget] and builds the main screen.

@RoutePage()
class MainScreen extends StatefulWidget {
  /// [MainScreen] constructor.
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const tabTitleList = ['Transactions', 'Analytics'];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTabBar(
              tabTitleList: tabTitleList,
              tabController: _tabController,
            ),
            Expanded(
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (_, state) => switch (state) {
                  TransactionInitialState _ => Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Center(
                                child: Text(
                                  'No transactions yet',
                                  style: TextStyle(
                                    color: theme
                                        .appColors.textColors.secondaryColor,
                                  ),
                                ),
                              ),
                              const Center(
                                child: Text('Analytics'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  TransactionLoadingState _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  TransactionLoadedState _ => Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              TransactionsView(
                                transactions: state.transactions,
                              ),
                              const Center(
                                child: Text('Analytics'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  TransactionErrorState _ => Center(
                      child: Text(state.message),
                    ),
                },
              ),
            ),
          ],
        ),
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
