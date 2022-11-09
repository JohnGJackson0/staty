import 'package:equatable/equatable.dart';

import 'package:staty/models/data_point.dart';

class ListModel extends Equatable {
  final List<DataPoint> data;
  final String uid;
  final String name;

  const ListModel({required this.data, required this.uid, required this.name});

  @override
  List<Object?> get props => [data, uid, name];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'uid': uid,
      'name': name,
    };
  }

  factory ListModel.fromMap(Map<String, dynamic> map) {
    return ListModel(
      data: List<DataPoint>.from(
        (map['data'] as List<int>).map<DataPoint>(
          (x) => DataPoint.fromMap(x as Map<String, dynamic>),
        ),
      ),
      uid: map['uid'] as String,
      name: map['name'] as String,
    );
  } 
}
