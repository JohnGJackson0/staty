import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_equality.dart';
import 'package:staty/lists/calculation/widgets/multi_selection_prompt.dart';
import '../../../../../widgets/form_submit.dart';
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
          alignment: Alignment.topLeft,
          child: listOne.data.length < 2 || listTwo.data.length < 2
              ? const MultiSelectionPrompt(idToGoOnFinished: TwoVarTTestData.id)
              : Column(
                  children: [
                    Expanded(
                        child: _TwoVarTTestDataView(
                            listOne: listOne, listTwo: listTwo)),
                  ],
                ),
        ),
      ),
    );
  }
}

class _TwoVarTTestDataView extends StatefulWidget {
  const _TwoVarTTestDataView(
      {Key? key, required this.listOne, required this.listTwo})
      : super(key: key);

  final ListModel listOne;
  final ListModel listTwo;

  @override
  State<_TwoVarTTestDataView> createState() => _TwoVarTTestDataViewState();
}

class _TwoVarTTestDataViewState extends State<_TwoVarTTestDataView> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TwoVarTTestDataBloc, TwoVarTTestDataState>(
      builder: (context, state) {
        return Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              const Text('\nThe hypothesis statement'),
              FormHypothesisEquality(onChanged: (value) {
                context
                    .read<TwoVarTTestDataBloc>()
                    .add(OnChangedEqualityValue(equalityValue: value));
              }),
              const Text('Selected List One:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.listOne.name),
              ),
              const Text('Selected List Two:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.listTwo.name),
              ),
              FormSubmit(
                  formStatus: state.formStatus,
                  formKey: formKey,
                  onSubmitEvent: () {
                    // submit event here

                    //context.read<TTestStatsBloc>().add(StatFormSubmitted());
                  },
                  label: 'Calculate'),
            ],
          ),
        );
      },
    );
  }
}
