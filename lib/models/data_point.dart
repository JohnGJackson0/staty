import 'package:equatable/equatable.dart';

class DataPoint extends Equatable {
  final double value;

  const DataPoint({required this.value});

  double get point {
    return value;
  }

  @override
  List<Object?> get props => [value];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'value': value,
    };
  }

  factory DataPoint.fromMap(Map<String, dynamic> map) {
    return DataPoint(
      value: map['value'] as double,
    );
  }
}
