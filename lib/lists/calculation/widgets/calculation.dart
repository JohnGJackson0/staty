import 'package:flutter/material.dart';

class Calculation extends StatelessWidget {
  const Calculation({Key? key, required this.result, required this.label})
      : super(key: key);

  final String result;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('$label:',
              style: TextStyle(color: Theme.of(context).primaryColor)),
          Text('$result \n')
        ]);
  }
}
