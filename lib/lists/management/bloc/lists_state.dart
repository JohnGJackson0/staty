part of 'lists_bloc.dart';

class ListsState extends Equatable {
  final List<ListModel> listStore;
  final SubmissionData submissionData;
  final FormSubmissionStatus formStatus;
  final String selectedTaskid;
  final String selectedListIdTwo;

  bool isValidDatapointInput() {
    try {
      double.parse(submissionData.newDataPoint);
      return true;
    } catch (e) {
      return false;
    }
  }

  const ListsState(
      {this.listStore = const [],
      this.selectedListIdTwo = '',
      this.submissionData = const SubmissionData(),
      this.formStatus = const InitialFormStatus(),
      this.selectedTaskid = ''});

  @override
  List<Object?> get props =>
      [
        listStore,
        submissionData,
        formStatus,
        selectedTaskid,
        selectedListIdTwo
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listStore': listStore.map((x) => x.toMap()).toList(),
      'submissionData': submissionData.toMap(),
      'selectedTaskid': selectedTaskid,
      'selectedListIdTwo': selectedListIdTwo,
    };
  }

  factory ListsState.fromMap(Map<String, dynamic> map) {
    List<dynamic> listStore = map['listStore'];
    List<ListModel> listModel = [];

    for (var element in listStore) {
      List<dynamic> datas = element['data'];

      List<DataPoint> dataPoints = [];
      for (var element in datas) {
        dataPoints.add(DataPoint(value: element['value'], id: element['id']));
      }
      ListModel model = ListModel(
          data: dataPoints,
          uid: element['uid'],
          name: element['name'],
          lastEditedDate: element['lastEditedDate']);
      listModel.add(model);
    }
    return ListsState(
      listStore: listModel,
      submissionData:
          SubmissionData.fromMap(map['submissionData'] as Map<String, dynamic>),
      selectedTaskid: map['selectedTaskid'] as String,
      selectedListIdTwo: map['selectedListIdTwo'] as String,
    );
  }
}
