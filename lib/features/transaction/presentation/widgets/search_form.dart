import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';

/// [SearchForm] is a class.
/// That extends [StatelessWidget] and builds the search form.
class SearchForm extends StatelessWidget {
  /// [SearchForm] constructor.
  const SearchForm({
    this.enabled = false,
    super.key,
  });

  /// [enabled] is a flag to determine if the search form is enabled.
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      child: FormBuilderTextField(
        enabled: enabled,
        name: AppConstants.searchField,
        decoration: InputDecoration(
          labelText: context.tr.search,
          suffixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
              AppConstants.commonSize12,
            ),
          ),
        ),
      ),
    );
  }
}
