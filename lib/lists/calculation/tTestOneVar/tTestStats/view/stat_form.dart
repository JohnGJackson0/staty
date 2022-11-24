import 'package:flutter/material.dart';
import 'package:staty/lists/bloc/bloc_exports.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_equality.dart';
import 'package:staty/lists/calculation/widgets/form_sample_mean.dart';
import 'package:staty/lists/calculation/widgets/form_sample_standard_deviation.dart';
import '../../../../../services/app_router.dart';
import '../../../../../model/form_submission_status.dart';
import '../../../../../widgets/form_submit.dart';
import '../../../widgets/form_hypothesis_value.dart';
import '../../../widgets/length_degree_of_freedom.dart';
import '../../model/t_test_stats_model.dart';
import '../../view/t_test_result.dart';
import '../bloc/t_test_stats_bloc.dart';

class StatForm extends StatelessWidget {
  const StatForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _StatFormInput();
  }
}

class _StatFormInput extends StatefulWidget {
  const _StatFormInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_StatFormInput> createState() => _StatFormInputState();
}

class _StatFormInputState extends State<_StatFormInput> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<TTestStatsBloc, TTestStatsState>(
      listener: (context, state) {
        if (state.formStatus is SubmissionSuccess) {
          Navigator.pushNamed(context, TTestResult.id,
              arguments: ResultScreenParam(
                  equalityChoice: state.hypothesisEquality,
                  hypothesisValue: state.hypothesisValue,
                  stats: TTestStatsModel(
                      length: state.length,
                      sampleMean: state.sampleMean,
                      sampleStandardDeviation: state.sampleStandardDeviation)));
        }
      },
      child: BlocBuilder<TTestStatsBloc, TTestStatsState>(
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Column(
              children: [
                FormHypothesisValue(onChanged: (value) {
                  context
                      .read<TTestStatsBloc>()
                      .add(OnChangedHypothesisValue(hypothesisValue: value));
                }),
                const Text('\nThe hypothesis statement'),
                FormHypothesisEquality(onChanged: (value) {
                  context
                      .read<TTestStatsBloc>()
                      .add(OnChangedEqualityValue(equalityValue: value));
                }),
                LengthDOF(onChanged: (value) {
                  context
                      .read<TTestStatsBloc>()
                      .add(OnChangedLength(length: value));
                }),
                FormSampleMean(onChanged: (value) {
                  context
                      .read<TTestStatsBloc>()
                      .add(OnChangedMeanInput(meanValue: value));
                }),
                FormSampleStandardDeviation(onChanged: (value) {
                  context.read<TTestStatsBloc>().add(
                      OnChangedSampleStandardDeviation(
                          sampleStandardDeviation: value));
                }),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FormSubmit(
                        formKey: formKey,
                        onSubmitEvent: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          context
                              .read<TTestStatsBloc>()
                              .add(StatFormSubmitted());
                        },
                        label: 'Calculate')),
                state.formStatus is SubmissionFailed
                    ? const Text('Error Occured')
                    : const SizedBox(width: 20, height: 20)
              ],
            ),
          );
        },
      ),
    );
  }
}
