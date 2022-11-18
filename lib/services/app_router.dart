import 'package:flutter/material.dart';
import 'package:staty/lists/view/createList/create_list_view.dart';
import 'package:staty/lists/view/one_var_stats.dart/one_var_stats.dart';

import '../lists/view/editList/edit_list_view.dart';
import '../lists/view/listPreview/lists_preview_view.dart';
import '../lists/view/selectList/select_list.dart';

class SelectionListParam {
  final String idToGoOnFinished;
  SelectionListParam(this.idToGoOnFinished);
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
    
      case EditList.id:
        return MaterialPageRoute(builder: (_) => const EditList());
      case OneVarStats.id:
        return MaterialPageRoute(builder: (_) => const OneVarStats());
      default:
        return null;
    }
  }
}
