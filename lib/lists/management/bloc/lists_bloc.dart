import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../model/form_submission_status.dart';
import '../model/model_exports.dart';
import '../model/submission_data.dart';

part 'lists_state.dart';
part 'lists_event.dart';

class ListsBloc extends HydratedBloc<ListsEvent, ListsState> {
  ListsBloc() : super(const ListsState()) {
    on<NewDataPointInputChangedEvent>(_onNewDataPointChanged);
    on<NewDataPointSubmitted>(_onNewDataPointSubmitted);
    on<DeleteDataPointSubmitted>(_onDeleteDataPointSubmitted);
    on<StatListCreatedEvent>(_onStatListCreated);
    on<SelectListOneEvent>(_onSelectListOneEvent);
    on<SelectListTwoEvent>(_onSelectListTwoEvent);
    on<OnErrorEvent>(_onErrorEvent);
    on<ExistingDataPointChangedInputEvent>(_onExistingDataPointChangedEvent);
    on<UpdateDataPointSubmitted>(_onUpdateDataPointSubmitted);
    on<SubmitNewListNameEvent>(_onSubmitNewListNameEvent);
    on<DeleteListSubmittedEvent>(_onDeleteListSubmittedEvent);
  }

  void _onDeleteListSubmittedEvent(
      DeleteListSubmittedEvent event, Emitter<ListsState> emit) {
    List<ListModel> filter = [];
    filter.addAll(state.listStore);

    filter.retainWhere((e) {
      return e.uid == state.selectedListIdOne;
    });

    List<ListModel> removedList = List.from(state.listStore)..remove(filter[0]);

    emit(ListsState(
        listStore: removedList,
        submissionData: state.submissionData,
        selectedListIdOne: state.selectedListIdOne,
        formStatus: SubmissionFailed('Something went wrong')));
  }

  void _onErrorEvent(OnErrorEvent event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        submissionData: state.submissionData,
        selectedListIdOne: state.selectedListIdOne,
        formStatus: SubmissionFailed('Something went wrong')));
  }

  void _onSelectListOneEvent(
      SelectListOneEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        submissionData: state.submissionData,
        selectedListIdOne: event.id,
        selectedListIdTwo: state.selectedListIdTwo));
  }

  void _onSelectListTwoEvent(
      SelectListTwoEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        submissionData: state.submissionData,
        selectedListIdOne: state.selectedListIdOne,
        selectedListIdTwo: event.id));
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
                lastEditedDate: DateTime.now().toString(),
                name: 'New List ${state.listStore.length + 1}')),
          selectedListIdOne: uid,
          submissionData: const SubmissionData()));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _onExistingDataPointChangedEvent(
      ExistingDataPointChangedInputEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        selectedListIdOne: state.selectedListIdOne,
        submissionData:
            SubmissionData(newDataPoint: event.point, uid: event.id)));
  }

  void _onNewDataPointChanged(
      NewDataPointInputChangedEvent event, Emitter<ListsState> emit) {
    return emit(ListsState(
        listStore: state.listStore,
        selectedListIdOne: state.selectedListIdOne,
        submissionData: SubmissionData(newDataPoint: event.point, uid: '')));
  }

  void _onSubmitNewListNameEvent(
      SubmitNewListNameEvent event, Emitter<ListsState> emit) {
    try {
      emit(ListsState(
          listStore: state.listStore,
          selectedListIdOne: state.selectedListIdOne,
          submissionData: state.submissionData,
          formStatus: FormSubmitting()));

      // get list refactor
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedListIdOne;
      });

      var newList = filter[0].copyWith(
          name: event.newName, lastEditedDate: DateTime.now().toString());

      List<ListModel> removedList = List.from(state.listStore)
        ..remove(filter[0]);

      List<ListModel> newListStore = List.from(removedList)..add(newList);

      emit(ListsState(
          listStore: newListStore,
          selectedListIdOne: state.selectedListIdOne,
          submissionData: state.submissionData,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          selectedListIdOne: state.selectedListIdOne,
          submissionData: state.submissionData,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onDeleteDataPointSubmitted(
      DeleteDataPointSubmitted event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        selectedListIdOne: state.selectedListIdOne,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));
    try {
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedListIdOne;
      });

      filter[0].data.removeWhere((e) {
        return e.id == event.deletedDataPoint.id;
      });

      List<ListModel> removedList = List.from(state.listStore);

      removedList
          .removeWhere((element) => element.uid == state.selectedListIdOne);

      List<ListModel> newListStore = List.from(removedList)
        ..add(ListModel(
            data: filter[0].data,
            lastEditedDate: DateTime.now().toString(),
            uid: state.selectedListIdOne,
            name: filter[0].name));

      emit(ListsState(
          listStore: newListStore,
          selectedListIdOne: state.selectedListIdOne,
          submissionData: const SubmissionData(newDataPoint: ''),
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          selectedListIdOne: state.selectedListIdOne,
          submissionData: state.submissionData,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onUpdateDataPointSubmitted(
      UpdateDataPointSubmitted event, Emitter<ListsState> emit) {
    emit(ListsState(
        listStore: state.listStore,
        selectedListIdOne: state.selectedListIdOne,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedListIdOne;
      });

      filter[0]
          .data
          .retainWhere((element) => element.id != state.submissionData.uid);

      // insert into new list
      List<DataPoint> newList = List.from(filter[0].data)
        ..add(DataPoint(
            value: double.parse(state.submissionData.newDataPoint),
            id: state.submissionData.uid));

      List<ListModel> removedList = List.from(state.listStore)
        ..remove(filter[0]);

      List<ListModel> newListStore = List.from(removedList)
        ..add(ListModel(
            data: newList,
            lastEditedDate: DateTime.now().toString(),
            uid: state.selectedListIdOne,
            name: filter[0].name));

      if (state.submissionData.newDataPoint.isEmpty) {
        throw 'Empty Datapoint';
      }
      emit(ListsState(
          listStore: newListStore,
          submissionData: state.submissionData,
          selectedListIdOne: state.selectedListIdOne,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          submissionData: state.submissionData,
          selectedListIdOne: state.selectedListIdOne,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onNewDataPointSubmitted(
      NewDataPointSubmitted event, Emitter<ListsState> emit) {
    var uid = const Uuid().v1();
    emit(ListsState(
        listStore: state.listStore,
        selectedListIdOne: state.selectedListIdOne,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      List<ListModel> filter = [];
      filter.addAll(state.listStore);

      filter.retainWhere((e) {
        return e.uid == state.selectedListIdOne;
      });

      List<DataPoint> newList = List.from(filter[0].data)
        ..add(DataPoint(
            value: double.parse(state.submissionData.newDataPoint), id: uid));

      List<ListModel> removedList = List.from(state.listStore)
        ..remove(filter[0]);

      List<ListModel> newListStore = List.from(removedList)
        ..add(ListModel(
            data: newList,
            lastEditedDate: DateTime.now().toString(),
            uid: state.selectedListIdOne,
            name: filter[0].name));

      if (state.submissionData.newDataPoint.isEmpty) {
        throw 'Empty Datapoint';
      }

      emit(ListsState(
          // lists: List.from(state.lists)..add(double.parse(state.newDataPoint)),
          listStore: newListStore,
          submissionData: const SubmissionData(uid: '', newDataPoint: ''),
          selectedListIdOne: state.selectedListIdOne,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ListsState(
          listStore: state.listStore,
          submissionData: state.submissionData,
          selectedListIdOne: state.selectedListIdOne,
          formStatus: SubmissionFailed(e)));
    }
  }

  @override
  ListsState? fromJson(Map<String, dynamic> json) {
    return ListsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(ListsState state) {
    return state.toMap();
  }
}
