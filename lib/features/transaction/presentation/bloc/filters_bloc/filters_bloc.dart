import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tracker/core/enums/transaction_category.dart';
import 'package:tracker/core/enums/transaction_type.dart';
import 'package:tracker/core/enums/value_filter.dart';

part 'filters_event.dart';
part 'filters_state.dart';

typedef _Emit = Emitter<FiltersState>;

/// [FiltersBloc] is a class.
/// That extends [Bloc] and handles the business logic.
class FiltersBloc extends Bloc<FiltersEvent, FiltersState> {
  /// [FiltersBloc] constructor.
  FiltersBloc() : super(const FiltersState()) {
    on<SetFiltersEvent>(_onSetFilters);
    on<ClearFiltersEvent>(_onClearFilters);
  }

  void _onSetFilters(SetFiltersEvent event, _Emit emit) => emit(
        state.copyWith(
          category: event.category,
          type: event.type,
          date: event.date,
          valueFilter: event.valueFilter,
          selectedOption: event.selectedOption,
        ),
      );

  void _onClearFilters(ClearFiltersEvent event, _Emit emit) => emit(
        const FiltersState(),
      );
}
