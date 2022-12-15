// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../model/form_submission_status.dart';
import '../../../model/hypothesis_equality.dart';
import '../model/two_var_t_test_data_form_submission.dart';

part 'two_var_t_test_data_event.dart';
part 'two_var_t_test_data_state.dart';

class TwoVarTTestDataBloc
    extends Bloc<TwoVarTTestDataEvent, TwoVarTTestDataState> {
  TwoVarTTestDataBloc() : super(TwoVarTTestInitial()) {
    on<OnChangedEqualityValue>(_onChangedEquityValue);
    on<OnFormSubmitted>(_onFormSubmitted);
  }

  void _onFormSubmitted(
      OnFormSubmitted event, Emitter<TwoVarTTestDataState> emit) {
    // TODO: implement _onFormSubmitted
  }

  _onChangedEquityValue(
      OnChangedEqualityValue event, Emitter<TwoVarTTestDataState> emit) {
    // TODO: implement _onChangedEquityValue
  }
}
