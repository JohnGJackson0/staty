import 'package:equatable/equatable.dart';
import 'package:staty/lists/bloc/bloc_exports.dart';

import '../../../management/model/form_submission_status.dart';
import '../../model/hypothesis_equality.dart';
import '../model/t_test_submission_data.dart';

part 't_test_bloc_event.dart';
part 't_test_bloc_state.dart';

class TTestBlocBloc extends HydratedBloc<TTestBlocEvent, TTestBlocState> {
  TTestBlocBloc() : super(TTestBlocInitial()) {
    on<OnChangedHypothesisValue>(_onHypothesisValueChanged);
    on<OnChangedEqualityValue>(_onChangedEqualityValue);
    on<HypothesisValueSubmitted>(_onHypothesisValueSubmitted);
  }

  void _onHypothesisValueSubmitted(
      HypothesisValueSubmitted event, Emitter<TTestBlocState> emit) {
    emit(TTestBlocState(
        hypothesisValue: state.hypothesisValue,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      emit(TTestBlocState(
          hypothesisValue: double.parse(state.submissionData.hypothesisValue),
          submissionData: TTestSubmissionData(
              hypothesisEquality: state.submissionData.hypothesisEquality),
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(TTestBlocState(
          hypothesisValue: state.hypothesisValue,
          submissionData: TTestSubmissionData(
              hypothesisEquality: state.submissionData.hypothesisEquality),
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onHypothesisValueChanged(
      OnChangedHypothesisValue event, Emitter<TTestBlocState> emit) {
    emit(TTestBlocState(
        submissionData: TTestSubmissionData(
            hypothesisValue: event.hypothesisValue,
            hypothesisEquality: state.submissionData.hypothesisEquality)));
  }

  void _onChangedEqualityValue(
      OnChangedEqualityValue event, Emitter<TTestBlocState> emit) {
    emit(TTestBlocState(
        hypothesisValue: -1,
        submissionData: TTestSubmissionData(
            hypothesisEquality: event.equalityValue,
            hypothesisValue: state.submissionData.hypothesisValue)));
  }

  @override
  TTestBlocState? fromJson(Map<String, dynamic> json) {
    return TTestBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TTestBlocState state) {
    return state.toMap();
  }
}
