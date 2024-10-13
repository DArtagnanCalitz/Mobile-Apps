import 'package:flutter/material.dart';
import 'package:todo_app/add_todo_dialog.dart';
import 'package:todo_app/keys/checkable_todo_item.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/keys/priority.dart'; // Update this import

// Class representing a Todo item with text, priority, and due date
class Todo {
  const Todo(this.text, this.priority, this.dueDate);

  final String text; // The text description of the todo item
  final Priority priority; // The priority level of the todo item
  final DateTime? dueDate; // The due date of the todo item
}

// Stateful widget that manages the todo list
class Keys extends StatefulWidget {
  const Keys({super.key});

  @override
  State<Keys> createState() {
    return _KeysState(); // Creates the state for the Keys widget
  }
}

class _KeysState extends State<Keys> {
  var _order =
      'asc'; // Tracks the current sorting order (ascending or descending)
  final List<Todo> _todos = [
    const Todo(
      'Learn Flutter',
      Priority.urgent,
      null,
    ),
    const Todo(
      'Practice Flutter',
      Priority.normal,
      null,
    ),
    const Todo(
      'Explore other courses',
      Priority.low,
      null,
    ),
  ];

  // Getter to return the todos sorted by their text
  List<Todo> get _orderedTodos {
    final sortedTodos = List.of(_todos); // Creates a copy of the todos list
    sortedTodos.sort((a, b) {
      final bComesAfterA = a.text.compareTo(b.text); // Compares todo texts
      return _order == 'asc'
          ? bComesAfterA
          : -bComesAfterA; // Sorts based on the order
    });
    return sortedTodos; // Returns the sorted list
  }

  // Toggles the sorting order and updates the UI
  void _changeOrder() {
    setState(() {
      _order =
          _order == 'asc' ? 'desc' : 'asc'; // Switches between 'asc' and 'desc'
    });
  }

  // Method to add a new to-do item to the list
  void _addTodoItem(String text, Priority priority, DateTime? dueDate) {
    setState(() {
      _todos.add(
          Todo(text, priority, dueDate)); // Adds a new todo item to the list
    });
  }

  // Method to show the modal form for creating a new to-do item
  void _showAddTodoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AddTodoDialog(onAddTodo: _addTodoItem);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do List'),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: _changeOrder, // Calls the method to change order
              icon: Icon(
                _order == 'asc'
                    ? Icons.arrow_downward
                    : Icons.arrow_upward, // Changes icon based on order
              ),
              label: Text(
                  'Sort ${_order == 'asc' ? 'Descending' : 'Ascending'}'), // Button label
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                for (final todo in _orderedTodos)
                  CheckableTodoItem(
                    key: ObjectKey(todo), // Assigns a unique key to the item
                    todo.text,
                    todo.priority,
                    todo.dueDate, // Pass the due date to CheckableTodoItem
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context), // Opens the form dialog
        child: const Icon(Icons.add),
      ),
    );
  }
}
