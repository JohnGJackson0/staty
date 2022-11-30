import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';
import '../model/one_var_z_test_descriptive_stats.dart';

class OneVarZTestCalculator extends Equatable {
  final OneVarZTestDescriptiveStats oneVarStats;
  final num hypothesisValue;
  final double populationStandardDeviation;
  final String equalityChoice;

  const OneVarZTestCalculator(
      {required this.oneVarStats,
      required this.equalityChoice,
      required this.populationStandardDeviation,
      required this.hypothesisValue});

  @override
  List<Object?> get props => [oneVarStats, equalityChoice, hypothesisValue];

  calculateZValue() {
    return (oneVarStats.sampleMean - hypothesisValue) /
        (populationStandardDeviation / pow(oneVarStats.length, .5));
  }

  calculatePValue() {
    var tdis = const NormalDistribution.standard();
    var cdfT = tdis.cumulativeProbability(calculateZValue());
    if (equalityChoice == '<') {
      return cdfT;
    } else if (equalityChoice == '>') {
      return 1 - cdfT;
    }
    return 2 * min(cdfT, 1 - cdfT);
  }
}
