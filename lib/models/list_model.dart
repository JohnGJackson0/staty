import 'package:equatable/equatable.dart';

import 'package:staty/models/data_point.dart';

class ListModel extends Equatable {
  final List<DataPoint> data;
  final String uid;
  final String name;

  const ListModel({required this.data, required this.uid, required this.name});

  @override
  List<Object?> get props => [data, uid, name];
}
