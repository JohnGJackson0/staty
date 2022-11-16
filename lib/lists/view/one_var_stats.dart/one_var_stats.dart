import 'package:flutter/material.dart';
import 'package:staty/lists/view/selectList/select_list.dart';
import '../../../services/app_router.dart';
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
            title: filter.isEmpty
                ? const Text('1-var-stats')
                : Text(filter[0].name),
          ),
          body: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return filter.isEmpty
                    ? const _GetList(id: id)
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

class _GetList extends StatelessWidget {
  const _GetList({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
            'Please select a list with items in it for calculating the 1-var-stats.'),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  SelectList.id,
                  arguments: SelectionListParam(() {
                    Navigator.of(context).pushNamed(OneVarStats.id);
                  }),
                );
              },
              child: const Text('Select List')),
        )
      ],
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
