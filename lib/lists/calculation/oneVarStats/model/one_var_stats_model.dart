class OneVarStatsModel {
  final double sampleMean;
  final num sum;
  final num sumSquared;
  final num sampleStandardDeviation;
  final num standardDeviation;
  final num length;
  final num min;
  final num quarterOne;
  final num median;
  final num quarterThree;
  final num max;
  // list must be > 1
  // final double df;

  OneVarStatsModel(
      {required this.sampleMean,
      required this.sum,
      required this.sumSquared,
      required this.sampleStandardDeviation,
      required this.standardDeviation,
      required this.length,
      required this.min,
      required this.quarterOne,
      required this.median,
      required this.quarterThree,
      required this.max});
}
