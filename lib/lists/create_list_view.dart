import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/lists_bloc.dart';
import 'editable_data_point_view.dart';
import 'form_submission_status.dart';

class CreateList extends StatelessWidget {
  const CreateList({super.key});
  static const id = 'create_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List One'),
      ),
      body: Container(
        color: Theme.of(context).backgroundColor,
        padding: const EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            const SizedBox(
                height: 85, child: Flexible(child: EditableDataPoint())),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: SizedBox(
                  height: 25,
                  child: Flexible(child: Text('Recently Entered:'))),
            ),
            BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return state.formStatus is FormSubmitting
                    ? const CircularProgressIndicator()
                    : Expanded(
                        child: Row(
                          children: [
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      top: 4, bottom: 4, left: 4, right: 4),
                                  child: Flexible(
                                      child: Icon(Icons.data_array_sharp)),
                                )),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4, bottom: 4, left: 16, right: 4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minHeight: 110, maxHeight: 110),
                                    child: SingleChildScrollView(
                                      child: Wrap(
                                          runSpacing: 12.0,
                                          spacing: 12.0,
                                          direction: Axis.horizontal,
                                          alignment: WrapAlignment.start,
                                          runAlignment: WrapAlignment.start,
                                          children: state.lists.reversed
                                              .map((item) =>
                                                  DataPoint(item: item))
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
        ),
      ),
    );
  }
}

class DataPoint extends StatelessWidget {
  const DataPoint({
    Key? key,
    required this.item,
  }) : super(key: key);

  final double item;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: item.toString(),
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
