import 'package:flutter/material.dart';

import '../../../management/model/model_exports.dart';
import '../../widgets/selection_promt.dart';

class TwoVarTTestData extends StatelessWidget {
  final ListModel list;
  const TwoVarTTestData({super.key, required this.list});
  static const id = 'Two_var_t_test_data_screen';

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title:
              list.data.isEmpty ? const Text('2-var-t-test-data') : Text(list.name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
        child: list.data.isEmpty
            ? const SelectionPrompt(idToGoOnFinished: TwoVarTTestData.id)
            : Column(
                children: [
                  Expanded(
                      child: list.data.isEmpty
                          ? const Text('There is no data in the list')
                          : _TwoVarTTestDataView(list: list.data)),
                ],
            ),
      ),
    );
  }
}

class _TwoVarTTestDataView extends StatelessWidget {
  const _TwoVarTTestDataView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<DataPoint> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text('2 Var T-Test form here \n'),
      ],
    );
  }
}
