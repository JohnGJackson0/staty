part of 'lists_bloc.dart';

class SubmissionData {
  final String newDataPoint;
  final String uid;

  const SubmissionData({this.newDataPoint = '', this.uid = ''});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'newDataPoint': newDataPoint,
      'uid': uid,
    };
  }

  factory SubmissionData.fromMap(Map<String, dynamic> map) {
    return SubmissionData(
      newDataPoint: map['newDataPoint'] as String,
      uid: map['uid'] as String,
    );
  }
}

class ListsState extends Equatable {
  final List<ListModel> listStore;
  final SubmissionData submissionData;
  final FormSubmissionStatus formStatus;
  final String selectedTaskid;

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
      this.submissionData = const SubmissionData(),
      this.formStatus = const InitialFormStatus(),
      this.selectedTaskid = ''});

  @override
  List<Object?> get props =>
      [listStore, submissionData, formStatus, selectedTaskid];



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'listStore': listStore.map((x) => x.toMap()).toList(),
      'submissionData': submissionData.toMap(),
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
      submissionData:
          SubmissionData.fromMap(map['submissionData'] as Map<String, dynamic>),
      selectedTaskid: map['selectedTaskid'] as String,
    );
  }
}
