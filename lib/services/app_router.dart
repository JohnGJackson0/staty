import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/oneVarTTest/view/one_var_t_test_selection.dart';
import 'package:staty/lists/calculation/twoVarTTest/twoVarTTestData/view/two_var_t_test_data.dart';
import '../lists/calculation/model/hypothesis_equality.dart';
import '../lists/calculation/oneVarTTest/model/one_var_t_test_descriptive_stats.dart';
import '../lists/calculation/oneVarTTest/data/view/one_var_t_test_data_form.dart';
import '../lists/calculation/oneVarTTest/view/t_test_result.dart';
import '../lists/calculation/oneVarStats/view/one_var_stats.dart';
import '../lists/calculation/oneVarZTest/view/one_var_z_test_selection.dart';
import '../lists/calculation/oneVarZTest/view/z_test_result.dart';
import '../lists/calculation/oneVarZTest/zTestData/view/one_var_z_test_data_form.dart';
import '../lists/management/multi_list_selection.dart';
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
      case MultiListSelection.id:
        return MaterialPageRoute(builder: (_) {
          final SelectionListParam args =
              settings.arguments as SelectionListParam;

          return MultiListSelection(idToGoOnFinished: args.idToGoOnFinished);
        });
      case OneVarTTestDataForm.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return OneVarTTestDataForm(list: args.listModel);
        });
      case TwoVarTTestData.id:
        return MaterialPageRoute(builder: (_) {
          final MultiListModelParam args =
              settings.arguments as MultiListModelParam;

          return TwoVarTTestData(listOne: args.listOne, listTwo: args.listTwo);
        });
      case OneVarZTestDataForm.id:
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;

          return OneVarZTestDataForm(list: args.listModel);
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
        return MaterialPageRoute(builder: (_) {
          final ListModelParam args = settings.arguments as ListModelParam;
          return EditList(list: args.listModel);
        });
      case OneVarTTestSelection.id:
        return MaterialPageRoute(builder: (_) => const OneVarTTestSelection());
      case OneVarZTestSelection.id:
        return MaterialPageRoute(builder: (_) => const OneVarZTestSelection());
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
