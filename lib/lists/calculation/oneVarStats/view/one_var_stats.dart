import 'package:flutter/material.dart';

import '../../../management/model/model_exports.dart';
import '../model/one_var_stats_model.dart';
import '../services/variable_stats.dart';
import '../../widgets/calculation.dart';
import '../../widgets/selection_promt.dart';

class OneVarStats extends StatelessWidget {
  final ListModel list;
  const OneVarStats({super.key, required this.list});
  static const id = 'one_var_stats_screen';

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title:
              list.data.isEmpty ? const Text('1-var-stats') : Text(list.name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
        child: list.data.isEmpty
            ? const SelectionPrompt(idToGoOnFinished: OneVarStats.id)
            : Column(
                children: [
                  Expanded(
                      child: _OneVarStatsView(list: list.data)),
                ],
            ),
      ),
    );
  }
}

class _OneVarStatsView extends StatelessWidget {
  const _OneVarStatsView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<DataPoint> list;

  @override
  Widget build(BuildContext context) {
    var result = OneVarStatsService(list: list).getStats() as OneVarStatsModel;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        const Text('1 Var Stats: \n'),
        Calculation(result: result.sampleMean.toString(), label: 'Mean x̄'),
        Calculation(result: result.sum.toString(), label: 'Sum Σx'),
        Calculation(
            result: result.sumSquared.toString(), label: 'Sum Squared Σx²'),
        Calculation(
            result: result.sampleStandardDeviation.toString(),
            label: 'Sample Standard Deviation Sx'),
        Calculation(
            result: result.standardDeviation.toString(),
            label: 'Population Standard Deviation σx'),
        Calculation(
            result: result.length.toString(), label: 'Number of elements n'),
        Calculation(result: result.min.toString(), label: 'Min minX'),
        Calculation(
            result: result.quarterOne.toString(), label: 'Quarter 1 Q1'),
        Calculation(result: result.median.toString(), label: 'Median Med'),
        Calculation(
            result: result.quarterThree.toString(), label: 'Quarter 3 Q3'),
        Calculation(result: result.max.toString(), label: 'Max maxX'),
      ],
    );
  }
}
