import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:statistics/statistics.dart';

import '../model/data_point.dart';
import '../model/one_var_stats_model.dart';

class OneVarStatsService extends Equatable {
  final List<DataPoint> list;

  final List<double> _normalizedSorted = [];

  late final Statistics _statistics;

  OneVarStatsService({required this.list}) {
    for (var i = 0; i < list.length; i++) {
      _normalizedSorted.add(list[i].value);
    }
    _normalizedSorted.sort();
    _statistics = _normalizedSorted.statistics;
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

  _getLowerQuartileIndex(List<double> list) {
    return (list.length + 1) * (.25);
  }

  _isEven(double l) {
    return l % 1 == 0;
  }

  _getLowerQuartile(List<double> list) {
    var index = _getLowerQuartileIndex(list);

    if (_isEven(index)) {
      return list[_getLowerQuartileIndex(list) as int];
    } else {
      // TI standard
      return (list[index.floor() - 1] + list[index.ceil() - 1]) / 2;
    }
  }

  getStats() {
    return OneVarStatsModel(
        length: _statistics.length,
        sampleMean: _statistics.mean,
        sum: _statistics.sum,
        sumSquared: _statistics.squaresSum,
        sampleStandardDeviation:
            _getSampleStandardDeviation(_normalizedSorted, _statistics.mean),
        standardDeviation: _statistics.standardDeviation,
        min: _statistics.min,
        quarterOne: _getLowerQuartile(_normalizedSorted),
        median: _statistics.median,
        quarterThree: 0,
        max: _statistics.max);
  }
}
