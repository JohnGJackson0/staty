part of 't_test_bloc_bloc.dart';

abstract class TTestBlocEvent {
  const TTestBlocEvent();
}
class DataFormSubmitted extends TTestBlocEvent {
  DataFormSubmitted();
}

class StatFormSubmitted extends TTestBlocEvent {
  StatFormSubmitted();
}

class OnChangedHypothesisValue extends TTestBlocEvent {
  final String hypothesisValue;
  const OnChangedHypothesisValue({this.hypothesisValue = ''});
}

class OnChangedMeanInput extends TTestBlocEvent {
  final String meanValue;
  const OnChangedMeanInput({this.meanValue = ''});
}

class OnChangedSampleStandardDeviation extends TTestBlocEvent {
  final String sampleStandardDeviation;
  const OnChangedSampleStandardDeviation({this.sampleStandardDeviation = ''});
}

class OnChangedLength extends TTestBlocEvent {
  final String length;
  const OnChangedLength({this.length = ''});
}

class OnChangedEqualityValue extends TTestBlocEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}
