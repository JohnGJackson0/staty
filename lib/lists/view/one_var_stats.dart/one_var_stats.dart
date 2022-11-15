import 'package:flutter/material.dart';
import '../../bloc/bloc_exports.dart';
import '../../model/model_exports.dart';

class OneVarStats extends StatelessWidget {
  const OneVarStats({super.key});
  static const id = 'one_var_stats_screen';

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
            title: filter.isEmpty ? const Text('') : Text(filter[0].name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return filter.isEmpty
                    ? const Text('This list is empty.')
                    : Column(
                        children: [
                          Expanded(
                              child: _OneVarStatsView(list: filter[0].data)),
                        ],
                      );
              },
            ),
          ),
        );
      },
    );
  }
}

class _OneVarStatsView extends StatelessWidget {
  const _OneVarStatsView({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<DataPoint> list;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: const <Widget>[Text('display one var stats ')],
    );
  }
}
