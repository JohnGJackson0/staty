import 'package:flutter/material.dart';
import '../../../bloc/bloc_exports.dart';
import '../../model/hypothesis_equality.dart';
import '../../model/one_var_stats_model.dart';
import '../../services/one_sample_t_test.dart';
import '../../widgets/calculation.dart';

// shared between data and stats results

class Result extends StatelessWidget {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final OneVarStatsModel stats;

  const Result({
    required this.hypothesisValue,
    required this.equalityChoice,
    required this.stats,
    Key? key,
  }) : super(key: key);

  getEqualityValue() {
    if (equalityChoice?.index == 0) {
      return '≠';
    } else if (equalityChoice?.index == 1) {
      return '<';
    } else {
      return '>';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        var result = OneSampleTTestService(
            oneVarStats: stats,
            hypothesisValue: hypothesisValue,
            equalityChoice: getEqualityValue());

        return Column(
          children: [
            Calculation(
                label: 'Hypothesis μ',
                result:
                    'μ ${getEqualityValue()} ${hypothesisValue.toString()}'),
            Calculation(
                label: 'T-Statistic T',
                result: result.calculateTValue().toString()),
            Calculation(
                label: 'P-Statistic P',
                result: result.calculatePValue().toString()),
            Calculation(
                label: 'Sample Mean x̄', result: stats.sampleMean.toString()),
            Calculation(
                label: 'Sample Standard Deviation Sx',
                result: stats.sampleStandardDeviation.toString()),
            Calculation(
                label: 'Number of Elements n', result: stats.length.toString())
          ],
        );
      },
    );
  }
}
