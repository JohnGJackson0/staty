import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

import '../../../model/form_submission_status.dart';
import '../../bloc/bloc_exports.dart';
import '../model/model_exports.dart';
import '../../../widgets/form_submit.dart';

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
                        .add(NewDataPointInputChangedEvent(point: value));
                  } catch (e) {
                    if (kDebugMode) {
                      print('error');
                    }
                  }
                },
                validator: (value) =>
                    state.isValidDatapointInput() ? null : 'Datapoint invalid',
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
                decoration: InputDecoration(
                  hintStyle: TextStyle(color: Theme.of(context).primaryColor),
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  label: const Text('Enter New Data Point'),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
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
    return BlocBuilder<ListsBloc, ListsState>(builder: (context, state) {
      return FormSubmit(
          formKey: formKey,
          label: 'ADD',
          onSubmitEvent: () => {
                context
                    .read<ListsBloc>()
                    .add(NewDataPointSubmitted(listId: state.selectedTaskid))
              });
    });
  }
}
