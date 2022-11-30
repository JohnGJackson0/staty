import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/oneVarZTest/zTestData/view/one_var_z_test_data_form.dart';
import '../../widgets/selection_promt.dart';
import '../zTestStats/view/one_var_z_test_stat_form.dart';

class OneVarZTestSelection extends StatelessWidget {
  const OneVarZTestSelection({super.key});
  static const id = 'one_var_z_test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1 var Z-Test')),
      body: Container(
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: const _ListDataSelection(id: id),
      ),
    );
  }
}

class _ListDataSelection extends StatefulWidget {
  const _ListDataSelection({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<_ListDataSelection> createState() => _ListDataSelectionState();
}

class _ListDataSelectionState extends State<_ListDataSelection> {
  bool statsSelected = false;
  @override
  Widget build(BuildContext context) {
    return statsSelected
        ? const OneVarZTestStatForm()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectionPrompt(
                  idToGoOnFinished: OneVarZTestDataForm.id,
                  label:
                      'If you want to calculate Z-Test with data then select a list.'),
              const Text(
                  'If you want to calculate it without a list then select this option below.'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      statsSelected = true;
                    });
                  },
                  child: const Text('Z-Test Stats'),
                ),
              )
            ],
          );
  }
}
