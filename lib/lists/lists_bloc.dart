import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'form_submission_status.dart';

part 'lists_state.dart';
part 'lists_event.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  ListsBloc() : super(const ListsState()) {
    on<DataPointChangedEvent>(_onDataPointChanged);
    on<DatapointSubmitted>(_onDataPointSubmitted);
  }

  void _onDataPointChanged(
      DataPointChangedEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(lists: state.lists, newDataPoint: event.point));
  }

  void _onDataPointSubmitted(
      DatapointSubmitted event, Emitter<ListsState> emit) {
    emit(ListsState(
        lists: state.lists,
        newDataPoint: state.newDataPoint,
        formStatus: FormSubmitting()));

    try {
      if (state.newDataPoint.isEmpty) {
        throw 'Empty Datapoint';
      }
      emit(ListsState(
          lists: List.from(state.lists)..add(double.parse(state.newDataPoint)),
          newDataPoint: '',
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          lists: state.lists,
          newDataPoint: state.newDataPoint,
          formStatus: SubmissionFailed(e)));
    }
  }
}
