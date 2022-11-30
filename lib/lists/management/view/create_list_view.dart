import 'package:flutter/material.dart';
import '../../calculation/zTestOneVar/zTestData/view/z_test_one_var_data_form.dart';
import '../bloc/lists_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/management/view/select_list.dart';
import '../../../model/form_submission_status.dart';
import '../../calculation/oneVarTTest/data/view/one_var_t_test_data_form.dart';
import '../model/model_exports.dart';
import 'edit_list_view.dart';
import '../../calculation/oneVarStats/view/one_var_stats.dart';
import '../../../widgets/themed_chip.dart';
import '../widgets/widget_exports.dart';

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
              title: filter.isEmpty ? const Text('') : Text(filter[0].name)
          ),
          body: Container(
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
                              child: EditableDataPoint()),
                          SizedBox(
                              height: 175,
                              child: RecentlyEnteredData(list: filter[0].data)),
                          Align(
                            alignment: Alignment.topLeft,
                            child: filter[0].data.isEmpty
                                ? const SizedBox(width: 20)
                                : _Actions(filter: filter),
                          )
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

class _Actions extends StatelessWidget {
  const _Actions({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final List<ListModel> filter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<ListsBloc>()
                  .add(SelectedTaskIdEvent(id: filter[0].uid));
              Navigator.of(context).pushNamed(EditList.id);
            },
            child: ThemedChip(
                avatar: const Icon(Icons.edit),
                color: (Theme.of(context).primaryColor),
                label: 'Edit List'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () {
                context
                    .read<ListsBloc>()
                    .add(SelectedTaskIdEvent(id: filter[0].uid));
                Navigator.pushNamed(
                    context, OneVarStats.id,
                    arguments: ListModelParam(listModel: filter[0]));
              },
              child: ThemedChip(
                  avatar: const Icon(Icons.calculate),
                  color: (Theme.of(context).colorScheme.secondary),
                  label: '1-var stats')),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ZTestOneVarDataForm.id,
                  arguments: ListModelParam(listModel: filter[0]));
            },
            child: ThemedChip(
                avatar: const Icon(Icons.calculate),
                color: (Theme.of(context).colorScheme.secondary),
                label: '1-Var Z-Test'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              context
                  .read<ListsBloc>()
                  .add(SelectedTaskIdEvent(id: filter[0].uid));

              Navigator.pushNamed(context, OneVarTTestDataForm.id,
                  arguments: ListModelParam(listModel: filter[0]));
            },
            child: ThemedChip(
                avatar: const Icon(Icons.calculate),
                color: (Theme.of(context).colorScheme.secondary),
                label: '1-Var T-Test'),
          ),
        )
      ],
    );
  }
}
