import 'package:flutter/material.dart';

import '../../bloc/bloc_exports.dart';
import '../../model/model_exports.dart';
import '../../model/one_var_stats_model.dart';
import '../../services/variable_stats.dart';
import '../widgets/selection_promt.dart';

class OneVarStats extends StatelessWidget {
  const OneVarStats({super.key});
  static const id = 'one_var_stats_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        List<ListModel> filter = [];
        filter.addAll(state.listStore);

        filter.retainWhere((e) {
          return e.uid == state.selectedTaskid;
        });
        return Scaffold(
          appBar: AppBar(
            title: filter.isEmpty
                ? const Text('1-var-stats')
                : Text(filter[0].name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return filter.isEmpty
                    ? const SelectionPrompt(idToGoOnFinished: OneVarStats.id)
                    : Column(
                        children: [
                          Expanded(
                              child: filter[0].data.isEmpty
                                  ? const Text('There is no data in the list')
                                  : _OneVarStatsView(list: filter[0].data)),
                        ],
                      );
              },
            ),
          ),
        );
      },
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

class Calculation extends StatelessWidget {
  const Calculation({Key? key, required this.result, required this.label})
      : super(key: key);

  final String result;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('$label:',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          Text('$result \n')
        ]);
  }
}
