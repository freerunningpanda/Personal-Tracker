import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/filters_dialog.dart';

/// [FilterControls] is a class.
/// That extends [StatelessWidget] and builds the filter controls.
class FilterControls extends StatelessWidget {
  /// [FilterControls] constructor.
  const FilterControls({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () => showDialog<FiltersDialog>(
            context: context,
            builder: (context) => const FiltersDialog(),
          ),
          icon: const Icon(Icons.filter_list),
          color: theme.appColors.textColors.secondaryColor,
        ),
        IconButton(
          onPressed: () {
            context
              ..read<FiltersBloc>().add(
                const ClearFiltersEvent(),
              )
              ..read<TransactionBloc>().add(
                const GetTransactionsEvent(),
              );
          },
          icon: const Icon(Icons.close),
          color: theme.appColors.textColors.secondaryColor,
        ),
      ],
    );
  }
}
