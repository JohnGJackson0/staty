import 'package:flutter_test/flutter_test.dart';
import 'package:staty/lists/calculation/oneVarTTest/model/one_var_t_test_descriptive_stats.dart';
import 'package:staty/lists/calculation/oneVarTTest/services/one_var_t_test_descriptive_stats_calculator.dart';
import 'package:staty/lists/management/model/model_exports.dart';

void main() {
  group('common case ttest descriptive stats', () {
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
    var tTestStats = TTestDescriptiveStatsCalculator(list: list)
        .getTTestStatsModel() as OneVarTTestDescriptiveStats;

    test('p&t on list less than', () {
      expect(tTestStats.sampleMean, closeTo(131.36, .1));
      expect(tTestStats.sampleStandardDeviation, closeTo(11.41, .1));
      expect(tTestStats.length, 14);
    });
  });
}
