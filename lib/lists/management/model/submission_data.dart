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
