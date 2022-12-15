import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class TwoVarTTestDataFormSubmission {
  final HypothesisEquality? hypothesisEquality;

  const TwoVarTTestDataFormSubmission(
      {this.hypothesisEquality = HypothesisEquality.notEqual});
}
