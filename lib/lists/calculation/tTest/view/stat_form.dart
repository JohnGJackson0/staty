import 'package:flutter/material.dart';

import '../../../bloc/bloc_exports.dart';
import '../../../management/model/form_submission_status.dart';
import '../../../management/widgets/form_submit.dart';
import '../bloc/t_test_bloc_bloc.dart';
import '../model/t_test_stats_model.dart';
import '../widgets/hypothesis_equality_selection.dart';
import '../widgets/hypothesis_value.dart';
import '../widgets/length.dart';
import '../widgets/mean.dart';
import '../widgets/result.dart';
import '../widgets/sample_standard_deviation.dart';

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
    return BlocBuilder<TTestBlocBloc, TTestBlocState>(
      builder: (context, state) {
        return BlocBuilder<TTestBlocBloc, TTestBlocState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  const Text('What was the hypthosis?\n'),
                  const Text('Hypothesis Value or μ0:'),
                  const HypothesisValue(),
                  const Text('\nThe hypothesis statement'),
                  const HypothesisEqualitySelection(),
                  const Text('Length of data set? \n'),
                  const Length(),
                  const Text('Sample Mean of data set?'),
                  const Mean(),
                  const Text('What is the sample Standard Deviation?'),
                  const SampleStandardDeviation(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormSubmit(
                          formKey: formKey,
                          onSubmitEvent: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            context
                                .read<TTestBlocBloc>()
                                .add(StatFormSubmitted());
                          },
                          label: 'Calculate')),
                  state.formStatus is SubmissionSuccess
                      ? Result(
                          hypothesisValue: state.hypothesisValue,
                          equalityChoice:
                              state.submissionData.hypothesisEquality,
                          stats: TTestStatsModel(
                              length: state.length,
                              sampleMean: state.sampleMean,
                              sampleStandardDeviation:
                                  state.sampleStandardDeviation))
                      : state.formStatus is SubmissionFailed
                          ? const Text('Error Occured')
                          : const SizedBox(width: 20, height: 20)
                ],
              ),
            );
          },
        );
      },
    );
  }
}

