import 'package:flutter/material.dart';
import '../../../services/app_router.dart';
import '../../management/view/select_list.dart';

class SelectionPrompt extends StatelessWidget {
  const SelectionPrompt(
      {Key? key,
      required this.idToGoOnFinished,
      this.label = 'Please select a list with items in it.'})
      : super(key: key);
  final String idToGoOnFinished;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(
                  context,
                  SelectList.id,
                  arguments: SelectionListParam(idToGoOnFinished),
                );
              },
              child: const Text('Select List')),
        )
      ],
    );
  }
}
