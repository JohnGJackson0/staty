import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/lists_bloc.dart';
import '../models/list_model.dart';
import 'editable_data_point_view.dart';
import 'form_submission_status.dart';

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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        verticalDirection: VerticalDirection.down,
                        children: <Widget>[
                          const SizedBox(
                              height: 85,
                              child: Flexible(child: EditableDataPoint())),
                          const Padding(
                            padding: EdgeInsets.all(6.0),
                            child: SizedBox(
                                height: 25,
                                child:
                                    Flexible(child: Text('Recently Entered:'))),
                          ),
                          BlocBuilder<ListsBloc, ListsState>(
                            builder: (context, state) {
                              return state.formStatus is FormSubmitting
                                  ? const CircularProgressIndicator()
                                  : filter[0].data.isEmpty
                                      ? const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                              'There is nothing in the list. Add a new data point to see recently entered data here.',
                                              style: TextStyle(
                                                  color: Colors.deepOrange)),
                                        )
                                      : Expanded(
                                          child: Row(
                                            children: [
                                              const Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        top: 4,
                                                        bottom: 4,
                                                        left: 4,
                                                        right: 4),
                                                    child: Flexible(
                                                        child: Icon(Icons
                                                            .data_array_sharp)),
                                                  )),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 4,
                                                          bottom: 4,
                                                          left: 16,
                                                          right: 4),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 110,
                                                              maxHeight: 110),
                                                      child:
                                                          SingleChildScrollView(
                                                        child: Wrap(
                                                            runSpacing: 12.0,
                                                            spacing: 12.0,
                                                            direction:
                                                                Axis.horizontal,
                                                            alignment:
                                                                WrapAlignment
                                                                    .start,
                                                            runAlignment:
                                                                WrapAlignment
                                                                    .start,
                                                            children: filter[0]
                                                                .data
                                                                .reversed
                                                                .map((item) =>
                                                                    DataPointView(
                                                                        item: item
                                                                            .value))
                                                                .toList()),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                            },
                          ),
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

class DataPointView extends StatelessWidget {
  const DataPointView({
    Key? key,
    required this.item,
  }) : super(key: key);

  final double item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ListsBloc>().add(DeleteDataPointSubmitted(point: item));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Wrap(
          children: [
            const Icon(Icons.delete_forever_outlined, color: Colors.red),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Text.rich(
                TextSpan(
                  text: item.toString(),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
