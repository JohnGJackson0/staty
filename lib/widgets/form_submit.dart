import 'package:flutter/material.dart';
import '../model/form_submission_status.dart';

class FormSubmit extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String label;
  final Function onSubmitEvent;
  final FormSubmissionStatus formStatus;

  const FormSubmit(
      {Key? key,
      required this.formStatus,
      required this.formKey,
      required this.label,
      required this.onSubmitEvent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return formStatus is FormSubmitting
        ? const CircularProgressIndicator()
        : GestureDetector(
            onTap: () {
              if (formKey.currentState!.validate()) {
                onSubmitEvent();
              }
            },
            child: Text(
                label,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 20),
            ),

    );
  }
}
