part of 't_test_stats_bloc.dart';

abstract class TTestStatsBlocEvent {
  const TTestStatsBlocEvent();
}

class StatFormSubmitted extends TTestStatsBlocEvent {
  StatFormSubmitted();
}

class OnChangedHypothesisValue extends TTestStatsBlocEvent {
  final String hypothesisValue;
  const OnChangedHypothesisValue({this.hypothesisValue = ''});
}

class OnChangedMeanInput extends TTestStatsBlocEvent {
  final String meanValue;
  const OnChangedMeanInput({this.meanValue = ''});
}

class OnChangedSampleStandardDeviation extends TTestStatsBlocEvent {
  final String sampleStandardDeviation;
  const OnChangedSampleStandardDeviation({this.sampleStandardDeviation = ''});
}

class OnChangedLength extends TTestStatsBlocEvent {
  final String length;
  const OnChangedLength({this.length = ''});
}

class OnChangedEqualityValue extends TTestStatsBlocEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}
