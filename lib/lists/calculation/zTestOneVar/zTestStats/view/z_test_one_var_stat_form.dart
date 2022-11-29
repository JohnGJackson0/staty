import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/widgets/form_hypothesis_equality.dart';
import 'package:staty/lists/calculation/widgets/form_sample_mean.dart';
import 'package:staty/lists/calculation/zTestOneVar/model/z_test_stats_model.dart';
import '../../../../../model/form_submission_status.dart';
import '../../../../../widgets/form_submit.dart';
import '../../../widgets/form_hypothesis_value.dart';
import '../../../widgets/form_population_standard_deviation.dart';
import '../../../widgets/length_degree_of_freedom.dart';
import '../../view/z_test_result.dart';
import '../bloc/z_test_stats_bloc.dart';

class ZTestOneVarStatsForm extends StatelessWidget {
  const ZTestOneVarStatsForm({
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
    return BlocProvider(
      create: (context) => ZTestStatsBloc(),
      child: BlocListener<ZTestStatsBloc, ZTestStatsState>(
        listener: (context, state) {
          if (state.formStatus is SubmissionSuccess) {
            Navigator.pushNamed(context, ZTestResult.id,
                arguments: ZTestResultScreenParam(
                    equalityChoice: state.hypothesisEquality,
                    hypothesisValue: state.hypothesisValue,
                    stats: ZTestStatsModel(
                        length: state.length, sampleMean: state.sampleMean),
                    populationStandardDeviation:
                        state.populationStandardDeviation));
          }
        },
        child: BlocBuilder<ZTestStatsBloc, ZTestStatsState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  FormHypothesisValue(onChanged: (value) {
                    context
                        .read<ZTestStatsBloc>()
                        .add(OnChangedHypothesisValue(hypothesisValue: value));
                  }),
                  const Text('\nThe hypothesis statement'),
                  FormHypothesisEquality(onChanged: (value) {
                    context
                        .read<ZTestStatsBloc>()
                        .add(OnChangedEqualityValue(equalityValue: value));
                  }),
                  LengthDOF(onChanged: (value) {
                    context
                        .read<ZTestStatsBloc>()
                        .add(OnChangedLength(length: value));
                  }),
                  FormSampleMean(onChanged: (value) {
                    context
                        .read<ZTestStatsBloc>()
                        .add(OnChangedSampleMean(sampleMean: value));
                  }),
                  FormPopulationStandardDeviation(onChanged: (value) {
                    context.read<ZTestStatsBloc>().add(
                        OnChangedPopulationStandardDeviation(
                            populationStandardDeviation: value));
                  }),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormSubmit(
                          formStatus: state.formStatus,
                          formKey: formKey,
                          onSubmitEvent: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            context
                                .read<ZTestStatsBloc>()
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
      ),
    );
  }
}
