import 'dart:ffi';
import 'package:equatable/equatable.dart';
import '../model/data_point.dart';
import 'package:statistics/statistics.dart';

extension FloatArrayFill<T> on Array<Float> {
  void fillFromList(List<T> list) {
    for (var i = 0; i < list.length; i++) {
      this[i] = list[i] as double;
    }
  }
}

class OneVarStatsService extends Equatable {
  final List<DataPoint> list;

  const OneVarStatsService({required this.list});

  @override
  List<Object?> get props => [list];

  getStats() {
    List<double> normalized = [];

    for (var i = 0; i < list.length; i++) {
      normalized.add(list[i].value);
    }
    var statistics = normalized.statistics;

    return statistics;
  }
}
