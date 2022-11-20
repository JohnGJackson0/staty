import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/tTest/bloc/t_test_bloc_bloc.dart';

import '../../../../services/number.dart';
import '../../../management/model/form_submission_status.dart';

class Length extends StatefulWidget {
  const Length({Key? key}) : super(key: key);

  @override
  State<Length> createState() => _LengthState();
}

class _LengthState extends State<Length> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TTestBlocBloc, TTestBlocState>(
      builder: (context, state) {
        return BlocListener<TTestBlocBloc, TTestBlocState>(
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
                    .read<TTestBlocBloc>()
                    .add(OnChangedLength(length: value));
              } catch (e) {
                if (kDebugMode) {
                  print('error');
                }
              }
            },
            onFieldSubmitted: (value) => {_controller.clear()},
            validator: (value) =>
                isValidDecimalInput(value) ? null : 'Invalid input',
          ),
        );
      },
    );
  }
}
