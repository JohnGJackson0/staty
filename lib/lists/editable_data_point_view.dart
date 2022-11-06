import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:staty/lists/lists_bloc.dart';

import 'form_submission_status.dart';

class EditableDataPoint extends StatefulWidget {
  const EditableDataPoint({Key? key}) : super(key: key);

  // cannot place any logic like formKey to createState()
  @override
  State<EditableDataPoint> createState() => _EditableDataPointState();
}

class _EditableDataPointState extends State<EditableDataPoint> {
  final FocusNode _editableDataPointNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
      keyboardBarColor: Colors.grey[200],
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
                  child: const Text(
                    "DONE",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ),
                ),
              );
            },
            //button 2
            (node) {
              return _AddDataPoint(formKey: formKey);
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: BlocBuilder<ListsBloc, ListsState>(
        builder: (context, state) {
          return KeyboardActions(
            tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
            config: _buildConfig(context),
            child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: BlocListener<ListsBloc, ListsState>(
                  listener: (context, state) {
                    if (state.formStatus is SubmissionSuccess) {
                      _controller.clear();
                    }
                  },
                  child: TextFormField(
                    controller: _controller,
                    focusNode: _editableDataPointNode,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    autofocus: true,
                    minLines: 1,
                    maxLines: 1,
                    onChanged: (value) {
                      try {
                        context
                            .read<ListsBloc>()
                            .add(DataPointChangedEvent(point: value));
                      } catch (e) {
                        if (kDebugMode) {
                          print('error');
                        }
                      }
                    },
                    validator: (value) => state.isValidDatapointInput()
                        ? null
                        : 'Datapoint invalid',
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
                    // controller: controller,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.data_array_sharp),
                        label: Text('Enter New Data Point'),
                        border: OutlineInputBorder()),
                  ),
                )),
          );
        },
      ),
    );
  }
}

class _AddDataPoint extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const _AddDataPoint({Key? key, required this.formKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            if (formKey.currentState!.validate()) {
              context.read<ListsBloc>().add(DatapointSubmitted());
            }

            /** add to list, clear data point */
          },
          child: Container(
            padding: const EdgeInsets.only(right: 16.0, left: 16.0),
            child: const Text(
              "ADD",
              style: TextStyle(color: Colors.blueAccent, fontSize: 20),
            ),
          ),
        );
      },
    );
  }
}
