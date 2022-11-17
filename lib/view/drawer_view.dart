import 'package:flutter/material.dart';

import '../lists/bloc/bloc_exports.dart';
import '../lists/view/listPreview/lists_preview_view.dart';
import '../lists/view/one_var_stats.dart/one_var_stats.dart';
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
                child: const Text('Staty Main Directory')),
            GestureDetector(
                onTap: () =>
                    Navigator.of(context).pushReplacementNamed(ListsPreview.id),
                child: const ListTile(
                  leading: Icon(Icons.list),
                  title: Text('View Lists'),
                )),
            GestureDetector(
                onTap: () {
                  context.read<ListsBloc>().add(SelectedTaskIdEvent(id: ''));
                  Navigator.of(context).pushNamed(OneVarStats.id);
                },
                child: const ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text('1-Var Stats'),
                )),
            const ThemeView()
          ],
        ),
      ),
    );
  }
}
