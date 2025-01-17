import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tracker/core/constants/app_constants.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/presentation/theme/app_theme.dart';
import 'package:tracker/core/presentation/widgets/app_snackbar.dart';
import 'package:tracker/core/utils/extensions/build_context_ext.dart';
import 'package:tracker/features/analysis/presentation/bloc/analysis_bloc.dart';
import 'package:tracker/features/transaction/domain/entities/transaction.dart';
import 'package:tracker/features/transaction/presentation/bloc/transaction_bloc/transaction_bloc.dart';
import 'package:tracker/features/transaction/presentation/bloc/transactions_bloc/transactions_bloc.dart';
import 'package:tracker/features/transaction/presentation/cubit/form_cubit.dart'
    as cubit;
import 'package:tracker/features/transaction/presentation/widgets/transaction_form_content.dart';

part 'transaction_dialog_utils.dart';
part '../widgets/transaction_dialog.dart';
