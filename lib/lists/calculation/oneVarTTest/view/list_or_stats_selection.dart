import 'package:flutter/material.dart';
import '../data/view/one_var_t_test_data_form.dart';
import '../stats/view/one_var_t_test_stat_form.dart';
import '../../widgets/selection_promt.dart';

class ListOrStatsSelection extends StatelessWidget {
  const ListOrStatsSelection({super.key});
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
        ? const OneVarTTestStatForm()
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SelectionPrompt(
                  idToGoOnFinished: OneVarTTestDataForm.id,
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
