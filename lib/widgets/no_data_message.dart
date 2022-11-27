import 'package:flutter/material.dart';

class NoDataMessage extends StatelessWidget {
  const NoDataMessage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('There was not enough data in the list.'),
    );
  }
}
