import 'dart:math';

import 'package:equatable/equatable.dart';
import '../model/one_var_stats_model.dart';

class OneSampleTTestService extends Equatable {
  final OneVarStatsModel oneVarStats;
  final num hypothesisValue;

  const OneSampleTTestService(
      {required this.oneVarStats, required this.hypothesisValue});

  @override
  List<Object?> get props => [oneVarStats];

  calculateTValue() {
    var result = (oneVarStats.sampleMean - hypothesisValue) /
        (oneVarStats.sampleStandardDeviation / pow(oneVarStats.length, .5));

    return result;
  }
}
