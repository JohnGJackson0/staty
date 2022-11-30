import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/oneVarTTest/view/list_or_stats_selection.dart';
import 'package:staty/lists/calculation/twoVarTTest/view/two_var_t_test_data.dart';
import '../lists/calculation/model/hypothesis_equality.dart';
import '../lists/calculation/oneVarTTest/model/one_var_t_test_descriptive_stats.dart';
import '../lists/calculation/oneVarTTest/data/view/one_var_t_test_data_form.dart';
import '../lists/calculation/oneVarTTest/view/t_test_result.dart';
import '../lists/calculation/oneVarStats/view/one_var_stats.dart';
import '../lists/calculation/zTestOneVar/view/one_var_z_test.dart';
import '../lists/calculation/zTestOneVar/view/z_test_result.dart';
import '../lists/calculation/zTestOneVar/zTestData/view/z_test_one_var_data_form.dart';
import '../lists/management/view/edit_list_view.dart';
import '../lists/management/view/lists_preview_view.dart';
import '../lists/management/view/select_list.dart';
import '../lists/management/view/create_list_view.dart';

class SelectionListParam {
  final String idToGoOnFinished;
  SelectionListParam(this.idToGoOnFinished);
}

// refactor todo
class ResultScreenParam {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final OneVarTTestDescriptiveStats stats;
  ResultScreenParam({
    required this.hypothesisValue,
    required this.equalityChoice,
    required this.stats,
  });
}

class AppRouter {
  Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateList.id:
        return MaterialPageRoute(builder: (_) => const CreateList());
      case ListsPreview.id:
        return MaterialPageRoute(builder: (_) => const ListsPreview());
      case SelectList.id:
        return MaterialPageRoute(builder: (_) {
          final SelectionListParam args =
              settings.arguments as SelectionListParam;

          return SelectList(idToGoOnFinished: args.idToGoOnFinished);
        });
      case OneVarTTestDataForm.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return OneVarTTestDataForm(list: args.listModel);
        });
      case TwoVarTTestData.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return TwoVarTTestData(list: args.listModel);
        });
      case ZTestOneVarDataForm.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return ZTestOneVarDataForm(list: args.listModel);
        });
      case ZTestResult.id:
        return MaterialPageRoute(builder: (_) {
          final ZTestResultScreenParam args =
              settings.arguments as ZTestResultScreenParam;
          return ZTestResult(
              populationStandardDeviation: args.populationStandardDeviation,
              hypothesisValue: args.hypothesisValue,
              equalityChoice: args.equalityChoice,
              stats: args.stats);
        });
      case TTestResult.id:
        return MaterialPageRoute(builder: (_) {
          final ResultScreenParam args =
              settings.arguments as ResultScreenParam;

          return TTestResult(
              equalityChoice: args.equalityChoice,
              hypothesisValue: args.hypothesisValue,
              stats: args.stats);
        });
      case EditList.id:
        return MaterialPageRoute(builder: (_) => const EditList());
      case ListOrStatsSelection.id:
        return MaterialPageRoute(builder: (_) => const ListOrStatsSelection());
      case OneVarZTest.id:
        return MaterialPageRoute(builder: (_) => const OneVarZTest());
      case OneVarStats.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return OneVarStats(list: args.listModel);
        });

      default:
        return null;
    }
  }
}
