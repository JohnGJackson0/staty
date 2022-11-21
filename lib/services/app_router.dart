import 'package:flutter/material.dart';
import 'package:staty/lists/calculation/tTest/view/t_test_result.dart';
import 'package:staty/lists/calculation/view/one_var_t_test.dart';

import '../lists/calculation/model/hypothesis_equality.dart';
import '../lists/calculation/tTest/model/t_test_stats_model.dart';
import '../lists/calculation/view/one_var_stats.dart';

import '../lists/management/view/edit_list_view.dart';
import '../lists/management/view/lists_preview_view.dart';
import '../lists/management/view/select_list.dart';
import '../lists/management/view/create_list_view.dart';

class SelectionListParam {
  final String idToGoOnFinished;
  SelectionListParam(this.idToGoOnFinished);
}

class ResultScreenParam {
  final double hypothesisValue;
  final HypothesisEquality? equalityChoice;
  final TTestStatsModel stats;
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
      
      case OneVarTTest.id:
        return MaterialPageRoute(builder: (_) => const OneVarTTest());
      case OneVarStats.id:
        return MaterialPageRoute(builder: (_) => const OneVarStats());
      default:
        return null;
    }
  }
}
