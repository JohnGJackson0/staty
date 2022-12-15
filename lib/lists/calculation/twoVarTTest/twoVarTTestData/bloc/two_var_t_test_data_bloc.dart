// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../model/hypothesis_equality.dart';
import '../model/two_var_t_test_data_form_submission.dart';

part 'two_var_t_test_data_event.dart';
part 'two_var_t_test_data_state.dart';

class TwoVarTTestDataBloc
    extends Bloc<TwoVarTTestDataEvent, TwoVarTTestDataState> {
  TwoVarTTestDataBloc() : super(TwoVarTTestInitial()) {
    on<OnChangedEqualityValue>(_onChangedEquityValue);
  }

  _onChangedEquityValue(
      OnChangedEqualityValue event, Emitter<TwoVarTTestDataState> emit) {}
}
