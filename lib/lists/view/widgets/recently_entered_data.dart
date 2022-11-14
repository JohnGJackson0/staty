import 'package:flutter/material.dart';
import '../../bloc/bloc_exports.dart';
import '../../model/model_exports.dart';

class RecentlyEnteredData extends StatelessWidget {
  const RecentlyEnteredData({
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
        const Padding(
          padding: EdgeInsets.all(6.0),
          child: SizedBox(
              height: 25, child: Text('Recently Entered:')),
        ),
        BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : list.isEmpty
                ? const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        'There is nothing in the list. Add a new data point to see recently entered data here.',
                        style: TextStyle(color: Colors.deepOrange)),
                  )
                    : Row(
                      children: [
                        const Align(
                            alignment: Alignment.topLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 4, right: 4),
                              child:
                                  Icon(Icons.data_array_sharp),
                            )),
                            _DataPointList(list: list),
                          ],
                        
                      );
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
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 4),
        child: Align(
          alignment: Alignment.topLeft,
          child: Container(
            // has to maintain cutoff size for datapoint
            constraints: const BoxConstraints(minHeight: 110, maxHeight: 110),
            child: SingleChildScrollView(
              child: Wrap(
                  runSpacing: 12.0,
                  spacing: 12.0,
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.start,
                  runAlignment: WrapAlignment.start,
                  children: list.reversed
                      .map((item) => _DataPoint(item: item))
                      .toList()),
            ),
          ),
        ),
      ),
    );
  }
}

class _DataPoint extends StatelessWidget {
  const _DataPoint({
    Key? key,
    required this.item,
  }) : super(key: key);

  final DataPoint item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context
            .read<ListsBloc>()
            .add(DeleteDataPointSubmitted(
            deletedDataPoint: DataPoint(value: item.value, id: item.id)));
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
                  text: item.value.toString(),
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
