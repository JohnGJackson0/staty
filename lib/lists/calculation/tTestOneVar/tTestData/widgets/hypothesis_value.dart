import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/services/number.dart';

import '../../../../management/model/form_submission_status.dart';
import '../bloc/t_test_data_bloc.dart';

class HypothesisValue extends StatefulWidget {
  const HypothesisValue({Key? key}) : super(key: key);

  @override
  State<HypothesisValue> createState() => _HypothesisValueState();
}

class _HypothesisValueState extends State<HypothesisValue> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TTestDataBloc, TTestDataBlocState>(
      builder: (context, state) {
        return BlocListener<TTestDataBloc, TTestDataBlocState>(
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
                context
                    .read<TTestDataBloc>()
                    .add(OnChangedHypothesisValue(hypothesisValue: value));
              } catch (e) {
                if (kDebugMode) {
                  print('error');
                }
              }
            },
            decoration: const InputDecoration(
              label: Text('Enter the hypothesis value μ0'),
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
