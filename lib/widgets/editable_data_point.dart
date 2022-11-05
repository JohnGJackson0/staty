import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class EditableDataPoint extends StatefulWidget {
  const EditableDataPoint({
    Key? key,
  }) : super(key: key);

  @override
  State<EditableDataPoint> createState() => _EditableDataPointState();
}

class _EditableDataPointState extends State<EditableDataPoint> {
  final FocusNode _editableDataPointNode = FocusNode();

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
              return GestureDetector(
                onTap: () {/** add to list, clear list */},
                child: Container(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: const Text(
                    "ADD",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ),
                ),
              );
            }
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      tapOutsideBehavior: TapOutsideBehavior.opaqueDismiss,
      config: _buildConfig(context),
      child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextFormField(
            focusNode: _editableDataPointNode,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            autofocus: true,
            minLines: 1,
            maxLines: 1,
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
          )),
    );
  }
}
