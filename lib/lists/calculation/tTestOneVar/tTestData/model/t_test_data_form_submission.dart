import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class TTestDataFormSubmission {
  final String hypothesisValue;
  final HypothesisEquality? hypothesisEquality;

  const TTestDataFormSubmission(
      {this.hypothesisValue = '',
      this.hypothesisEquality = HypothesisEquality.notEqual});
}
