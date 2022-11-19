import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staty/lists/calculation/services/one_sample_t_test.dart';
import 'package:staty/lists/calculation/widgets/calculation.dart';

import '../../../services/number.dart';
import '../../bloc/bloc_exports.dart';
import '../../management/model/model_exports.dart';
import '../../management/widgets/form_submit.dart';
import '../model/one_var_stats_model.dart';
import '../services/variable_stats.dart';
import '../widgets/selection_promt.dart';

class OneVarTTest extends StatelessWidget {
  const OneVarTTest({super.key});
  static const id = 'one_var_t_test_screen';

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
                ? const Text('1-var-t-test')
                : Text(filter[0].name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return filter.isEmpty
                    ? const SelectionPrompt(idToGoOnFinished: OneVarTTest.id)
                    : Column(
                        children: [
                          Expanded(
                              child: filter[0].data.isEmpty
                                  ? const Text('There is no data in the list')
                                  : _OneVarTTestView(list: filter[0])),
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

class _OneVarTTestView extends StatelessWidget {
  const _OneVarTTestView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final ListModel list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[_TTestInput(list: list)],
    );
  }
}

class _TTestInput extends StatefulWidget {
  final ListModel list;
  const _TTestInput({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  State<_TTestInput> createState() => _TTestInputState();
}

enum HypothesisEquality { notEqual, less, more }

class _TTestInputState extends State<_TTestInput> {
  HypothesisEquality? _equalityChoice = HypothesisEquality.notEqual;
  final formKey = GlobalKey<FormState>();
  bool _showResult = false;
  TextEditingController hypothesisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        List<ListModel> filter = [];
        filter.addAll(state.listStore);

        filter.retainWhere((e) {
          return e.uid == state.selectedTaskid;
        });
        return Form(
          key: formKey,
          child: Column(
            children: [
              const Text('What was the hypthosis?\n'),
              const Text('Hypothesis Value or μ0:'),
              TextFormField(
                  onTap: () {
                    setState(() {
                      _showResult = false;
                    });
                  },
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(
                        r'^[0-9]*[.]?[0-9]*',
                      ),
                    ),
                  ],
                  controller: hypothesisController,
                  validator: (value) => value != null &&
                          value.isNotEmpty &&
                          isValidDecimalInput(value)
                      ? null
                      : 'Invalid input'),
              const Text('\nThe hypothesis statement'),
              Row(
                children: [
                  Flexible(
                    child: ListTile(
                      title: const Text('≠'),
                      leading: Radio(
                        value: HypothesisEquality.notEqual,
                        groupValue: _equalityChoice,
                        onChanged: (HypothesisEquality? value) {
                          setState(() {
                            _equalityChoice = value;
                            _showResult = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text('<'),
                      leading: Radio<HypothesisEquality>(
                        value: HypothesisEquality.less,
                        groupValue: _equalityChoice,
                        onChanged: (HypothesisEquality? value) {
                          setState(() {
                            _equalityChoice = value;
                            _showResult = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Flexible(
                    child: ListTile(
                      title: const Text('>'),
                      leading: Radio<HypothesisEquality>(
                        value: HypothesisEquality.more,
                        groupValue: _equalityChoice,
                        onChanged: (HypothesisEquality? value) {
                          setState(() {
                            _equalityChoice = value;
                            _showResult = false;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const Text('Selected List:'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(filter[0].name),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FormSubmit(
                    formKey: formKey,
                    onSubmitEvent: () {
                      setState(() {
                        _showResult = true;
                      });
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    onFailEvent: () {
                      setState(() {
                        _showResult = false;
                      });
                    },
                    label: 'Calculate'),
              ),
              _showResult
                  ? _Result(
                      hypothesisValue: double.parse(
                        hypothesisController.text,
                      ),
                      equalityChoice: _equalityChoice)
                  : const SizedBox(width: 20)
            ],
          ),
        );
      },
    );
  }
}

class _Result extends StatelessWidget {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;

  const _Result({
    required this.hypothesisValue,
    required this.equalityChoice,
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
        List<ListModel> filter = [];
        filter.addAll(state.listStore);

        filter.retainWhere((e) {
          return e.uid == state.selectedTaskid;
        });

        var stats = OneVarStatsService(list: filter[0].data).getStats()
            as OneVarStatsModel;

        var result = OneSampleTTestService(
            oneVarStats: stats, hypothesisValue: hypothesisValue);

        return Column(
          children: [
            Calculation(
                label: 'Hypothesis μ',
                result:
                    'μ ${getEqualityValue()} ${hypothesisValue.toString()}'),
            Calculation(
                label: 'T-Statistic T',
                result: result.calculateTValue().toString()),
            const Calculation(label: 'P-Statistic P', result: 'TODO'),
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
