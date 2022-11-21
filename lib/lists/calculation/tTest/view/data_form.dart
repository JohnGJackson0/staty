import 'package:flutter/material.dart';
import '../../../../services/app_router.dart';
import '../../../bloc/bloc_exports.dart';
import '../../../management/model/form_submission_status.dart';
import '../../../management/model/list_model.dart';
import '../../../management/widgets/form_submit.dart';
import '../../services/variable_stats.dart';
import '../bloc/t_test_bloc_bloc.dart';
import '../model/t_test_stats_model.dart';
import '../widgets/hypothesis_equality_selection.dart';
import '../widgets/hypothesis_value.dart';
import 't_test_result.dart';

class DataForm extends StatelessWidget {
  const DataForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _DataFormInput();
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
        var stats = OneVarStatsService(list: filter[0].data)
            .getTTestStatsModel() as TTestStatsModel;

        return BlocListener<TTestBlocBloc, TTestBlocState>(
          listener: (context, state) {
            if (state.formStatus is SubmissionSuccess) {
              Navigator.pushNamed(context, TTestResult.id,
                  arguments: ResultScreenParam(
                      hypothesisValue: state.hypothesisValue,
                      equalityChoice: state.submissionData.hypothesisEquality,
                      stats: stats));
            }
          },
          child: BlocBuilder<TTestBlocBloc, TTestBlocState>(
            builder: (context, state) {
              return Form(
                key: formKey,
                child: Column(
                  children: [
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
                                  .add(DataFormSubmitted());
                            },
                            label: 'Calculate')),
                    state.formStatus is SubmissionFailed
                        ? const Text('error occured')
                        : const SizedBox(width: 20, height: 20)
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
