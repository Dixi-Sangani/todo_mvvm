import 'package:flutter/material.dart';

class AddTodoListLabel extends StatelessWidget {
  String label = "";

   AddTodoListLabel({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(fontSize: 18, color: Colors.grey),
    );
  }
}
