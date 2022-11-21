part of 't_test_bloc_bloc.dart';

class TTestBlocState extends Equatable {
  final double hypothesisValue;
  final TTestSubmissionData submissionData;
  final FormSubmissionStatus formStatus;
  final double length;
  final double sampleStandardDeviation;
  final double sampleMean;
  final HypothesisEquality? hypothesisEquality;

  const TTestBlocState(
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

  factory TTestBlocState.fromMap(Map<String, dynamic> map) {
    return TTestBlocState(hypothesisValue: map['hypothesisValue'] as double);
  }
}

class TTestBlocInitial extends TTestBlocState {}
