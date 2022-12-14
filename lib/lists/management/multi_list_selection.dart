import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/management/services/list.dart';
import '../../../widgets/themed_chip.dart';
import 'bloc/lists_bloc.dart';
import 'model/list_model.dart';

class MultiListModelParam {
  final ListModel listOne;
  final ListModel listTwo;
  MultiListModelParam({required this.listOne, required this.listTwo});
}

class MultiListSelection extends StatelessWidget {
  final String idToGoOnFinished;
  const MultiListSelection({super.key, required this.idToGoOnFinished});

  static const id = 'multi_list_selection_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select two lists'),
      ),
      body: Row(
        children: [
          Flexible(
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return state.listStore.length < 2
                    ? const Text('There is not enough lists for the selection.')
                    : Column(children: [
                        (state.selectedListIdOne != '' &&
                                state.selectedListIdTwo != '')
                            ? GestureDetector(
                                onTap: () {
                                  ListModel listOne = getList(
                                      state.listStore, state.selectedListIdOne);

                                  ListModel listTwo = getList(
                                      state.listStore, state.selectedListIdTwo);

                                  Navigator.pushReplacementNamed(
                                      context, idToGoOnFinished,
                                      arguments: MultiListModelParam(
                                          listOne: listOne, listTwo: listTwo));
                                },
                                child: ThemedChip(
                                    avatar: const Icon(Icons.addchart),
                                    color: (Theme.of(context).primaryColor),
                                    label: 'Apply'),
                              )
                            : const SizedBox(height: 0),
                        _ListContent(
                            listStore: state.listStore,
                            navOnFinished: idToGoOnFinished,
                            listOneSelection: state.selectedListIdOne,
                            listTwoSelection: state.selectedListIdTwo)
                      ]);
              },
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ListContent extends StatelessWidget {
  final String listOneSelection;
  final String listTwoSelection;
  final List<ListModel> listStore;
  final String navOnFinished;
  const _ListContent({
    required this.listStore,
    required this.navOnFinished,
    required this.listOneSelection,
    required this.listTwoSelection,
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
                    isListOneSelected: listOneSelection == listStore.uid,
                    isListTwoSelected: listTwoSelection == listStore.uid,
                    listStore: listStore,
                    navOnFinished: navOnFinished,
                  )))
              .toList()
              .toList()),
    );
  }
}

class _ListBodyTile extends StatelessWidget {
  final bool isListOneSelected;
  final bool isListTwoSelected;
  final String navOnFinished;
  final ListModel listStore;
  const _ListBodyTile({
    required this.navOnFinished,
    required this.listStore,
    required this.isListOneSelected,
    required this.isListTwoSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
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
                    !isListOneSelected
                        ? GestureDetector(
                            onTap: () {
                              context
                                  .read<ListsBloc>()
                                  .add(SelectListOneEvent(id: listStore.uid));
                            },
                            child: ThemedChip(
                                avatar: const Icon(Icons.add),
                                color: (Theme.of(context).primaryColor),
                                label: 'Select list one'),
                          )
                        : GestureDetector(
                            onTap: () {
                              context
                                  .read<ListsBloc>()
                                  .add(SelectListOneEvent(id: ''));
                            },
                            child: ThemedChip(
                                avatar: const Icon(Icons.remove),
                                color: (Theme.of(context).errorColor),
                                label: 'Currently selected list one'),
                          ),
                    !isListTwoSelected
                        ? GestureDetector(
                            onTap: () {
                              context
                                  .read<ListsBloc>()
                                  .add(SelectListTwoEvent(id: listStore.uid));
                            },
                            child: ThemedChip(
                                avatar: const Icon(Icons.add),
                                color: (Theme.of(context).primaryColor),
                                label: 'Select list two'))
                        : GestureDetector(
                            onTap: () {
                              context
                                  .read<ListsBloc>()
                                  .add(SelectListTwoEvent(id: ''));
                            },
                            child: ThemedChip(
                                avatar: const Icon(Icons.remove),
                                color: (Theme.of(context).errorColor),
                                label: 'Currently selected list two'),
                          ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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
