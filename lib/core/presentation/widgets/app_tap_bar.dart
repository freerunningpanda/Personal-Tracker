import 'package:flutter/material.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';

/// [AppTabBar] is a class that extends [StatelessWidget].
class AppTabBar extends StatelessWidget {
  /// [AppTabBar] constructor.
  const AppTabBar({
    required this.tabTitleList,
    required this.tabController,
    super.key,
  });

  /// [tabTitleList] is the list of the tab names.
  final List<String> tabTitleList;

  /// [tabController] is the tab controller.
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    const offset = Offset(0, 1);
    const blurRadius = 1.5;

    return Padding(
      padding: const EdgeInsets.all(
        AppConstants.commonSize16,
      ),
      child: TabBar(
        dividerColor: theme.appColors.otherColors.transparent,
        indicatorWeight: 0,
        unselectedLabelStyle: theme.primaryTextTheme.bodyMedium?.copyWith(
          color: theme.appColors.textColors.secondaryColor,
        ),
        labelStyle: theme.primaryTextTheme.bodyLarge?.copyWith(
          color: theme.appColors.textColors.mainColor,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelColor: theme.appColors.textColors.secondaryColor,
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: theme.appColors.mainColors.blackColor.withOpacity(0.3),
              offset: offset,
              blurRadius: blurRadius,
            ),
          ],
          color: theme.appColors.mainColors.blueColor,
          borderRadius: BorderRadius.circular(
            AppConstants.commonSize12,
          ),
        ),
        labelColor: theme.appColors.textColors.mainColor,
        controller: tabController,
        tabs: tabTitleList.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }
}
