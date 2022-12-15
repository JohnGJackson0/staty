part of 'two_var_t_test_data_bloc.dart';

abstract class TwoVarTTestDataState extends Equatable {
  final TwoVarTTestDataFormSubmission submissionData;
  const TwoVarTTestDataState({
    this.submissionData = const TwoVarTTestDataFormSubmission(),
  });

  @override
  List<Object> get props => [submissionData];
}

class TwoVarTTestInitial extends TwoVarTTestDataState {}
