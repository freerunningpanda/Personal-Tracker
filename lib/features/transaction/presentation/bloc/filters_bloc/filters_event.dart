part of 'filters_bloc.dart';

/// [FiltersEvent] is a class.
/// That represents the events that can be triggered in the [FiltersBloc].
sealed class FiltersEvent {
  const FiltersEvent();
}

/// [SetFiltersEvent] is a class.
/// That represents the event to set filters.
final class SetFiltersEvent extends FiltersEvent {
  /// [SetFiltersEvent] constructor.
  const SetFiltersEvent({
    this.category,
    this.type,
    this.date,
    this.valueFilter,
    this.selectedOption,
  });

  /// [category] is the category to filter by.
  final TransactionCategory? category;

  /// [type] is the type to filter by.
  final TransactionType? type;

  /// [date] is the date to filter by.
  final DateTime? date;

  /// [valueFilter] is the value to filter by.
  /// It can be [ValueFilter.less] or [ValueFilter.more].
  final ValueFilter? valueFilter;

  /// [selectedOption] is the selected option.
  final String? selectedOption;
}

/// [ClearFiltersEvent] is a class.
final class ClearFiltersEvent extends FiltersEvent {
  /// [ClearFiltersEvent] constructor.
  const ClearFiltersEvent();
}
