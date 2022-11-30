import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/oneVarTTest/services/one_var_t_test_calculator.dart';
import '../../model/hypothesis_equality.dart';
import '../../oneVarTTest/model/one_var_t_test_descriptive_stats.dart';
import '../../widgets/calculation.dart';

// shared between data and stats results

class TTestResult extends StatelessWidget {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final OneVarTTestDescriptiveStats stats;

  static const id = 't_test_result_screen';

  const TTestResult({
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
    var result = OneVarTTestCalculator(
        oneVarStats: stats,
        hypothesisValue: hypothesisValue,
        equalityChoice: getEqualityValue());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results of T-Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
        ),
      ),
    );
  }
}
