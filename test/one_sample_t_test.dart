// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:staty/lists/calculation/services/one_sample_t_test.dart';
import 'package:staty/lists/calculation/tTest/model/t_test_stats_model.dart';

void main() {
  group('p & t values on stats', () {
    test('less than', () {
      var result = OneSampleTTestService(
          oneVarStats: TTestStatsModel(
              length: 30, sampleMean: 140, sampleStandardDeviation: 20),
          hypothesisValue: 100,
          equalityChoice: '>');

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(10.95, closeTo(tValue, .1));
      expect(.00000000000401, closeTo(pValue, .000000000001));
    });

    test('more than', () {
      var result = OneSampleTTestService(
          oneVarStats: TTestStatsModel(
              length: 30, sampleMean: 140, sampleStandardDeviation: 20),
          hypothesisValue: 100,
          equalityChoice: '<');

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(10.95, closeTo(tValue, .1));
      expect(1, closeTo(pValue, .00000001));
    });

    test('two tailed', () {
      var result = OneSampleTTestService(
          oneVarStats: TTestStatsModel(
              length: 30, sampleMean: 140, sampleStandardDeviation: 20),
          hypothesisValue: 100,
          equalityChoice: '≠');

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(10.95, closeTo(tValue, .1));
      expect(.00000000000802, closeTo(pValue, .000000000001));
    });
  });
}
