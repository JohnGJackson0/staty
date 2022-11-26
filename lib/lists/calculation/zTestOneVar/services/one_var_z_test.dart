import 'dart:math';
import 'package:equatable/equatable.dart';
import 'package:data/data.dart';
import '../model/z_test_stats_model.dart';

class OneVarZTest extends Equatable {
  final ZTestStatsModel oneVarStats;
  final num hypothesisValue;
  final double populationStandardDeviation;
  final String equalityChoice;

  const OneVarZTest(
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
