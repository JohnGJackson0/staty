import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../services/number.dart';
import '../../../../management/model/form_submission_status.dart';
import '../bloc/t_test_stats_bloc.dart';

class SampleStandardDeviation extends StatefulWidget {
  const SampleStandardDeviation({Key? key}) : super(key: key);

  @override
  State<SampleStandardDeviation> createState() =>
      _SampleStandardDeviationState();
}

class _SampleStandardDeviationState extends State<SampleStandardDeviation> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TTestStatsBloc, TTestStatsState>(
      builder: (context, state) {
        return BlocListener<TTestStatsBloc, TTestStatsState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              _controller.clear();
            }
          },
          child: TextFormField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(
                RegExp(
                  r'^[0-9]*[.]?[0-9]*',
                ),
              ),
            ],
            onChanged: (value) {
              try {
                context.read<TTestStatsBloc>().add(
                    OnChangedSampleStandardDeviation(
                        sampleStandardDeviation: value));
              } catch (e) {
                if (kDebugMode) {
                  print('error');
                }
              }
            },
            decoration: const InputDecoration(
              label: Text('Enter the sample standard deviation Sx'),
            ),
            onFieldSubmitted: (value) => {_controller.clear()},
            validator: (value) =>
                isValidDecimalInput(value) ? null : 'Invalid input',
          ),
        );
      },
    );
  }
}
