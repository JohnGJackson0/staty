import 'package:flutter/material.dart';

class Calculation extends StatelessWidget {
  const Calculation({Key? key, required this.result, required this.label})
      : super(key: key);

  final String result;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.topLeft,
          child: Text('$label:',
              style: TextStyle(color: Theme.of(context).primaryColor))),
      Align(alignment: Alignment.topLeft, child: Text('$result \n'))
    ]);
  }
}
