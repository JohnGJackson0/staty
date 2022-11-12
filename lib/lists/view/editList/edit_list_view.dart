import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../bloc/bloc_exports.dart';
import '../../model/model_exports.dart';

class EditList extends StatelessWidget {
  const EditList({super.key});
  static const id = 'edit_list_screen';

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
            padding: const EdgeInsets.all(20),
            alignment: Alignment.topLeft,
            child: BlocBuilder<ListsBloc, ListsState>(
              builder: (context, state) {
                return state.formStatus is SubmissionFailed || filter.isEmpty
                    ? const Text('Something went wrong.')
                    : Column(
                        children: [
                          Flexible(child: _EditableData(list: filter[0].data)),
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

class _EditableData extends StatelessWidget {
  const _EditableData({
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
      children: <Widget>[
        BlocBuilder<ListsBloc, ListsState>(
          builder: (context, state) {
            return state.formStatus is FormSubmitting
                ? const CircularProgressIndicator()
                : list.isEmpty
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                            'The Data is empty navigate to add to list instead.',
                            style: TextStyle(color: Colors.deepOrange)),
                      )
                    : Expanded(child: _DataPointList(list: list));
          },
        )
      ],
    );
  }
}

class _DataPointList extends StatelessWidget {
  const _DataPointList({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<DataPoint> list;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
            padding:
                const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 4),
            child: Align(
              alignment: Alignment.topLeft,
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) =>
                      _DataPointItem(item: list[index])),
            )));
  }
}

class _DataPointItem extends StatefulWidget {
  const _DataPointItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DataPoint item;

  @override
  State<_DataPointItem> createState() => _DataPointItemState();
}

class _DataPointItemState extends State<_DataPointItem> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
        return Text(widget.item.value.toString());
      }),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
              onTap: () {
                context
                    .read<ListsBloc>()
                    .add(DeleteDataPointSubmitted(point: widget.item.value));
              },
              child: const Icon(Icons.delete_forever, color: Colors.red))
        ],
      ),
    );
  }
}
