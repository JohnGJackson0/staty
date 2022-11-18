import 'package:flutter/material.dart';

class ThemedChip extends StatelessWidget {
  final Icon avatar;
  final String label;
  final Color color;
  const ThemedChip({
    required this.avatar,
    required this.label,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: color,
      avatar: CircleAvatar(
          backgroundColor: Colors.white, foregroundColor: color, child: avatar),
      label: Text(label, style: const TextStyle(color: Colors.white)),
    );
  }
}
