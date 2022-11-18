import 'package:equatable/equatable.dart';

class DataPoint extends Equatable {
  final double value;
  final String id;

  const DataPoint({required this.value, required this.id});

  double get point {
    return value;
  }

  @override
  List<Object?> get props => [value, id];


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
      'id': id,
    };
  }

  factory DataPoint.fromMap(Map<String, dynamic> map) {
    return DataPoint(
      value: map['value'] as double,
      id: map['id'] as String,
    );
  }
}
