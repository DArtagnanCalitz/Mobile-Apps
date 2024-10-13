import 'package:flutter/material.dart';

class DemoButtons extends StatefulWidget {
  const DemoButtons({super.key});

  @override
  State<DemoButtons> createState() {
    return _DemoButtonsState(); // Create the state for the DemoButtons widget
  }
}

class _DemoButtonsState extends State<DemoButtons> {
  var _isUnderstood = false; // State variable to track if the user understood

  @override
  Widget build(BuildContext context) {
    print(
        'DemoButtons BUILD called'); // Debugging: print when the widget is rebuilt
    return Column(
      mainAxisSize: MainAxisSize.min, // Minimize the size of the column
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the buttons horizontally
          children: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood =
                      false; // Set _isUnderstood to false when "No" is pressed
                });
              },
              child: const Text('No'), // Button for "No" response
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isUnderstood =
                      true; // Set _isUnderstood to true when "Yes" is pressed
                });
              },
              child: const Text('Yes'), // Button for "Yes" response
            ),
          ],
        ),
        if (_isUnderstood)
          const Text('Awesome!'), // Conditionally display message if understood
      ],
    );
  }
}
