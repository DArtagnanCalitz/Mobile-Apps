import 'package:flutter/material.dart';
import 'package:todo_app/demo_buttons.dart';

class UIUpdatesDemo extends StatelessWidget {
  const UIUpdatesDemo({super.key}); // Constructor for the UIUpdatesDemo widget

  @override
  Widget build(BuildContext context) {
    print('UIUpdatesDemo BUILD called'); // Log when the build method is called
    return const Padding(
      padding: EdgeInsets.all(8.0), // Padding around the entire column
      child: Center(
        child: Column(
          mainAxisSize:
              MainAxisSize.min, // Minimize the column size to fit its children
          crossAxisAlignment:
              CrossAxisAlignment.center, // Center align the children
          children: [
            Text(
              'Every Flutter developer should have a basic understanding of Flutter\'s internals!',
              textAlign: TextAlign.center, // Center the text
              style: TextStyle(fontWeight: FontWeight.bold), // Bold text style
            ),
            SizedBox(height: 16), // Space between text elements
            Text(
              'Do you understand how Flutter updates UIs?',
              textAlign: TextAlign.center, // Center the text
            ),
            SizedBox(height: 24), // Space before the demo buttons
            DemoButtons(), // Custom widget displaying demo buttons
          ],
        ),
      ),
    );
  }
}
