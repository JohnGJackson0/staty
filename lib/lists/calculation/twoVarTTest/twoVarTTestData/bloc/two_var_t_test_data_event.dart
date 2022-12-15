part of 'two_var_t_test_data_bloc.dart';

abstract class TwoVarTTestDataEvent extends Equatable {
  const TwoVarTTestDataEvent();

  @override
  List<Object> get props => [];
}

class OnChangedEqualityValue extends TwoVarTTestDataEvent {
  final HypothesisEquality? equalityValue;
  const OnChangedEqualityValue({required this.equalityValue});
}

class OnFormSubmitted extends TwoVarTTestDataEvent {}
