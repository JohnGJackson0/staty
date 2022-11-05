import 'package:flutter/material.dart';
import 'package:staty/lists/create_list_view.dart';

import '../home_page.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case CreateList.id:
        return MaterialPageRoute(builder: (_) => const CreateList());
      case HomePage.id:
        return MaterialPageRoute(builder: (_) => const HomePage());
      default:
        return null;
    }
  }
}
