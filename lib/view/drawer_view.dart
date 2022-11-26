import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staty/lists/calculation/tTestOneVar/view/one_var_t_test.dart';
import '../lists/calculation/zTestOneVar/view/one_var_z_test.dart';
import '../lists/management/bloc/lists_bloc.dart';
import '../lists/management/view/lists_preview_view.dart';
import '../lists/calculation/oneVarStats/view/one_var_stats.dart';
import '../lists/management/view/select_list.dart';
import '../services/app_router.dart';
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
                  Navigator.pushNamed(
                    context,
                    SelectList.id,
                    arguments: SelectionListParam(OneVarStats.id),
                  );
                },
                child: const ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text('1-Var Stats'),
                )),
            GestureDetector(
                onTap: () {
                  context.read<ListsBloc>().add(SelectedTaskIdEvent(id: ''));
                  Navigator.of(context).pushNamed(OneVarTTest.id);
                },
                child: const ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text('1-Var T Test'),
                )),
            GestureDetector(
                onTap: () {
                  context.read<ListsBloc>().add(SelectedTaskIdEvent(id: ''));
                  Navigator.of(context).pushNamed(OneVarZTest.id);
                },
                child: const ListTile(
                  leading: Icon(Icons.calculate),
                  title: Text('1-Var Z Test'),
                )),
            const ThemeView()
          ],
        ),
      ),
    );
  }
}
