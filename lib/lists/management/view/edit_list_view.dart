import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import '../../bloc/bloc_exports.dart';
import '../model/model_exports.dart';
import '../widgets/form_submit.dart';

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
            title: filter.isEmpty
                ? const Text('')
                : _ListHeaderTitle(filter: filter),
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
                          Expanded(child: _EditableData(list: filter[0].data)),
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

class _ListHeaderTitle extends StatefulWidget {
  const _ListHeaderTitle({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final List<ListModel> filter;

  @override
  State<_ListHeaderTitle> createState() => _ListHeaderTitleState();
}

class _ListHeaderTitleState extends State<_ListHeaderTitle> {
  bool _isEditable = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _isEditable
            ? Flexible(
                child: TextFormField(
                  initialValue: widget.filter[0].name,
                  onFieldSubmitted: (input) {
                    setState(() {
                      _isEditable = false;
                    });
                    context
                        .read<ListsBloc>()
                        .add(SubmitNewListNameEvent(newName: input));
                  },
                ),
              )
            : Expanded(
                child: Text(
                  widget.filter[0].name,
                  softWrap: false,
                  maxLines: 1,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
        GestureDetector(
            onTap: () {
              setState(() {
                _isEditable = !_isEditable;
              });
            },
            child: Icon(Icons.edit, color: Theme.of(context).primaryColor))
      ],
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
    return Padding(
        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 16, right: 4),
        child: Align(
          alignment: Alignment.topLeft,
          child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) =>
                  _DataPointItem(item: list[index])),
        ));
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
  final FocusNode _editableDataPointNode = FocusNode();
  final formKey = GlobalKey<FormState>();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Theme.of(context).bottomAppBarColor,
      nextFocus: false,
      actions: [
        KeyboardActionsItem(
          focusNode: _editableDataPointNode,
          toolbarButtons: [
            //button 1
            (node) {
              return GestureDetector(
                onTap: () => node.unfocus(),
                child: Container(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: Text(
                    "DONE",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                ),
              );
            },
            //button 2
            (node) {
              return _SubmitDataPoint(formKey: formKey);
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: Form(
        key: formKey,
        child: ListTile(
          title: BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
            return KeyboardActions(
              config: _buildConfig(context),
              child: TextFormField(
                focusNode: _editableDataPointNode,
                initialValue: widget.item.value.toString(),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) =>
                    state.isValidDatapointInput() ? null : 'Datapoint invalid',
                onChanged: (value) {
                  try {
                    context.read<ListsBloc>().add(
                        ExistingDataPointChangedInputEvent(
                            point: value, id: widget.item.id));
                  } catch (e) {
                    if (kDebugMode) {
                      print('error');
                    }
                  }
                },
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(
                      r'^[0-9]*[.]?[0-9]*',
                    ),
                  ),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    try {
                      final text = newValue.text;
                      if (text.isNotEmpty) double.parse(text);
                      return newValue;
                    } catch (e) {
                      if (kDebugMode) {
                        print('error');
                      }
                    }
                    return oldValue;
                  }),
                ],
              ),
            );
          }),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    context.read<ListsBloc>().add(DeleteDataPointSubmitted(
                        deletedDataPoint: DataPoint(
                            id: widget.item.id, value: widget.item.value)));
                  },
                  child: const Icon(Icons.delete_forever, color: Colors.red))
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitDataPoint extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _SubmitDataPoint({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return FormSubmit(
            formKey: formKey,
            label: 'UPDATE',
            onSubmitEvent: () {
              // add no data submit
              context
                  .read<ListsBloc>()
                  .add(UpdateDataPointSubmitted(listId: state.selectedTaskid));
              Fluttertoast.showToast(
                  msg: "Submitted",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.TOP);
            });
      },
    );
  }
}
