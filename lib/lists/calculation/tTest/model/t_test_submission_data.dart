import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class TTestSubmissionData {
  final String hypothesisValue;
  final HypothesisEquality? hypothesisEquality;

  const TTestSubmissionData(
      {this.hypothesisValue = '',
      this.hypothesisEquality = HypothesisEquality.notEqual});
}
