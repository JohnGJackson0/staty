import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staty/services/number.dart';

class FormHypothesisValue extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const FormHypothesisValue({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<FormHypothesisValue> createState() => _FormHypothesisValueState();
}

class _FormHypothesisValueState extends State<FormHypothesisValue> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
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
          widget.onChanged(value);
        } catch (e) {
          if (kDebugMode) {
            print('error');
          }
        }
      },
      decoration: const InputDecoration(
        label: Text('Enter the hypothesis value μ0'),
      ),
      /* 
        Since android and other OS allow submit on keyboard, 
        IOS does not. So if we want to clear input on submit,
        we should manage it through the bloc.
      */
      
      // onFieldSubmitted: (value) => {_controller.clear()},
      validator: (value) => isValidDecimalInput(value) ? null : 'Invalid input',
    );
  }
}
