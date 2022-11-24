part of 't_test_data_bloc.dart';

class TTestDataBlocState extends Equatable {
  final double hypothesisValue;
  final TTestSubmissionData submissionData;
  final FormSubmissionStatus formStatus;
  final double length;
  final double sampleStandardDeviation;
  final double sampleMean;
  final HypothesisEquality? hypothesisEquality;

  const TTestDataBlocState(
      {this.submissionData = const TTestSubmissionData(),
      this.hypothesisValue = -1,
      this.formStatus = const InitialFormStatus(),
      this.length = -1,
      this.sampleStandardDeviation = -1,
      this.sampleMean = -1,
      this.hypothesisEquality = HypothesisEquality.notEqual});

  @override
  List<Object> get props => [submissionData, hypothesisValue];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'hypothesisValue': hypothesisValue};
  }

  factory TTestDataBlocState.fromMap(Map<String, dynamic> map) {
    return TTestDataBlocState(
        hypothesisValue: map['hypothesisValue'] as double);
  }
}

class TTestBlocInitial extends TTestDataBlocState {}
