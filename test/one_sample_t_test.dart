// ignore: depend_on_referenced_packages
import 'package:flutter_test/flutter_test.dart';
import 'package:staty/lists/calculation/tTestOneVar/model/t_test_stats_model.dart';
import 'package:staty/lists/calculation/tTestOneVar/services/one_sample_t_test.dart';
import 'package:staty/lists/calculation/oneVarStats/services/variable_stats.dart';
import 'package:staty/lists/management/model/model_exports.dart';

void main() {
  group('common case p&t values on list', () {
    List<DataPoint> list = [
      const DataPoint(value: 128, id: 'id'),
      const DataPoint(value: 118, id: 'id'),
      const DataPoint(value: 144, id: 'id'),
      const DataPoint(value: 133, id: 'id'),
      const DataPoint(value: 132, id: 'id'),
      const DataPoint(value: 111, id: 'id'),
      const DataPoint(value: 149, id: 'id'),
      const DataPoint(value: 139, id: 'id'),
      const DataPoint(value: 136, id: 'id'),
      const DataPoint(value: 126, id: 'id'),
      const DataPoint(value: 127, id: 'id'),
      const DataPoint(value: 114, id: 'id'),
      const DataPoint(value: 142, id: 'id'),
      const DataPoint(value: 140, id: 'id')
    ];
    // todo use modular service
    var tTestStats =
        OneVarStatsService(list: list).getTTestStatsModel() as TTestStatsModel;

    test('p&t on list less than', () {
      var result = OneSampleTTestService(
          oneVarStats: tTestStats, equalityChoice: '<', hypothesisValue: 120);

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(3.72, closeTo(tValue, .1));
      expect(.99, closeTo(pValue, .01));
    });
    test('p&t on list two tailed', () {
      var result = OneSampleTTestService(
          oneVarStats: tTestStats, equalityChoice: '≠', hypothesisValue: 120);

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(3.72, closeTo(tValue, .1));
      expect(.002, closeTo(pValue, .001));
    });

    test('p&t on list more than', () {
      var result = OneSampleTTestService(
          oneVarStats: tTestStats, equalityChoice: '>', hypothesisValue: 120);

      var tValue = result.calculateTValue();
      var pValue = result.calculatePValue();

      expect(3.72, closeTo(tValue, .1));
      expect(.001, closeTo(pValue, .001));
    });
  });

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
