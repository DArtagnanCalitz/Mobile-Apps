import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/keys/priority.dart'; // Ensure this is the correct path

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({required this.onAddTodo, super.key});

  final void Function(String text, Priority priority, DateTime? dueDate)
      onAddTodo;

  @override
  _AddTodoDialogState createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _textController = TextEditingController();
  Priority _selectedPriority = Priority.normal; // Default priority
  DateTime? _dueDate; // Store selected due date

  void _submit() {
    final text = _textController.text;
    if (text.isEmpty) return; // Check if the text field is empty

    widget.onAddTodo(text, _selectedPriority, _dueDate); // Call the callback
    Navigator.of(context).pop(); // Close the dialog
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Todo Item'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _textController,
            decoration: const InputDecoration(labelText: 'Todo Text'),
          ),
          // Dropdown for priority selection
          DropdownButton<Priority>(
            value: _selectedPriority,
            items: const [
              DropdownMenuItem(value: Priority.urgent, child: Text('Urgent')),
              DropdownMenuItem(value: Priority.normal, child: Text('Normal')),
              DropdownMenuItem(value: Priority.low, child: Text('Low')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _selectedPriority = value;
                });
              }
            },
          ),
          // Date picker for due date
          TextButton(
            onPressed: () async {
              final selectedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              setState(() {
                _dueDate = selectedDate; // Store the selected date
              });
            },
            child: Text(_dueDate == null
                ? 'Select Due Date'
                : 'Due Date: ${DateFormat.yMd().format(_dueDate!)}'),
          ),
        ],
      ),
      actions: [
        TextButton(onPressed: _submit, child: const Text('Add Todo')),
      ],
    );
  }
}
