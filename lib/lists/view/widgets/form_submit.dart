import 'package:flutter/material.dart';
import '../../bloc/bloc_exports.dart';
import '../../model/model_exports.dart';

class FormSubmit extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String label;
  final Function onSubmitEvent;

  const FormSubmit(
      {Key? key,
      required this.formKey,
      required this.label,
      required this.onSubmitEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator()
            : GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    onSubmitEvent();
                  }
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 16.0, left: 16.0),
                  child: Text(
                    label,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                ),
              );
      },
    );
  }
}
