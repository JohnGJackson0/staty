import 'package:flutter/material.dart';
import 'package:staty/lists/management/multi_list_selection.dart';
import 'package:staty/services/app_router.dart';

class MultiSelectionPrompt extends StatelessWidget {
  const MultiSelectionPrompt(
      {Key? key,
      required this.idToGoOnFinished,
      this.label = 'A list does not have enough items in it.'})
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
                  MultiListSelection.id,
                  arguments: SelectionListParam(idToGoOnFinished),
                );
              },
              child: const Text('Select Lists')),
        )
      ],
    );
  }
}
