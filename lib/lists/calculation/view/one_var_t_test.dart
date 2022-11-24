import 'package:flutter/material.dart';

import '../../bloc/bloc_exports.dart';
import '../../management/model/model_exports.dart';
import '../tTestOneVar/tTestData/view/data_form.dart';
import '../tTestOneVar/tTestStats/view/stat_form.dart';
import '../widgets/selection_promt.dart';

class OneVarTTest extends StatelessWidget {
  const OneVarTTest({super.key});
  static const id = 'one_var_t_test_screen';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        List<ListModel> filter = [];
        filter.addAll(state.listStore);

        filter.retainWhere((e) {
          return e.uid == state.selectedTaskid;
        });
        return Scaffold(
          appBar: AppBar(
            title: filter.isEmpty
                ? const Text('1 var T-Test')
                : Text(filter[0].name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: _ListDataSelection(filter: filter, id: id),
          ),
        );
      },
    );
  }
}

class _ListDataSelection extends StatefulWidget {
  const _ListDataSelection({
    Key? key,
    required this.filter,
    required this.id,
  }) : super(key: key);

  final List<ListModel> filter;
  final String id;

  @override
  State<_ListDataSelection> createState() => _ListDataSelectionState();
}

class _ListDataSelectionState extends State<_ListDataSelection> {
  bool statsSelected = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return widget.filter.isEmpty
            ? statsSelected
                ? const StatForm()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SelectionPrompt(
                          idToGoOnFinished: OneVarTTest.id,
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
                  )
            : Column(
                children: [
                  Expanded(
                      child: widget.filter[0].data.length < 2
                          ? const Text('There is not enough Data in the list')
                          : const DataForm()),
                ],
              );
      },
    );
  }
}

