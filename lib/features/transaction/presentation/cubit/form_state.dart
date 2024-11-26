part of 'form_cubit.dart';

/// [FormState] is a class.
/// That extends [Equatable] and represents the state of the form.
final class FormState extends Equatable {
  /// [FormState] constructor.
  const FormState({
    required this.type,
    required this.category,
    this.isFormValid = false,
  });

  /// [type] is the type of the transaction.
  final TransactionType type;

  /// [category] is the category of the transaction.
  final TransactionCategory category;

  /// [isFormValid] is a flag to determine if the form is valid.
  final bool isFormValid;

  @override
  List<Object> get props => [
        type,
        category,
        isFormValid,
      ];

  /// [copyWith] method is used to create a new instance of [FormState].
  FormState copyWith({
    TransactionType? type,
    TransactionCategory? category,
    bool? isFormValid,
  }) {
    return FormState(
      type: type ?? this.type,
      category: category ?? this.category,
      isFormValid: isFormValid ?? this.isFormValid,
    );
  }
}
