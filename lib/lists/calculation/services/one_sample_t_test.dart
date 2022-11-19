import 'dart:math';
import 'package:equatable/equatable.dart';
import '../model/one_var_stats_model.dart';
import 'package:data/data.dart';

class OneSampleTTestService extends Equatable {
  final OneVarStatsModel oneVarStats;
  final num hypothesisValue;
  final String equalityChoice;

  const OneSampleTTestService(
      {required this.oneVarStats,
      required this.equalityChoice,
      required this.hypothesisValue});

  @override
  List<Object?> get props => [oneVarStats];

  calculateTValue() {
    return (oneVarStats.sampleMean - hypothesisValue) /
        (oneVarStats.sampleStandardDeviation / pow(oneVarStats.length, .5));
  }

  calculatePValue() {
    var nml = StudentDistribution(oneVarStats.df);
    if (equalityChoice == '<') {
      return nml.cumulativeProbability(calculateTValue());
    }
    return 0;
  }
}
