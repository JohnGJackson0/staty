import 'package:equatable/equatable.dart';
import 'package:statistics/statistics.dart';
import 'package:staty/lists/calculation/zTestOneVar/model/z_test_stats_model.dart';
import '../../../../management/model/data_point.dart';

class DataZTestVariables extends Equatable {
  final List<DataPoint> list;

  final List<double> _normalized = [];

  late final Statistics _statistics;

  DataZTestVariables({required this.list}) {
    if (list.isEmpty) {
      throw 'No Data';
    }
    for (var i = 0; i < list.length; i++) {
      _normalized.add(list[i].value);
    }
    _statistics = _normalized.statistics;
  }

  @override
  List<Object?> get props => [list];

  getZTestStatsModel() {
    return ZTestStatsModel(
      sampleMean: _statistics.mean,
      sampleStandardDeviation: _statistics.standardDeviation,
      length: _statistics.length,
    );
  }
}
