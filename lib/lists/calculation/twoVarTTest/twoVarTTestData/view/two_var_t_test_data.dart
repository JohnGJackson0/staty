import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_equality.dart';
import 'package:staty/lists/calculation/widgets/multi_selection_prompt.dart';
import '../../../../management/model/model_exports.dart';
import '../bloc/two_var_t_test_data_bloc.dart';

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
        title: const Text('Two Var T-Test'),
      ),
      body: BlocProvider(
        create: (context) => TwoVarTTestDataBloc(),
        child: Container(
          padding: const EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child: listOne.data.length < 2 || listTwo.data.length < 2
              ? const MultiSelectionPrompt(idToGoOnFinished: TwoVarTTestData.id)
              : Column(
                  children: [
                    Expanded(
                        child: _TwoVarTTestDataView(
                            listOne: listOne.data, listTwo: listTwo.data)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _TwoVarTTestDataView extends StatelessWidget {
  const _TwoVarTTestDataView(
      {Key? key, required this.listOne, required this.listTwo})
      : super(key: key);

  final List<DataPoint> listOne;
  final List<DataPoint> listTwo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('\nThe hypothesis statement'),
        FormHypothesisEquality(onChanged: (value) {
          context
              .read<TwoVarTTestDataBloc>()
              .add(OnChangedEqualityValue(equalityValue: value));
        }),
      ],
    );
  }
}
