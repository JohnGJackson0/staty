import 'package:flutter/material.dart';
import '../model/hypothesis_equality.dart';

class FormHypothesisEquality extends StatefulWidget {
  final ValueChanged<HypothesisEquality?> onChanged;
  const FormHypothesisEquality({Key? key, required this.onChanged})
      : super(key: key);

  @override
  State<FormHypothesisEquality> createState() => _FormHypothesisEqualityState();
}

class _FormHypothesisEqualityState extends State<FormHypothesisEquality> {
  HypothesisEquality? _equalityChoice = HypothesisEquality.notEqual;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: ListTile(
            title: const Text('≠'),
            leading: Radio(
              value: HypothesisEquality.notEqual,
              groupValue: _equalityChoice,
              onChanged: (HypothesisEquality? value) {
                widget.onChanged(value);
                setState(() {
                  _equalityChoice = value;
                });
              },
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: const Text('<'),
            leading: Radio<HypothesisEquality>(
              value: HypothesisEquality.less,
              groupValue: _equalityChoice,
              onChanged: (HypothesisEquality? value) {
                widget.onChanged(value);
                setState(() {
                  _equalityChoice = value;
                });
              },
            ),
          ),
        ),
        Flexible(
          child: ListTile(
            title: const Text('>'),
            leading: Radio<HypothesisEquality>(
              value: HypothesisEquality.more,
              groupValue: _equalityChoice,
              onChanged: (HypothesisEquality? value) {
                widget.onChanged(value);
                setState(() {
                  _equalityChoice = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
