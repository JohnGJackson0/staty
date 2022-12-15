part of 'two_var_t_test_data_bloc.dart';

abstract class TwoVarTTestDataState extends Equatable {
  final TwoVarTTestDataFormSubmission submissionData;
  final FormSubmissionStatus formStatus;
  const TwoVarTTestDataState({
    this.submissionData = const TwoVarTTestDataFormSubmission(),
    this.formStatus = const InitialFormStatus(),
  });

  @override
  List<Object> get props => [submissionData, formStatus];
}

class TwoVarTTestInitial extends TwoVarTTestDataState {}
