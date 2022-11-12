import 'package:flutter/material.dart';

class ThemedChip extends StatelessWidget {
  final Icon avatar;
  final String label;
  const ThemedChip({
    required this.avatar,
    required this.label,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).primaryColor,
      avatar: CircleAvatar(backgroundColor: Colors.white, child: avatar),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
