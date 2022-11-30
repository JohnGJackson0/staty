import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';

import '../model/one_var_t_test_descriptive_stats.dart';

class OneVarTTestCalculator extends Equatable {
  final OneVarTTestDescriptiveStats oneVarStats;
  final num hypothesisValue;
  final String equalityChoice;

  const OneVarTTestCalculator(
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
