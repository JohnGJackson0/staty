import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class ZTestStatsFormSubmission {
  final String hypothesisValue;
  final HypothesisEquality? hypothesisEquality;
  final String sampleMean;
  final String populationStandardDeviation;
  final String length;

  const ZTestStatsFormSubmission(
      {this.hypothesisValue = '',
      this.hypothesisEquality = HypothesisEquality.notEqual,
      this.sampleMean = '',
      this.populationStandardDeviation = '',
      this.length = ''});
}
