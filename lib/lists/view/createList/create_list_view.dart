import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/bloc/lists_bloc.dart';
import '../../model/form_submission_status.dart';
import '../../model/list_model.dart';
import '../widgets/editable_data_point_view.dart';
import '../widgets/recently_entered_data.dart';

class CreateList extends StatelessWidget {
  const CreateList({super.key});
  static const id = 'create_list_screen';

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
            color: Theme.of(context).backgroundColor,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return state.formStatus is SubmissionFailed || filter.isEmpty
                    ? const Text('Something went wrong.')
                    : Column(
                        children: [
                          const SizedBox(
                              height: 85,
                              child: Flexible(child: EditableDataPoint())),
                          Flexible(
                              child: RecentlyEnteredData(list: filter[0].data)),
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
