import 'package:flutter/material.dart';

class ToDoDialog extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onAdd;
  final Widget title;

  const ToDoDialog({
    super.key,
    required this.controller,
    required this.onAdd,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      backgroundColor: Colors.blueAccent,
      content: Card(
        color: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Add New Task'),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            onAdd();
            Navigator.pop(context);
          },
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            controller.clear();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
