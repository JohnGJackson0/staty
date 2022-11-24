import 'package:equatable/equatable.dart';
import 'package:staty/lists/bloc/bloc_exports.dart';
import '../../../../management/model/form_submission_status.dart';
import '../../../model/hypothesis_equality.dart';
import '../model/t_test_submission_data.dart';

part 't_test_stats_event.dart';
part 't_test_stats_state.dart';

class TTestStatsBloc
    extends HydratedBloc<TTestStatsBlocEvent, TTestStatsState> {
  TTestStatsBloc() : super(TTestBlocInitial()) {
    on<OnChangedHypothesisValue>(_onHypothesisValueChanged);
    on<OnChangedEqualityValue>(_onChangedEqualityValue);
    on<OnChangedMeanInput>(_onChangedMeanInput);
    on<OnChangedSampleStandardDeviation>(_onChangedSampleStandardDeviation);
    on<OnChangedLength>(_onChangedLength);
    on<StatFormSubmitted>(_onStatFormSubmited);
  }

  void _onStatFormSubmited(
      StatFormSubmitted event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        hypothesisValue: state.hypothesisValue,
        length: state.length,
        sampleMean: state.sampleMean,
        sampleStandardDeviation: state.sampleStandardDeviation,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      emit(TTestStatsState(
          hypothesisValue: double.parse(state.submissionData.hypothesisValue),
          length: double.parse(state.submissionData.length),
          sampleMean: double.parse(state.submissionData.meanValue),
          hypothesisEquality: state.submissionData.hypothesisEquality,
          sampleStandardDeviation:
              double.parse(state.submissionData.sampleStandardDeviation),
          submissionData: state.submissionData,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(TTestStatsState(
          hypothesisValue: state.hypothesisValue,
          submissionData: const TTestSubmissionData(),
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onChangedLength(OnChangedLength event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        hypothesisValue: -1,
        submissionData: TTestSubmissionData(
            length: event.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  void _onChangedSampleStandardDeviation(
      OnChangedSampleStandardDeviation event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        hypothesisValue: -1,
        submissionData: TTestSubmissionData(
            sampleStandardDeviation: event.sampleStandardDeviation,
            length: state.submissionData.length,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  void _onChangedMeanInput(
      OnChangedMeanInput event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        hypothesisValue: -1,
        submissionData: TTestSubmissionData(
            length: state.submissionData.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            meanValue: event.meanValue)));
  }

  void _onHypothesisValueChanged(
      OnChangedHypothesisValue event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        submissionData: TTestSubmissionData(
            length: state.submissionData.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: event.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  void _onChangedEqualityValue(
      OnChangedEqualityValue event, Emitter<TTestStatsState> emit) {
    emit(TTestStatsState(
        submissionData: TTestSubmissionData(
            length: state.submissionData.length,
            sampleStandardDeviation:
                state.submissionData.sampleStandardDeviation,
            hypothesisEquality: event.equalityValue,
            hypothesisValue: state.submissionData.hypothesisValue,
            meanValue: state.submissionData.meanValue)));
  }

  @override
  TTestStatsState? fromJson(Map<String, dynamic> json) {
    return TTestStatsState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TTestStatsState state) {
    return state.toMap();
  }
}
