import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/value_filter.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/presentation/bloc/filters_bloc/filters_bloc.dart';

/// [FiltersAmountSelector] is a class.
/// That extends [StatelessWidget] and builds the filters amount selector.
class FiltersAmountSelector extends StatelessWidget {
  /// [FiltersAmountSelector] constructor.
  const FiltersAmountSelector({
    super.key,
  });

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
            groupValue: bloc.state.selectedOption,
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
            groupValue: bloc.state.selectedOption,
            onChanged: (value) => bloc.add(
              SetFiltersEvent(
                valueFilter: ValueFilter.more,
                selectedOption: value,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
