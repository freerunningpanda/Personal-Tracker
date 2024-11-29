import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';

/// [FiltersDropdown] is a class.
/// That extends [StatelessWidget] and builds the filters dropdown.
class FiltersDropdown extends StatelessWidget {
  /// [FiltersDropdown] constructor.
  const FiltersDropdown({
    required this.firstCategory,
    required this.firstType,
    super.key,
  });

  /// [firstCategory] is the first category.
  /// shows if the category from the state is null.
  final TransactionCategory firstCategory;

  /// [firstType] is the first type.
  final TransactionType firstType;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final bloc = context.read<FiltersBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: AppConstants.commonSize16,
          ),
          child: Text(
            context.tr.category,
            style: theme.primaryTextTheme.bodyLarge?.copyWith(
              color: theme.appColors.textColors.mainColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            bottom: AppConstants.commonSize16,
          ),
          child: DropdownButton<TransactionCategory>(
            isExpanded: true,
            value: bloc.state.category ?? firstCategory,
            items: TransactionCategory.values
                .map(
                  (category) => DropdownMenuItem(
                    value: category,
                    child: Text(category.getName(context)),
                  ),
                )
                .toList(),
            onChanged: (category) =>
                bloc.add(SetFiltersEvent(category: category)),
          ),
        ),
        Text(
          context.tr.type,
          style: theme.primaryTextTheme.bodyLarge?.copyWith(
            color: theme.appColors.textColors.mainColor,
          ),
        ),
        DropdownButton<TransactionType>(
          isExpanded: true,
          value: bloc.state.type ?? firstType,
          items: TransactionType.values
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type.getName(context)),
                ),
              )
              .toList(),
          onChanged: (type) => bloc.add(SetFiltersEvent(type: type)),
        ),
      ],
    );
  }
}
