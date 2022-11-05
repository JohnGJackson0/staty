import 'package:flutter/material.dart';

import '../widgets/editable_data_point.dart';

class CreateList extends StatelessWidget {
  const CreateList({Key? key}) : super(key: key);

  static const id = 'create_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List One'),
      ),
      bottomSheet: const EditableDataPoint(),
    );
  }
}
