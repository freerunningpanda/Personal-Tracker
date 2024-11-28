import 'package:flutter/material.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/features/transaction/presentation/widgets/filter_controls.dart';
import 'package:tracker/features/transaction/presentation/widgets/search_form.dart';

/// [TopControls] is a class.
/// That extends [StatelessWidget] and builds the top controls.
/// Contains [SearchForm] and [FilterControls].
class TopControls extends StatelessWidget {
  /// [TopControls] constructor.
  const TopControls({
    this.isSearchEnabled = false,
    this.isFiltersEnabled = false,
    super.key,
  });

  /// [isSearchEnabled] is a flag to determine if the search is enabled.
  final bool isSearchEnabled;

  /// [isFiltersEnabled] is a flag to determine if the filters are enabled.
  final bool isFiltersEnabled;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
          top: AppConstants.commonSize16,
          left: AppConstants.commonSize16,
          bottom: AppConstants.commonSize16,
        ),
        child: Row(
          children: [
            Expanded(
              child: SearchForm(enabled: isSearchEnabled),
            ),
            FilterControls(
              enabled: isFiltersEnabled,
            ),
          ],
        ),
      );
}
