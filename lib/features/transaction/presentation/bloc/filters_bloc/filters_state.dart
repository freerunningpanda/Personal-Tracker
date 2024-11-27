part of 'filters_bloc.dart';

/// [FiltersState] is a class.
/// That represents the state of the [FiltersBloc].
final class FiltersState extends Equatable {
  /// [FiltersState] constructor.
  const FiltersState({
    this.category,
    this.type,
    this.date,
    this.valueFilter,
    this.selectedOption,
  });

  /// [category] is the transaction category.
  final TransactionCategory? category;

  /// [type] is the transaction type.
  final TransactionType? type;

  /// [date] is the date to filter the transactions.
  final DateTime? date;

  /// [valueFilter] is the value filter to filter the transactions.
  final ValueFilter? valueFilter;

  /// [selectedOption] is the selected option.
  final String? selectedOption;

  @override
  List<Object?> get props => [
        category,
        type,
        date,
        valueFilter,
        selectedOption,
      ];

  /// [copyWith] method.
  FiltersState copyWith({
    TransactionCategory? category,
    TransactionType? type,
    DateTime? date,
    ValueFilter? valueFilter,
    String? selectedOption,
  }) =>
      FiltersState(
        category: category ?? this.category,
        type: type ?? this.type,
        date: date ?? this.date,
        valueFilter: valueFilter ?? this.valueFilter,
        selectedOption: selectedOption ?? this.selectedOption,
      );
}
