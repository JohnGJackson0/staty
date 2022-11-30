import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_value.dart';
import 'package:staty/lists/calculation/widgets/form_population_standard_deviation.dart';
import 'package:staty/lists/calculation/oneVarZTest/model/one_var_z_test_descriptive_stats.dart';
import 'package:staty/lists/calculation/oneVarZTest/zTestData/services/one_var_z_test_calculator.dart';
import 'package:staty/widgets/no_data_message.dart';

import '../../../../../../model/form_submission_status.dart';
import '../../../../../../widgets/form_submit.dart';
import '../../../../management/model/list_model.dart';
import '../../../widgets/form_hypothesis_equality.dart';
import '../../view/z_test_result.dart';
import '../bloc/z_test_data_bloc.dart';

class OneVarZTestDataForm extends StatefulWidget {
  static const id = 'z_test_one_var_data_form';
  final ListModel list;
  const OneVarZTestDataForm({
    required this.list,
    Key? key,
  }) : super(key: key);

  @override
  State<OneVarZTestDataForm> createState() => _DataFormInputState();
}

class _DataFormInputState extends State<OneVarZTestDataForm> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    OneVarZTestDescriptiveStats stats;

    if (widget.list.data.length > 2) {
      stats = DataZTestCalculator(list: widget.list.data).getZTestStatsModel()
          as OneVarZTestDescriptiveStats;
    } else {
      stats = OneVarZTestDescriptiveStats(length: -1, sampleMean: -1);
    }

    return BlocProvider(
      create: (context) => ZTestDataBloc(),
      child: Scaffold(
        appBar: AppBar(title: Text(widget.list.name)),
        body: BlocListener<ZTestDataBloc, ZTestDataState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              Navigator.pushNamed(context, ZTestResult.id,
                  arguments: ZTestResultScreenParam(
                      populationStandardDeviation:
                          state.populationStandardDeviation,
                      hypothesisValue: state.hypothesisValue,
                      equalityChoice: state.hypothesisEquality,
                      stats: stats));
            }
          },
          child: widget.list.data.length < 2
              ? const NoDataMessage()
              : BlocBuilder<ZTestDataBloc, ZTestDataState>(
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            FormHypothesisValue(onChanged: (value) {
                              context.read<ZTestDataBloc>().add(
                                  OnChangedHypothesisZTestValue(
                                      hypothesisValue: value));
                            }),
                            const Text('\nThe hypothesis statement'),
                            FormHypothesisEquality(onChanged: (value) {
                              context.read<ZTestDataBloc>().add(
                                  OnChangedEqualityZTestValue(
                                      equalityValue: value));
                            }),
                            FormPopulationStandardDeviation(onChanged: (value) {
                              context.read<ZTestDataBloc>().add(
                                  OnChangedPopulationStandardDeviation(
                                      populationStandardDeviation: value));
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
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      context
                                          .read<ZTestDataBloc>()
                                          .add(OnDataFormSubmitted());
                                    },
                                    label: 'Calculate')),
                            state.formStatus is SubmissionFailed
                                ? const Text('error occured')
                                : const SizedBox(width: 20, height: 20)
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
