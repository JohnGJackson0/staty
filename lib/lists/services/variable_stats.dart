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
    if (list.isEmpty) {
      throw 'No Data';
    }
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

  _isEven(double l) {
    return l % 1 == 0;
  }

  _getQuartileIndex(List<double> list, percent) {
    return (list.length + 1) * (percent);
  }

  _getQuartile(List<double> list, double percent) {
    var index = _getQuartileIndex(list, percent);

    if (_isEven(index)) {
      return list[index.round() - 1];
    } else {
      // TI standard
      if (list.length == 2 && percent <= .5) {
        return list[0];
      }

      if (list.length == 2 && percent >= .5) {
        return list[1];
      }

      if (list.length == 1) {
        return list[0];
      }

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
        quarterOne: _getQuartile(_normalizedSorted, .25),
        median: _statistics.median,
        quarterThree: _getQuartile(_normalizedSorted, .75),
        max: _statistics.max);
  }
}
