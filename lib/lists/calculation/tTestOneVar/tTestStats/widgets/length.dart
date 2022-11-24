import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../services/number.dart';
import '../../../../management/model/form_submission_status.dart';
import '../bloc/t_test_stats_bloc.dart';

class Length extends StatefulWidget {
  const Length({Key? key}) : super(key: key);

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
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
            keyboardType: const TextInputType.numberWithOptions(),
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
                    .read<TTestStatsBloc>()
                    .add(OnChangedLength(length: value));
              } catch (e) {
                if (kDebugMode) {
                  print('error');
                }
              }
            },
            decoration: const InputDecoration(
              label: Text('Enter the length of the data set'),
            ),
            onFieldSubmitted: (value) => {_controller.clear()},
            validator: (value) => isValidLengthInputWithDOF(value)
                ? null
                : 'Invalid input (whole number over 1)',
          ),
        );
      },
    );
  }
}
