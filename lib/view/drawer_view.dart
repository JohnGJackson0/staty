import 'package:flutter/material.dart';

import '../lists/view/listPreview/lists_preview_view.dart';
import '../theme/view/theme_view.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: Column(
          children: [
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                child: const Text('Task Drawer')),
            GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(ListsPreview.id),
                child: const ListTile(
                  leading: Icon(Icons.list),
                  title: Text('View Lists'),
                )),
            const ThemeView()
          ],
        ),
      ),
    );
  }
}
