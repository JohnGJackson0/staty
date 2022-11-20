part of 't_test_bloc_bloc.dart';

abstract class TTestBlocEvent {
  const TTestBlocEvent();
}
class HypothesisValueSubmitted extends TTestBlocEvent {
  HypothesisValueSubmitted();
}

class OnChangedHypothesisValue extends TTestBlocEvent {
  final String hypothesisValue;
  const OnChangedHypothesisValue({this.hypothesisValue = ''});
}

class OnChangedEqualityValue extends TTestBlocEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}
