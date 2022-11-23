import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:staty/lists/management/model/data_point.dart';

class ListModel extends Equatable {
  final List<DataPoint> data;
  final String uid;
  final String name;
  final String lastEditedDate;

  const ListModel(
      {required this.data,
      required this.uid,
      required this.name,
      required this.lastEditedDate});

  @override
  List<Object?> get props => [data, uid, name, lastEditedDate];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'data': data.map((x) => x.toMap()).toList(),
      'uid': uid,
      'name': name,
      'lastEditedDate': lastEditedDate,
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
      lastEditedDate: map['lastEditedDate'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ListModel.fromJson(String source) =>
      ListModel.fromMap(json.decode(source) as Map<String, dynamic>);

  ListModel copyWith({
    List<DataPoint>? data,
    String? uid,
    String? name,
    String? lastEditedDate,
  }) {
    return ListModel(
      data: data ?? this.data,
      uid: uid ?? this.uid,
      name: name ?? this.name,
      lastEditedDate: lastEditedDate ?? this.lastEditedDate,
    );
  }
}
