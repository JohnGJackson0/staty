import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/tTestOneVar/model/t_test_stats_model.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_value.dart';

import '../../../../../model/form_submission_status.dart';
import '../../../../../services/app_router.dart';
import '../../../../management/model/model_exports.dart';
import '../../../../../widgets/form_submit.dart';
import '../../../widgets/form_hypothesis_equality.dart';
import '../../services/one_var_t_test.dart';
import '../../view/t_test_result.dart';
import '../bloc/t_test_data_bloc.dart';

// should check widget.filter[0].data.length < 2

class TTestOneVarDataForm extends StatefulWidget {
  static const id = 't_test_one_var_data_form';
  final ListModel list;
  const TTestOneVarDataForm({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  State<TTestOneVarDataForm> createState() => _DataFormInputState();
}

class _DataFormInputState extends State<TTestOneVarDataForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var stats = OneVarTTest(list: widget.list.data).getTTestStatsModel()
        as TTestStatsModel;
    return Scaffold(
      appBar: AppBar(title: Text(widget.list.name)),
      body: BlocListener<TTestDataBloc, TTestDataBlocState>(
        listener: (context, state) {
          if (state.formStatus is SubmissionSuccess) {
            Navigator.pushNamed(context, TTestResult.id,
                arguments: ResultScreenParam(
                    hypothesisValue: state.hypothesisValue,
                    equalityChoice: state.hypothesisEquality,
                    stats: stats));
          }
        },
        child: widget.list.data.length < 2
            ? const Text('Not enough data in the list.')
            : BlocBuilder<TTestDataBloc, TTestDataBlocState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  FormHypothesisValue(onChanged: (value) {
                    context
                        .read<TTestDataBloc>()
                        .add(OnChangedHypothesisValue(hypothesisValue: value));
                  }),
                  const Text('\nThe hypothesis statement'),
                  FormHypothesisEquality(onChanged: (value) {
                    context
                        .read<TTestDataBloc>()
                        .add(OnChangedEqualityValue(equalityValue: value));
                  }),
                  const Text('Selected List:'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(widget.list.name),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormSubmit(
                                formStatus: state.formStatus,
                          formKey: formKey,
                          onSubmitEvent: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            context
                                .read<TTestDataBloc>()
                                .add(DataFormSubmitted());
                          },
                          label: 'Calculate')),
                  state.formStatus is SubmissionFailed
                      ? const Text('error occured')
                      : const SizedBox(width: 20, height: 20)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
