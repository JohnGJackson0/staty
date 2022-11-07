import 'package:equatable/equatable.dart';

class DataPoint extends Equatable {
  final double value;

  const DataPoint({required this.value});

  double get point {
    return value;
  }

  @override
  List<Object?> get props => [value];
}
