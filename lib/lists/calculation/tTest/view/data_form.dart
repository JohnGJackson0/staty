import 'package:flutter/material.dart';
import '../../../bloc/bloc_exports.dart';
import '../../../management/model/form_submission_status.dart';
import '../../../management/model/list_model.dart';
import '../../../management/widgets/form_submit.dart';
import '../../model/one_var_stats_model.dart';
import '../../services/variable_stats.dart';
import '../bloc/t_test_bloc_bloc.dart';
import '../widgets/hypothesis_equality_selection.dart';
import '../widgets/hypothesis_value.dart';
import '../widgets/result.dart';

class DataForm extends StatelessWidget {
  const DataForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      verticalDirection: VerticalDirection.down,
      children: const <Widget>[_DataFormInput()],
    );
  }
}

class _DataFormInput extends StatefulWidget {
  const _DataFormInput({
    Key? key,
  }) : super(key: key);

  @override
  State<_DataFormInput> createState() => _DataFormInputState();
}

class _DataFormInputState extends State<_DataFormInput> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListsBloc, ListsState>(
      builder: (context, state) {
        List<ListModel> filter = [];
        filter.addAll(state.listStore);

        filter.retainWhere((e) {
          return e.uid == state.selectedTaskid;
        });
        return BlocBuilder<TTestBlocBloc, TTestBlocState>(
          builder: (context, state) {
            return Form(
              key: formKey,
              child: Column(
                children: [
                  const Text('What was the hypthosis?\n'),
                  const Text('Hypothesis Value or μ0:'),
                  const HypothesisValue(),
                  const Text('\nThe hypothesis statement'),
                  const HypothesisEqualitySelection(),
                  const Text('Selected List:'),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(filter[0].name),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FormSubmit(
                          formKey: formKey,
                          onSubmitEvent: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            context
                                .read<TTestBlocBloc>()
                                .add(HypothesisValueSubmitted());
                          },
                          label: 'Calculate')),
                  state.formStatus is SubmissionSuccess
                      ? BlocBuilder<ListsBloc, ListsState>(
                          builder: (context, listState) {
                            List<ListModel> filter = [];
                            filter.addAll(listState.listStore);

                            filter.retainWhere((e) {
                              return e.uid == listState.selectedTaskid;
                            });

                            var stats = OneVarStatsService(list: filter[0].data)
                                .getStats() as OneVarStatsModel;
                            return Result(
                                    hypothesisValue: state.hypothesisValue,
                                    equalityChoice:
                                        state.submissionData.hypothesisEquality,
                                    stats: stats);
                             
                          },
                        )
                      : const SizedBox(width: 20, height: 20)
                ],
              ),
            );
          },
        );
      },
    );
  }
}
