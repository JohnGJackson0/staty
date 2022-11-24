import 'package:equatable/equatable.dart';
import 'package:staty/lists/bloc/bloc_exports.dart';
import '../../../../management/model/form_submission_status.dart';
import '../../../model/hypothesis_equality.dart';
import '../model/t_test_submission_data.dart';

part 't_test_data_event.dart';
part 't_test_data_state.dart';

class TTestDataBloc
    extends HydratedBloc<TTestDataBlocEvent, TTestDataBlocState> {
  TTestDataBloc() : super(TTestBlocInitial()) {
    on<OnChangedHypothesisValue>(_onHypothesisValueChanged);
    on<OnChangedEqualityValue>(_onChangedEqualityValue);
    on<DataFormSubmitted>(_onDataFormSubmitted);
  }

  void _onDataFormSubmitted(
      DataFormSubmitted event, Emitter<TTestDataBlocState> emit) {
    emit(TTestDataBlocState(
        hypothesisValue: state.hypothesisValue,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      emit(TTestDataBlocState(
          hypothesisValue: double.parse(state.submissionData.hypothesisValue),
          hypothesisEquality: state.submissionData.hypothesisEquality,
          submissionData: state.submissionData,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(TTestDataBlocState(
          hypothesisValue: state.hypothesisValue,
          submissionData: state.submissionData,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onHypothesisValueChanged(
      OnChangedHypothesisValue event, Emitter<TTestDataBlocState> emit) {
    emit(TTestDataBlocState(
        submissionData: TTestSubmissionData(
            length: state.submissionData.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: event.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  void _onChangedEqualityValue(
      OnChangedEqualityValue event, Emitter<TTestDataBlocState> emit) {
    emit(TTestDataBlocState(
        submissionData: TTestSubmissionData(
            length: state.submissionData.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: event.equalityValue,
            hypothesisValue: state.submissionData.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  @override
  TTestDataBlocState? fromJson(Map<String, dynamic> json) {
    return TTestDataBlocState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TTestDataBlocState state) {
    return state.toMap();
  }
}
