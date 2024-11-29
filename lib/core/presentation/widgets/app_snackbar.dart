import 'package:flutter/material.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';

/// [AppSnackbar] is a class.
/// That contains the method to show the snackbar.
class AppSnackbar {
  AppSnackbar._();

  /// [show] method.
  /// Shows the snackbar.
  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> show(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    final theme = context.theme;

    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: theme.appColors.mainColors.redColor,
        showCloseIcon: true,
        closeIconColor: theme.appColors.mainColors.blackColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppConstants.commonSize2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: theme.primaryTextTheme.headlineMedium?.copyWith(
                      color: theme.appColors.mainColors.blackColor,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              message,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(
                color: theme.appColors.mainColors.blackColor,
              ),
            ),
          ],
        ),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height / 1.4,
          left: AppConstants.commonSize24,
          right: AppConstants.commonSize24,
        ),
      ),
    );
  }
}
