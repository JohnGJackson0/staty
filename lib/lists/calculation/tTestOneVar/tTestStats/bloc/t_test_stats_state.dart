part of 't_test_stats_bloc.dart';

class TTestStatsState extends Equatable {
  final double hypothesisValue;
  final TTestStatsFormSubmission submissionData;
  final FormSubmissionStatus formStatus;
  final double length;
  final double sampleStandardDeviation;
  final double sampleMean;
  final HypothesisEquality? hypothesisEquality;

  const TTestStatsState(
      {this.submissionData = const TTestStatsFormSubmission(),
      this.hypothesisValue = -1,
      this.formStatus = const InitialFormStatus(),
      this.length = -1,
      this.sampleStandardDeviation = -1,
      this.sampleMean = -1,
      this.hypothesisEquality = HypothesisEquality.notEqual});

  @override
  List<Object> get props => [submissionData, hypothesisValue, formStatus, length, sampleStandardDeviation, sampleMean];
}

class TTestBlocInitial extends TTestStatsState {}
