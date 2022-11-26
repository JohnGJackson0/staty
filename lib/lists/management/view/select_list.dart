import 'package:flutter/material.dart';
import '../bloc/lists_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/model_exports.dart';
import '../../../widgets/themed_chip.dart';

class ListModelParam {
  final ListModel listModel;
  ListModelParam({required this.listModel});
}

class SelectList extends StatelessWidget {
  final String idToGoOnFinished;
  const SelectList({super.key, required this.idToGoOnFinished});

  static const id = 'select_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select a List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              child: BlocBuilder<ListsBloc, ListsState>(
                builder: (context, state) {
                  return state.listStore.isEmpty
                      ? const Text('You must make a list to select one.',
                          maxLines: 4)
                      : _ListContent(
                          listStore: state.listStore,
                          navOnFinished: idToGoOnFinished,
                        );
                },
              ),
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ListContent extends StatelessWidget {
  final List<ListModel> listStore;
  final String navOnFinished;
  const _ListContent({
    required this.listStore,
    required this.navOnFinished,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ExpansionPanelList.radio(
          children: listStore
              .map((listStore) => ExpansionPanelRadio(
                  value: listStore.uid,
                  headerBuilder: (context, isOpen) =>
                      _ListHeaderTile(listStore: listStore),
                  body: _ListBodyTile(
                    listStore: listStore,
                    navOnFinished: navOnFinished,
                  )))
              .toList()
              .toList()),
    );
  }
}

class _ListBodyTile extends StatelessWidget {
  final String navOnFinished;
  final ListModel listStore;
  const _ListBodyTile({
    required this.navOnFinished,
    required this.listStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: [
                GestureDetector(
                  onTap: () {
                    context
                        .read<ListsBloc>()
                        .add(SelectedTaskIdEvent(id: listStore.uid));

                    Navigator.pushReplacementNamed(context, navOnFinished,
                        arguments: ListModelParam(listModel: listStore));
                  },
                  child: ThemedChip(
                      avatar: const Icon(Icons.add),
                      color: (Theme.of(context).primaryColor),
                      label: 'Select This list'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ListHeaderTile extends StatelessWidget {
  final ListModel listStore;
  const _ListHeaderTile({
    required this.listStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
            leading: const Icon(Icons.list),
            title: Text(
              listStore.name,
              style: const TextStyle(fontSize: 20),
            ))
      ],
    );
  }
}
