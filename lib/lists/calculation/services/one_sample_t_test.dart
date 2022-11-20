import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';

import '../tTest/model/t_test_stats_model.dart';

class OneSampleTTestService extends Equatable {
  final TTestStatsModel oneVarStats;
  final num hypothesisValue;
  final String equalityChoice;

  const OneSampleTTestService(
      {required this.oneVarStats,
      required this.equalityChoice,
      required this.hypothesisValue});

  @override
  List<Object?> get props => [oneVarStats, equalityChoice, hypothesisValue];

  calculateTValue() {
    return (oneVarStats.sampleMean - hypothesisValue) /
        (oneVarStats.sampleStandardDeviation / pow(oneVarStats.length, .5));
  }

  calculatePValue() {
    var tdis = StudentDistribution(oneVarStats.length - 1);
    var cdfT = tdis.cumulativeProbability(calculateTValue());
    if (equalityChoice == '<') {
      return cdfT;
    } else if (equalityChoice == '>') {
      return 1 - cdfT;
    }
    return 2 * min(cdfT, 1 - cdfT);
  }
}
