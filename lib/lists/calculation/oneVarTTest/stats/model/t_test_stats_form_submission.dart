import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class TTestStatsFormSubmission {
  final String hypothesisValue;
  final HypothesisEquality? hypothesisEquality;
  final String meanValue;
  final String sampleStandardDeviation;
  final String length;

  const TTestStatsFormSubmission(
      {this.hypothesisValue = '',
      this.hypothesisEquality = HypothesisEquality.notEqual,
      this.meanValue = '',
      this.sampleStandardDeviation = '',
      this.length = ''});
}
