import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../services/number.dart';

class LengthDOF extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const LengthDOF({Key? key, required this.onChanged}) : super(key: key);

  @override
  State<LengthDOF> createState() => _LengthState();
}

class _LengthState extends State<LengthDOF> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          widget.onChanged(value);
        } catch (e) {
          if (kDebugMode) {
            print('error');
          }
        }
      },
      decoration: const InputDecoration(
        label: Text('Enter the length of the data set'),
      ),
      /* 
        Since android and other OS allow submit on keyboard, 
        IOS does not. So if we want to clear input on submit,
        we should manage it through the bloc.
      */

      // onFieldSubmitted: (value) => {_controller.clear()},
      validator: (value) => isValidLengthInputWithDOF(value)
          ? null
          : 'Invalid input (whole number over 1)',
    );
  }
}
