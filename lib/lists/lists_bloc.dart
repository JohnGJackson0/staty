import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'lists_state.dart';
part 'lists_event.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  ListsBloc() : super(const ListsState()) {
    on<DataPointAddedEvent>(_onDataPointAdded);
    on<DataPointChangedEvent>(_onDataPointChanged);
  }

  void _onDataPointChanged(
      DataPointChangedEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(lists: state.lists, newDataPoint: event.point));
  }

  void _onDataPointAdded(DataPointAddedEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        lists: List.from(state.lists)..add(event.point),
        newDataPoint: state.newDataPoint));
  }
}
