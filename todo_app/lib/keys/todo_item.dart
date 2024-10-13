import 'package:flutter/material.dart';
import 'package:todo_app/keys/priority.dart'; // Update this import

// Enum to define different priority levels for todo items
enum Priority { urgent, normal, low }

class TodoItem extends StatelessWidget {
  const TodoItem(this.text, this.priority, {super.key});

  final String text; // The text description of the todo item
  final Priority priority; // The priority level of the todo item

  @override
  Widget build(BuildContext context) {
    var icon = Icons.low_priority; // Default icon for low priority

    // Determine the icon based on the priority of the todo item
    if (priority == Priority.urgent) {
      icon = Icons.notifications_active; // Icon for urgent priority
    }

    if (priority == Priority.normal) {
      icon = Icons.list; // Icon for normal priority
    }

    return Padding(
      padding: const EdgeInsets.all(8), // Padding around the todo item
      child: Row(
        children: [
          Icon(icon), // Display the corresponding priority icon
          const SizedBox(width: 12), // Spacing between icon and text
          Text(text), // Display the text of the todo item
        ],
      ),
    );
  }
}
