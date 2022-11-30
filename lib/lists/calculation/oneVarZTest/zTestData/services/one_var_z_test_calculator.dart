import 'package:equatable/equatable.dart';
import 'package:statistics/statistics.dart';
import 'package:staty/lists/calculation/oneVarZTest/model/one_var_z_test_descriptive_stats.dart';
import '../../../../management/model/data_point.dart';

class DataZTestCalculator extends Equatable {
  final List<DataPoint> list;

  final List<double> _normalized = [];

  late final Statistics _statistics;

  DataZTestCalculator({required this.list}) {
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
    return OneVarZTestDescriptiveStats(
      sampleMean: _statistics.mean,
      length: _statistics.length,
    );
  }
}
