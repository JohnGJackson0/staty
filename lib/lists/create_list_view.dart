import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/lists_bloc.dart';
import 'editable_data_point_view.dart';

class CreateList extends StatelessWidget {

  const CreateList({super.key});
  static const id = 'create_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List One'),
      ),
      body: Column(
        children: [
          const Flexible(child: EditableDataPoint()),
          const Flexible(child: Text('Data')),
          BlocBuilder<ListsBloc, ListsState>(
            builder: (context, state) {
              return Flexible(
                child: ListView.builder(
                    itemCount: state.lists.length,
                    itemBuilder: (context, index) {
                      final item = state.lists[index];
                      return Text(item.toString());
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
