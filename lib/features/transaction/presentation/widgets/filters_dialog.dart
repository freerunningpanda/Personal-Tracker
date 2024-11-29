import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/enums/value_filter.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';

/// [FiltersDialog] is a class.
/// That extends [StatelessWidget] and builds the filters dialog.
class FiltersDialog extends StatelessWidget {
  /// [FiltersDialog] constructor.
  const FiltersDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<FiltersBloc>();
    final firstCategory = TransactionCategory.values.first;
    final firstType = TransactionType.values.first;
    final theme = context.theme;

    return BlocBuilder<FiltersBloc, FiltersState>(
      builder: (_, state) => AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.tr.category,
              style: theme.primaryTextTheme.bodyLarge?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
            DropdownButton<TransactionCategory>(
              isExpanded: true,
              value: state.category ?? firstCategory,
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
            Text(
              context.tr.type,
              style: theme.primaryTextTheme.bodyLarge?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
            DropdownButton<TransactionType>(
              isExpanded: true,
              value: state.type ?? firstType,
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
            FormBuilderDateTimePicker(
              name: AppConstants.filteredDateTimeField,
              inputType: InputType.date,
              format: DateTimeHelper.dateFormat,
              decoration: InputDecoration(
                labelText: context.tr.date,
                suffixIcon: const Icon(Icons.calendar_today),
              ),
              onChanged: (date) => bloc.add(SetFiltersEvent(date: date)),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: AppConstants.commonSize16,
              ),
              child: Text(
                context.tr.amount,
                style: theme.primaryTextTheme.bodyLarge?.copyWith(
                  color: theme.appColors.textColors.mainColor,
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.tr.fromLess),
              leading: Radio<String>(
                value: context.tr.fromLess,
                groupValue: state.selectedOption,
                onChanged: (value) => bloc.add(
                  SetFiltersEvent(
                    valueFilter: ValueFilter.less,
                    selectedOption: value,
                  ),
                ),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.tr.fromMore),
              leading: Radio<String>(
                value: context.tr.fromMore,
                groupValue: state.selectedOption,
                onChanged: (value) => bloc.add(
                  SetFiltersEvent(
                    valueFilter: ValueFilter.more,
                    selectedOption: value,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              MaterialLocalizations.of(context).cancelButtonLabel,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<TransactionsBloc>().add(
                    GetFilteredTransactionsEvent(
                      category: state.category != TransactionCategory.all
                          ? state.category
                          : null,
                      type:
                          state.type != TransactionType.all ? state.type : null,
                      date: state.date,
                      valueFilter: state.valueFilter,
                    ),
                  );
              context.maybePop();
            },
            child: Text(
              context.tr.apply,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: theme.appColors.textColors.mainColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
