import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:staty/lists/calculation/twoVarTTest/twoVarTTestData/view/two_var_t_test_data.dart';
import 'package:staty/lists/calculation/oneVarZTest/zTestData/view/one_var_z_test_data_form.dart';
import 'package:staty/lists/management/multi_list_selection.dart';
import 'package:staty/lists/management/view/edit_list_view.dart';
import 'package:staty/lists/calculation/oneVarStats/view/one_var_stats.dart';
import 'package:staty/lists/management/view/select_list.dart';
import 'package:staty/view/drawer_view.dart';
import '../../../services/app_router.dart';
import '../../../services/feature_flags.dart';
import '../bloc/lists_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../calculation/oneVarTTest/data/view/one_var_t_test_data_form.dart';
import '../model/model_exports.dart';
import 'create_list_view.dart';
import '../../../widgets/themed_chip.dart';

class ListsPreview extends StatelessWidget {
  const ListsPreview({super.key});

  static const id = 'lists_preview_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
      ),
      drawer: const DrawerView(),
      body: Row(
        children: [
          Flexible(
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return state.listStore.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                            'You have no lists currently. Either make a list by pressing the + icon or go right to statistics calculations without lists by pressing on the top left icon.',
                            maxLines: 4),
                      )
                    : _ListContent(listStore: state.listStore);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ListsBloc>().add(StatListCreatedEvent());
          Navigator.of(context).pushNamed(CreateList.id);
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class _ListContent extends StatelessWidget {
  final List<ListModel> listStore;
  const _ListContent({
    required this.listStore,
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
                  body: _ListBodyTile(listStore: listStore)))
              .toList()
              .toList()),
    );
  }
}

class _ListBodyTile extends StatelessWidget {
  final ListModel listStore;
  const _ListBodyTile({
    required this.listStore,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              const Align(alignment: Alignment.topLeft, child: Text('Name: ')),
              Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    listStore.name,
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  )),
            ],
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text('Last Edited on: ')),
                Text(
                  DateFormat()
                      .add_yMMMd()
                      .add_Hms()
                      .format(DateTime.parse(listStore.lastEditedDate)),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ListsBloc>()
                          .add(SelectListOneEvent(id: listStore.uid));
                      Navigator.of(context).pushNamed(CreateList.id);
                    },
                    child: ThemedChip(
                        avatar: const Icon(Icons.add),
                        color: (Theme.of(context).primaryColor),
                        label: 'Add To List'),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ListsBloc>()
                          .add(SelectListOneEvent(id: listStore.uid));
                      Navigator.pushNamed(context, EditList.id,
                          arguments: ListModelParam(listModel: listStore));
                    },
                    child: ThemedChip(
                        avatar: const Icon(Icons.edit),
                        color: (Theme.of(context).primaryColor),
                        label: 'Edit List'),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ListsBloc>()
                          .add(SelectListOneEvent(id: listStore.uid));
                      Navigator.pushNamed(context, OneVarStats.id,
                          arguments: ListModelParam(listModel: listStore));
                    },
                    child: ThemedChip(
                        avatar: const Icon(Icons.calculate),
                        color: (Theme.of(context).colorScheme.secondary),
                        label: '1-var stats'),
                  ),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<ListsBloc>()
                          .add(SelectListOneEvent(id: listStore.uid));

                      Navigator.pushNamed(context, OneVarTTestDataForm.id,
                          arguments: ListModelParam(listModel: listStore));
                    },
                    child: ThemedChip(
                        avatar: const Icon(Icons.calculate),
                        color: (Theme.of(context).colorScheme.secondary),
                        label: '1-Var T-Test'),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OneVarZTestDataForm.id,
                          arguments: ListModelParam(listModel: listStore));
                    },
                    child: ThemedChip(
                        avatar: const Icon(Icons.calculate),
                        color: (Theme.of(context).colorScheme.secondary),
                        label: '1-Var Z-Test'),
                  ),
                  twoVarTTest()
                      ? GestureDetector(
                          onTap: () {
                            context
                                .read<ListsBloc>()
                                .add(SelectListOneEvent(id: listStore.uid));
                            context
                                .read<ListsBloc>()
                                .add(SelectListTwoEvent(id: ''));
                            Navigator.pushNamed(context, MultiListSelection.id,
                                arguments:
                                    SelectionListParam(TwoVarTTestData.id));
                          },
                          child: ThemedChip(
                              avatar: const Icon(Icons.calculate),
                              color: (Theme.of(context).colorScheme.secondary),
                              label: '2-Var T-Test'),
                        )
                      : const SizedBox(height: 0),
                ],
              ),
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
            )),
      ],
    );
  }
}
