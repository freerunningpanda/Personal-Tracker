import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/presentation/widgets/app_tap_bar.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/presentation/widgets/analysis_view.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';
import 'package:tracker/features/transaction/presentation/utils/core.dart';
import 'package:tracker/features/transaction/presentation/widgets/top_controls.dart';
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
    final tabTitleList = [
      context.tr.transactions,
      context.tr.analytics,
    ];

    const spacer = Spacer();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            AppTabBar(
              tabTitleList: tabTitleList,
              tabController: _tabController,
            ),
            Expanded(
              child: BlocBuilder<TransactionsBloc, TransactionsState>(
                builder: (_, state) => switch (state) {
                  TransactionsInitialState _ => Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Column(
                                children: [
                                  const TopControls(),
                                  spacer,
                                  Text(
                                    context.tr.noTransactionsYet,
                                    style: TextStyle(
                                      color: theme
                                          .appColors.textColors.secondaryColor,
                                    ),
                                  ),
                                  Text(
                                    context.tr.addSome,
                                    style: TextStyle(
                                      color: theme
                                          .appColors.textColors.secondaryColor,
                                    ),
                                  ),
                                  spacer,
                                ],
                              ),
                              const AnalysisView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  TransactionsLoadingState _ => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  TransactionsLoadedState _ => Column(
                      children: [
                        Expanded(
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              TransactionsView(
                                transactions: state.transactions,
                              ),
                              const AnalysisView(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  TransactionsErrorState _ => Center(
                      child: Text(state.message),
                    ),
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: theme.appColors.mainColors.purpleColor,
        onPressed: () => showDialog<TransactionDialog>(
          context: context,
          builder: (_) => const TransactionDialog(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
