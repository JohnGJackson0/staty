part of 'z_test_data_bloc.dart';

class ZTestDataState extends Equatable {
  final HypothesisEquality? hypothesisEquality;
  final double hypothesisValue;
  final double populationStandardDeviation;
  final ZTestDataFormSubmission submissionData;
  final FormSubmissionStatus formStatus;

  const ZTestDataState(
      {this.hypothesisEquality = HypothesisEquality.notEqual,
      this.formStatus = const InitialFormStatus(),
      this.populationStandardDeviation = -1,
      this.hypothesisValue = -1,
      this.submissionData = const ZTestDataFormSubmission()});

  @override
  List<Object> get props => [
        populationStandardDeviation,
        hypothesisValue,
        submissionData,
        formStatus
      ];
}

class ZTestDataInitial extends ZTestDataState {}
