import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../../../model/form_submission_status.dart';
import '../../../model/hypothesis_equality.dart';
import '../model/z_test_data_form_submission.dart';

part 'z_test_data_event.dart';
part 'z_test_data_state.dart';

class ZTestDataBloc extends Bloc<ZTestDataEvent, ZTestDataState> {
  ZTestDataBloc() : super(ZTestDataInitial()) {
    on<OnChangedHypothesisZTestValue>(_onHypothesisValueChanged);
    on<OnChangedEqualityZTestValue>(_onChangedEqualityValue);
    on<OnDataFormSubmitted>(_onDataFormSubmitted);
    on<OnChangedPopulationStandardDeviation>(
        _onChangedPopulationStandardDeviation);
  }

  void _onDataFormSubmitted(
      OnDataFormSubmitted event, Emitter<ZTestDataState> emit) {
    emit(ZTestDataState(
        hypothesisValue: state.hypothesisValue,
        submissionData: state.submissionData,
        formStatus: FormSubmitting()));

    try {
      emit(ZTestDataState(
          hypothesisValue: double.parse(state.submissionData.hypothesisValue),
          populationStandardDeviation:
              double.parse(state.submissionData.populationStandardDeviation),
          hypothesisEquality: state.submissionData.hypothesisEquality,
          submissionData: state.submissionData,
          formStatus: SubmissionSuccess()));
    } catch (e) {
      emit(ZTestDataState(
          hypothesisValue: state.hypothesisValue,
          submissionData: state.submissionData,
          formStatus: SubmissionFailed(e)));
    }
  }

  void _onChangedPopulationStandardDeviation(
      OnChangedPopulationStandardDeviation event,
      Emitter<ZTestDataState> emit) {
    emit(ZTestDataState(
        submissionData: ZTestDataFormSubmission(
            populationStandardDeviation: event.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: state.submissionData.hypothesisValue)));
  }

  void _onHypothesisValueChanged(
      OnChangedHypothesisZTestValue event, Emitter<ZTestDataState> emit) {
    emit(ZTestDataState(
        submissionData: ZTestDataFormSubmission(
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: state.submissionData.hypothesisEquality,
            hypothesisValue: event.hypothesisValue)));
  }

  void _onChangedEqualityValue(
      OnChangedEqualityZTestValue event, Emitter<ZTestDataState> emit) {
    emit(ZTestDataState(
        submissionData: ZTestDataFormSubmission(
            populationStandardDeviation:
                state.submissionData.populationStandardDeviation,
            hypothesisEquality: event.equalityValue,
            hypothesisValue: state.submissionData.hypothesisValue)));
  }
}
