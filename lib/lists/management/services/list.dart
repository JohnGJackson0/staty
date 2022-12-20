import '../model/list_model.dart';

getList(List<ListModel> listStore, String whereSelectedIdis) {
  List<ListModel> list = [];
  list.addAll(listStore);

  list.retainWhere((e) {
    return e.uid == whereSelectedIdis;
  });

  if (list.isNotEmpty) {
    return list[0];
  }
}
