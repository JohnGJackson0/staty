import 'package:flutter/material.dart';

import '../../../management/model/model_exports.dart';
import '../../widgets/selection_promt.dart';

class TwoVarTTestData extends StatelessWidget {
  final ListModel listOne;
  final ListModel listTwo;

  const TwoVarTTestData(
      {super.key, required this.listOne, required this.listTwo});
  static const id = 'two_var_t_test_data_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: listOne.data.length < 2 || listTwo.data.length < 2
            ? const Text('There is not enough data in one of the lists.')
            : Text(listOne.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: listOne.data.length < 2 || listTwo.data.length < 2
            ? const SelectionPrompt(idToGoOnFinished: TwoVarTTestData.id)
            : Column(
                children: [
                  Expanded(
                      child: listOne.data.length < 2 || listTwo.data.length < 2
                          ? const Text('There is no data in the list')
                          : _TwoVarTTestDataView(
                              listOne: listOne.data, listTwo: listTwo.data)),
                ],
              ),
      ),
    );
  }
}

class _TwoVarTTestDataView extends StatelessWidget {
  const _TwoVarTTestDataView({
    Key? key,
    required this.listOne, required this.listTwo
  }) : super(key: key);

  final List<DataPoint> listOne;
  final List<DataPoint> listTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const <Widget>[
        Text('2 Var T-Test form here \n'),
      ],
    );
  }
}
