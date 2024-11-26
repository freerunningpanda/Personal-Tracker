import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';

part 'form_state.dart';

/// [FormCubit] is a class.
/// That extends [Cubit] and handles the business logic.
class FormCubit extends Cubit<FormState> {
  /// [FormCubit] constructor.
  FormCubit()
      : super(
          const FormState(
            type: TransactionType.expense,
            category: TransactionCategory.food,
          ),
        );

  /// [validateForm] method is used to validate the form.
  void validateForm({required bool isFormValid}) {
    emit(
      state.copyWith(isFormValid: isFormValid),
    );

    log('Form is valid: $isFormValid');
  }

  /// [setType] method is used to set the type of the transaction.
  void setType({
    TransactionType? type,
  }) =>
      emit(
        state.copyWith(type: type),
      );

  /// [setCategory] method is used to set the category of the transaction.
  void setCategory({TransactionCategory? category}) => emit(
        state.copyWith(category: category),
      );
}
