import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../models/data_point.dart';
import '../models/list_model.dart';
import 'form_submission_status.dart';

part 'lists_state.dart';
part 'lists_event.dart';

class ListsBloc extends Bloc<ListsEvent, ListsState> {
  ListsBloc() : super(const ListsState()) {
    on<DataPointChangedEvent>(_onDataPointChanged);
    on<DataPointSubmitted>(_onDataPointSubmitted);
    on<DeleteDataPointSubmitted>(_onDeleteDataPointSubmitted);
    on<StatListCreatedEvent>(_onStatListCreated);
    on<SelectedTaskIdEvent>(_onSelectedTaskId);
    on<OnErrorEvent>(_onErrorEvent);
  }

  void _onErrorEvent(OnErrorEvent event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        newDataPoint: state.newDataPoint,
        selectedTaskid: state.selectedTaskid,
        formStatus: SubmissionFailed('Something went wrong')));
  }

  void _onSelectedTaskId(SelectedTaskIdEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        newDataPoint: state.newDataPoint,
        selectedTaskid: event.id));
  }

  void _onStatListCreated(
      StatListCreatedEvent event, Emitter<ListsState> emit) {
    var uid = const Uuid().v1();

    try {
      return emit(ListsState(
          listStore: List.from(state.listStore)
            ..add(ListModel(
                data: const [],
                uid: uid,
                name: 'Untitled ${state.listStore.length + 1}')),
          selectedTaskid: uid,
          newDataPoint: state.newDataPoint));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onDataPointChanged(
      DataPointChangedEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        selectedTaskid: state.selectedTaskid,
        newDataPoint: event.point));
  }

  void _onDeleteDataPointSubmitted(
      DeleteDataPointSubmitted event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        selectedTaskid: state.selectedTaskid,
        newDataPoint: state.newDataPoint,
        formStatus: FormSubmitting()));
    try {
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedTaskid;
      });

      List<DataPoint> newList = List.from(filter[0].data)
        ..remove(DataPoint(value: event.point));

      List<ListModel> removedList = List.from(state.listStore)
        ..remove(filter[0]);

      List<ListModel> newListStore = List.from(removedList)
        ..add(ListModel(
            data: newList, uid: state.selectedTaskid, name: filter[0].name));

      emit(ListsState(
          listStore: newListStore,
          selectedTaskid: state.selectedTaskid,
          newDataPoint: '',
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          selectedTaskid: state.selectedTaskid,
          newDataPoint: state.newDataPoint,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onDataPointSubmitted(
      DataPointSubmitted event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        selectedTaskid: state.selectedTaskid,
        newDataPoint: state.newDataPoint,
        formStatus: FormSubmitting()));

    try {
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedTaskid;
      });

      List<DataPoint> newList = List.from(filter[0].data)
        ..add(DataPoint(value: double.parse(state.newDataPoint)));

      List<ListModel> removedList = List.from(state.listStore)
        ..remove(filter[0]);

      List<ListModel> newListStore = List.from(removedList)
        ..add(ListModel(
            data: newList, uid: state.selectedTaskid, name: filter[0].name));

      if (state.newDataPoint.isEmpty) {
        throw 'Empty Datapoint';
      }
      emit(ListsState(
          // lists: List.from(state.lists)..add(double.parse(state.newDataPoint)),
          listStore: newListStore,
          newDataPoint: '',
          selectedTaskid: state.selectedTaskid,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          newDataPoint: state.newDataPoint,
          selectedTaskid: state.selectedTaskid,
          formStatus: SubmissionFailed(e)));
    }
  }
}
