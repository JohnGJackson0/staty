import 'package:flutter/material.dart';
import '../../bloc/bloc_exports.dart';
import '../createList/create_list_view.dart';

class ListsPreview extends StatelessWidget {
  const ListsPreview({super.key});

  static const id = 'lists_preview_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lists'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Flexible(
              child: BlocBuilder<ListsBloc, ListsState>(
                builder: (context, state) {
                  return state.listStore.isEmpty
                      ? const Text(
                          'Inferential statistics (like T-test, Z-test, ect.) can have functions that take a list of data or descriptions of the list of data. We only have the latter currently. Please add a list with + icon.',
                          maxLines: 4)
                      : ListView.builder(
                          itemCount: state.listStore.length,
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () {
                                context.read<ListsBloc>().add(
                                    SelectedTaskIdEvent(
                                        id: state.listStore[index].uid));
                                Navigator.of(context).pushNamed(CreateList.id);
                              },
                              child: Column(
                                children: [
                                  ListTile(
                                      leading: const Icon(Icons.list),
                                      title: Text(
                                        state.listStore[index].name,
                                        style: const TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ))
                                ],
                              ),
                            );
                          });
                },
              ),
            ),
          ],
        ),
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
