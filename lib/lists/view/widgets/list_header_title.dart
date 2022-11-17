import 'package:flutter/material.dart';

import '../../bloc/bloc_exports.dart';
import '../../model/list_model.dart';

class ListHeaderTitle extends StatefulWidget {
  const ListHeaderTitle({
    Key? key,
    required this.filter,
  }) : super(key: key);

  final List<ListModel> filter;

  @override
  State<ListHeaderTitle> createState() => _ListHeaderTitleState();
}

class _ListHeaderTitleState extends State<ListHeaderTitle> {
  bool _isEditable = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _isEditable
            ? SizedBox(
                height: 75,
                width: 250,
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Enter new List Name',
                  ),
                  onFieldSubmitted: (input) {
                    setState(() {
                      _isEditable = false;
                    });
                    context
                        .read<ListsBloc>()
                        .add(SubmitNewListNameEvent(newName: input));
                  },
                ),
              )
            : Text(widget.filter[0].name),
        GestureDetector(
            onTap: () {
              setState(() {
                _isEditable = !_isEditable;
              });
            },
            child: Icon(Icons.edit, color: Theme.of(context).primaryColor))
      ],
    );
  }
}
