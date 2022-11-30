part of 'z_test_data_bloc.dart';

abstract class ZTestDataEvent {
  const ZTestDataEvent();
}

class OnChangedHypothesisZTestValue extends ZTestDataEvent {
  final String hypothesisValue;
  const OnChangedHypothesisZTestValue({this.hypothesisValue = ''});
}

class OnChangedPopulationStandardDeviation extends ZTestDataEvent {
  final String populationStandardDeviation;
  const OnChangedPopulationStandardDeviation(
      {this.populationStandardDeviation = ''});
}

class OnChangedEqualityZTestValue extends ZTestDataEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityZTestValue({required this.equalityValue});
}

class OnDataFormSubmitted extends ZTestDataEvent {}
