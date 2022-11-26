import 'package:flutter/material.dart';
import '../tTestData/view/t_test_one_var_data_form.dart';
import '../tTestStats/view/stat_form.dart';
import '../../widgets/selection_promt.dart';

class OneVarTTest extends StatelessWidget {
  const OneVarTTest({super.key});
  static const id = 'one_var_t_test_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('1 var T-Test')),
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
        ? const StatForm()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectionPrompt(
                  idToGoOnFinished: TTestOneVarDataForm.id,
                  label:
                      'If you want to calculate T-Test with data then select a list.'),
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
                  child: const Text('T-Test Stats'),
                ),
              )
            ],
          );
  }
}
