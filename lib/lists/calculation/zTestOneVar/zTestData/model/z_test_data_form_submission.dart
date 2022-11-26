import 'package:staty/lists/calculation/model/hypothesis_equality.dart';

class ZTestDataFormSubmission {
  final String hypothesisValue;
  final HypothesisEquality? hypothesisEquality;
  final String populationStandardDeviation;

  const ZTestDataFormSubmission(
      {this.hypothesisValue = '',
      this.hypothesisEquality = HypothesisEquality.notEqual,
      this.populationStandardDeviation = ''});
}
