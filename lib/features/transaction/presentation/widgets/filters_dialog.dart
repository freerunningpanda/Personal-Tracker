import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/enums/value_filter.dart';
import 'package:tracker/core/helpers/date_time_helper.dart';
import 'package:tracker/core/presentation/router/app_router.gr.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/transaction/domain/usecases/get_filtered_transactions.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc.dart';

/// [FiltersDialog] is a class.
/// That extends [StatelessWidget] and builds the filters dialog.
class FiltersDialog extends StatefulWidget {
  /// [FiltersDialog] constructor.
  const FiltersDialog({super.key});

  @override
  State<FiltersDialog> createState() => _FiltersDialogState();
}

class _FiltersDialogState extends State<FiltersDialog> {
  String? _selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return FormBuilder(
      key: formKey,
      child: AlertDialog(
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<TransactionCategory>(
              isExpanded: true,
              value: TransactionCategory.food,
              items: TransactionCategory.values
                  .map(
                    (category) => DropdownMenuItem(
                      value: category,
                      child: Text(category.toString().split('.').last),
                    ),
                  )
                  .toList(),
              onChanged: (category) {},
            ),
            DropdownButton<TransactionType>(
              isExpanded: true,
              value: TransactionType.expense,
              items: TransactionType.values
                  .map(
                    (type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    ),
                  )
                  .toList(),
              onChanged: (type) {},
            ),
            FormBuilderDateTimePicker(
              name: AppConstants.filteredDateTimeField,
              initialValue: DateTime.now(),
              inputType: InputType.date,
              format: DateTimeHelper.dateFormat,
              decoration: InputDecoration(
                labelText: context.tr.date,
                suffixIcon: const Icon(Icons.calendar_today),
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.tr.fromLess),
              leading: Radio<String>(
                value: context.tr.fromLess,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });

                  log('Option 1: $_selectedOption');
                },
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(context.tr.fromMore),
              leading: Radio<String>(
                value: context.tr.fromMore,
                groupValue: _selectedOption,
                onChanged: (value) {
                  setState(() {
                    _selectedOption = value;
                  });
                  log('Option 2: $_selectedOption');
                },
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              MaterialLocalizations.of(context).cancelButtonLabel,
            ),
          ),
          TextButton(
            onPressed: () {
              // formKey.currentState?.saveAndValidate();
              context.read<TransactionBloc>().add(
                    GetFilteredTransactionsEvent(
                      GetFilteredTransactionsParams(
                        category: TransactionCategory.food,
                        type: TransactionType.expense,
                        date: DateTime.now().subtract(
                          const Duration(days: 12),
                        ),
                        valueFilter: ValueFilter.more,
                      ),
                    ),
                  );
              context.maybePop();
            },
            child: Text('Apply'),
          ),
        ],
      ),
    );
  }
}
