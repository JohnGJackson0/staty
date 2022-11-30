import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/oneVarZTest/model/one_var_z_test_descriptive_stats.dart';
import 'package:staty/lists/calculation/oneVarZTest/services/one_var_z_test_calculator.dart';
import '../../model/hypothesis_equality.dart';
import '../../widgets/calculation.dart';

class ZTestResultScreenParam {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final OneVarZTestDescriptiveStats stats;
  final double populationStandardDeviation;
  ZTestResultScreenParam(
      {required this.hypothesisValue,
      required this.equalityChoice,
      required this.stats,
      required this.populationStandardDeviation});
}

// shared between data and stats results

class ZTestResult extends StatelessWidget {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final OneVarZTestDescriptiveStats stats;
  final double populationStandardDeviation;

  static const id = 'z_test_result_screen';

  const ZTestResult({
    required this.hypothesisValue,
    required this.equalityChoice,
    required this.stats,
    required this.populationStandardDeviation,
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
    var result = OneVarZTestCalculator(
        oneVarStats: stats,
        hypothesisValue: hypothesisValue,
        equalityChoice: getEqualityValue(),
        populationStandardDeviation: populationStandardDeviation);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results of Z-Test'),
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
                label: 'Z-Statistic Z',
                result: result.calculateZValue().toString()),
            Calculation(
                label: 'P-Statistic P',
                result: result.calculatePValue().toString()),
            Calculation(
                label: 'Sample Mean x̄', result: stats.sampleMean.toString()),
            Calculation(
                label: 'Number of Elements n', result: stats.length.toString())
          ],
        ),
      ),
    );
  }
}
