import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:statistics/statistics.dart';
import '../../../management/model/data_point.dart';
import '../../tTestOneVar/model/t_test_stats_model.dart';

class OneVarTTest extends Equatable {
  final List<DataPoint> list;

  final List<double> _normalizedSorted = [];

  late final Statistics _statistics;

  OneVarTTest({required this.list}) {
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

  getTTestStatsModel() {
    return TTestStatsModel(
      sampleMean: _statistics.mean,
      sampleStandardDeviation:
          _getSampleStandardDeviation(_normalizedSorted, _statistics.mean),
      length: _statistics.length,
    );
  }
}
