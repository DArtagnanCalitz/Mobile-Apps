import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/keys/priority.dart';

class CheckableTodoItem extends StatefulWidget {
  const CheckableTodoItem(this.text, this.priority, this.dueDate, {super.key});

  final String text; // The text description of the todo item
  final Priority priority; // The priority level of the todo item
  final DateTime? dueDate; // The due date of the todo item

  @override
  State<CheckableTodoItem> createState() => _CheckableTodoItemState();
}

class _CheckableTodoItemState extends State<CheckableTodoItem> {
  var _done = false; // State variable to track if the todo item is checked

  void _setDone(bool? isChecked) {
    setState(() {
      _done = isChecked ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority; // Default icon for low priority

    if (widget.priority == Priority.urgent) {
      icon = Icons.notifications_active; // Icon for urgent priority
    } else if (widget.priority == Priority.normal) {
      icon = Icons.list; // Icon for normal priority
    }

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(value: _done, onChanged: _setDone),
          const SizedBox(width: 6),
          Icon(icon),
          const SizedBox(width: 12),
          Text(widget.text),
          const Spacer(),
          if (widget.dueDate != null)
            Text(
              'Due: ${DateFormat.yMd().format(widget.dueDate!)}',
              style: TextStyle(color: Colors.grey),
            ),
          const SizedBox(width: 24),
        ],
      ),
    );
  }
}
