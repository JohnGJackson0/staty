part of 't_test_data_bloc.dart';

abstract class TTestDataBlocEvent {
  const TTestDataBlocEvent();
}

class DataFormSubmitted extends TTestDataBlocEvent {
  DataFormSubmitted();
}

class OnChangedHypothesisValue extends TTestDataBlocEvent {
  final String hypothesisValue;
  const OnChangedHypothesisValue({this.hypothesisValue = ''});
}

class OnChangedEqualityValue extends TTestDataBlocEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}
