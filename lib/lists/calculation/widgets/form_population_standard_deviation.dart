import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:staty/services/number.dart';

class FormPopulationStandardDeviation extends StatefulWidget {
  final ValueChanged<String> onChanged;
  const FormPopulationStandardDeviation({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<FormPopulationStandardDeviation> createState() =>
      _FormPopulationStandardDeviationState();
}

class _FormPopulationStandardDeviationState
    extends State<FormPopulationStandardDeviation> {
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
        label: Text('Enter the population standard deviation σ'),
      ),
      onFieldSubmitted: (value) => {_controller.clear()},
      validator: (value) => isValidDecimalInput(value) ? null : 'Invalid input',
    );
  }
}
