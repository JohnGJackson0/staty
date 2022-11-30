part of 'z_test_stats_bloc.dart';

abstract class ZTestStatsEvent {
  const ZTestStatsEvent();
}

class StatFormSubmitted extends ZTestStatsEvent {}

class OnChangedHypothesisValue extends ZTestStatsEvent {
  final String hypothesisValue;
  const OnChangedHypothesisValue({this.hypothesisValue = ''});
}

class OnChangedEqualityValue extends ZTestStatsEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}

class OnChangedPopulationStandardDeviation extends ZTestStatsEvent {
  final String populationStandardDeviation;

  OnChangedPopulationStandardDeviation(
      {required this.populationStandardDeviation});
}

class OnChangedSampleMean extends ZTestStatsEvent {
  final String sampleMean;
  const OnChangedSampleMean({this.sampleMean = ''});
}

class OnChangedLength extends ZTestStatsEvent {
  final String length;
  const OnChangedLength({this.length = ''});
}
