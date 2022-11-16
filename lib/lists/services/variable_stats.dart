import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:statistics/statistics.dart';

import '../model/data_point.dart';
import '../model/one_var_stats_model.dart';


class OneVarStatsService extends Equatable {
  final List<DataPoint> list;

  final List<double> _normalized = [];

  late final Statistics _statistics;

  OneVarStatsService({required this.list}) {
    for (var i = 0; i < list.length; i++) {
      _normalized.add(list[i].value);
    }
    _statistics = _normalized.statistics;
  }

  @override
  List<Object?> get props => [list];

  _getSampleStandardDeviation(List<double> list, double sampleMean) {
    double result = 0;

    for (var i = 0; i < list.length; i++) {
      result = pow((list[i] - sampleMean), 2) + result;
    }
    return pow(result / (list.length - 1), .5);
  }

  getStats() {
    return OneVarStatsModel(
        length: _statistics.length,
        sampleMean: _statistics.mean,
        sum: _statistics.sum,
        sumSquared: _statistics.squaresSum,
        sampleStandardDeviation:
            _getSampleStandardDeviation(_normalized, _statistics.mean),
        standardDeviation: _statistics.standardDeviation,
        min: _statistics.min,
        quarterOne: 0,
        median: _statistics.median,
        quarterThree: 0,
        max: _statistics.max);
  }
}
