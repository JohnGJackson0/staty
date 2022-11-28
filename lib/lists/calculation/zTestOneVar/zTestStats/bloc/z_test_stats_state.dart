part of 'z_test_stats_bloc.dart';

class ZTestStatsState extends Equatable {
  final double hypothesisValue;
  final ZTestStatsFormSubmission submissionData;
  final FormSubmissionStatus formStatus;
  final double length;
  final double populationStandardDeviation;
  final double sampleMean;
  final HypothesisEquality? hypothesisEquality;

  const ZTestStatsState(
      {this.hypothesisValue = -1,
      this.submissionData = const ZTestStatsFormSubmission(),
      this.formStatus = const InitialFormStatus(),
      this.length = -1,
      this.populationStandardDeviation = -1,
      this.sampleMean = -1,
      this.hypothesisEquality = HypothesisEquality.notEqual});

  @override
  List<Object> get props => [
        submissionData,
        hypothesisValue,
        formStatus,
        length,
        populationStandardDeviation,
        sampleMean
      ];
}

class ZTestStatsInitial extends ZTestStatsState {}
