import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

class ToDoTile extends StatelessWidget {
  final String name;
  final Color color;
  final bool taskCompleted;
  void Function(bool?)? onChanged;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  ToDoTile({
    super.key,
    required this.name,
    required this.color,
    required this.taskCompleted,
    required this.onChanged,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Card(
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: color.withValues(alpha: 0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Checkbox(
                    value: taskCompleted,
                    onChanged: onChanged,
                    activeColor: Colors.transparent,
                    side: BorderSide(color: Colors.white70, width: 2),
                  ),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(
                        color: AppColor.secondary,
                        fontWeight: FontWeight.w500,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: PopupMenuButton<String>(
                color: AppColor.secondary.withValues(alpha: 0.60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                iconColor: AppColor.secondary,
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit();
                  } else if (value == 'delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit', style: TextStyle(fontSize: 15)),
                  ),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete', style: TextStyle(fontSize: 15)),
                  ),
                ],
              ),
              // IconButton(
              //   onPressed: () {},
              //   icon: Icon(
              //     Icons.more_horiz,
              //     color: AppColor.secondary,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
