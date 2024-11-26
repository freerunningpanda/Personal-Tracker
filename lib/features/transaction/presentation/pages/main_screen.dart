import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/presentation/widgets/app_tap_bar.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/transaction_dialog.dart';
import 'package:tracker/features/transaction/presentation/widgets/transactions_view.dart';

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
