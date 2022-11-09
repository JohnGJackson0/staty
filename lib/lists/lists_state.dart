part of 'lists_bloc.dart';

class ListsState extends Equatable {
  final List<ListModel> listStore;
  final String newDataPoint;
  final FormSubmissionStatus formStatus;
  final String selectedTaskid;

  bool isValidDatapointInput() {
    try {
      double.parse(newDataPoint);
      return true;
    } catch (e) {
      return false;
    }
  }

  const ListsState(
      {this.listStore = const [],
      this.newDataPoint = '',
      this.formStatus = const InitialFormStatus(),
      this.selectedTaskid = ''});

  @override
  List<Object?> get props =>
      [listStore, newDataPoint, formStatus, selectedTaskid];

  ListsState copyWith({
    List<ListModel>? listStore,
    String? newDataPoint,
    FormSubmissionStatus? formStatus,
    String? selectedTaskid,
  }) {
    return ListsState(
      listStore: this.listStore,
      newDataPoint: this.newDataPoint,
      formStatus: this.formStatus,
      selectedTaskid: this.selectedTaskid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listStore': listStore.map((x) => x.toMap()).toList(),
      'newDataPoint': newDataPoint,
      'formStatus': null,
      'selectedTaskid': selectedTaskid,
    };
  }

  factory ListsState.fromMap(Map<String, dynamic> map) {
    return ListsState(
      listStore: List<ListModel>.from(
        (map['listStore'] as List<int>).map<ListModel>(
          (x) => ListModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      newDataPoint: map['newDataPoint'] as String,
      formStatus: map['formStatus'],
      selectedTaskid: map['selectedTaskid'] as String,
    );
  }

}

/*
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listStore': listStore.map((x) => x.toMap()).toList(),
      'newDataPoint': newDataPoint,
      'selectedTaskid': selectedTaskid,
    };
  }

  factory ListsState.fromMap(Map<String, dynamic> map) {
    return ListsState(
      listStore: List<ListModel>.from(
        (map['listStore'])?.map(
          (x) => ListModel.fromMap(x),
        ),
      ),
      newDataPoint: map['newDataPoint'],
      selectedTaskid: map['selectedTaskid'],
    );
  }


 */



/*

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listStore': listStore.map((x) => x.toMap()).toList(),
      'newDataPoint': newDataPoint,
      'selectedTaskid': selectedTaskid,
    };
  }

  factory ListsState.fromMap(Map<String, dynamic> map) {
    return ListsState(
      listStore: List<ListModel>.from(
        (map['listStore'] as List<int>).map<ListModel>(
          (x) => ListModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      newDataPoint: map['newDataPoint'] as String,
      selectedTaskid: map['selectedTaskid'] as String,
    );
  }


 */