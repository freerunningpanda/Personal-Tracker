import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';
import 'package:tracker/features/transaction/presentation/widgets/filters_dialog.dart';

/// [FilterControls] is a class.
/// That extends [StatelessWidget] and builds the filter controls.
class FilterControls extends StatelessWidget {
  /// [FilterControls] constructor.
  const FilterControls({
    this.enabled = false,
    super.key,
  });

  /// [enabled] is a flag to determine if the filter is enabled.
  final bool enabled;

  void Function() _resetFilters(BuildContext context) => () {
        context
          ..read<FiltersBloc>().add(
            const ClearFiltersEvent(),
          )
          ..read<TransactionsBloc>().add(
            const GetTransactionsEvent(),
          );
      };

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: enabled
              ? () => showDialog<FiltersDialog>(
                    context: context,
                    builder: (context) => const FiltersDialog(),
                  )
              : null,
          icon: const Icon(Icons.filter_list),
          color: theme.appColors.textColors.secondaryColor,
        ),
        IconButton(
          onPressed: enabled ? _resetFilters(context) : null,
          icon: const Icon(Icons.close),
          color: theme.appColors.textColors.secondaryColor,
        ),
      ],
    );
  }
}
