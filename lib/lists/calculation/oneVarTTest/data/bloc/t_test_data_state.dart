part of 't_test_data_bloc.dart';

class TTestDataBlocState extends Equatable {
  final double hypothesisValue;
  final HypothesisEquality? hypothesisEquality;
  final TTestDataFormSubmission submissionData;
  final FormSubmissionStatus formStatus;

  const TTestDataBlocState(
      {this.submissionData = const TTestDataFormSubmission(),
      this.hypothesisValue = -1,
      this.formStatus = const InitialFormStatus(),
      this.hypothesisEquality = HypothesisEquality.notEqual});

  @override
  List<Object> get props => [hypothesisValue ,submissionData, hypothesisValue];
}

class TTestBlocInitial extends TTestDataBlocState {}
