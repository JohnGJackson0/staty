import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../model/form_submission_status.dart';
import '../../../model/hypothesis_equality.dart';
import '../model/z_test_stats_form_submission.dart';

part 'z_test_stats_event.dart';
part 'z_test_stats_state.dart';

class ZTestStatsBloc extends Bloc<ZTestStatsEvent, ZTestStatsState> {
  ZTestStatsBloc() : super(ZTestStatsInitial()) {
    on<OnChangedHypothesisValue>(_onHypothesisValueChanged);
    on<OnChangedEqualityValue>(_onChangedEqualityValue);
    on<OnChangedSampleMean>(_onChangedSampleMean);
    on<OnChangedLength>(_onChangedLength);
    on<OnChangedPopulationStandardDeviation>(
        _onChangedPopulationStandardDeviation);
    on<StatFormSubmitted>(_onStatFormSubmitted);
  }

  void _onStatFormSubmitted(
      StatFormSubmitted event, Emitter<ZTestStatsState> emit) {
    emit(ZTestStatsState(
        hypothesisValue: state.hypothesisValue,
        length: state.length,
        sampleMean: state.sampleMean,
        populationStandardDeviation: state.populationStandardDeviation,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      emit(ZTestStatsState(
          hypothesisValue: double.parse(state.submissionData.hypothesisValue),
          length: double.parse(state.submissionData.length),
          sampleMean: double.parse(state.submissionData.sampleMean),
          hypothesisEquality: state.submissionData.hypothesisEquality,
          populationStandardDeviation:
              double.parse(state.submissionData.populationStandardDeviation),
          submissionData: state.submissionData,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ZTestStatsState(
          hypothesisValue: state.hypothesisValue,
          submissionData: const ZTestStatsFormSubmission(),
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onChangedPopulationStandardDeviation(
      OnChangedPopulationStandardDeviation event,
      Emitter<ZTestStatsState> emit) {
    emit(ZTestStatsState(
        submissionData: ZTestStatsFormSubmission(
            length: state.submissionData.length,
            populationStandardDeviation: event.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            sampleMean: state.submissionData.sampleMean)));
  }

  void _onChangedLength(OnChangedLength event, Emitter<ZTestStatsState> emit) {
    emit(ZTestStatsState(
        submissionData: ZTestStatsFormSubmission(
            length: event.length,
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            sampleMean: state.submissionData.sampleMean)));
  }

  void _onChangedSampleMean(
      OnChangedSampleMean event, Emitter<ZTestStatsState> emit) {
    emit(ZTestStatsState(
        submissionData: ZTestStatsFormSubmission(
            length: state.submissionData.length,
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue,
            sampleMean: event.sampleMean)));
  }

  void _onChangedEqualityValue(
      OnChangedEqualityValue event, Emitter<ZTestStatsState> emit) {
    emit(ZTestStatsState(
        submissionData: ZTestStatsFormSubmission(
            length: state.submissionData.length,
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: event.equalityValue,
            hypothesisValue: state.submissionData.hypothesisValue,
            sampleMean: state.submissionData.sampleMean)));
  }

  // todo fix naming on events, bloc functions
  void _onHypothesisValueChanged(
      OnChangedHypothesisValue event, Emitter<ZTestStatsState> emit) {
    // todo check blocs through whole app
    emit(ZTestStatsState(
        submissionData: ZTestStatsFormSubmission(
            length: state.submissionData.length,
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: event.hypothesisValue,
            sampleMean: state.submissionData.sampleMean)));
  }
}
