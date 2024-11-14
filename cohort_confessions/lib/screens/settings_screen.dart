import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              "YEAR: 2024\nNAME: JOE SMITH\nMAJOR: COMPUTER SCIENCE",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to change year
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: Text("CHANGE YEAR"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to change name
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: Text("CHANGE NAME"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to change major
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: Text("CHANGE MAJOR"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Logic to log out
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("LOGOUT"),
            ),
            SizedBox(height: 20),
            Text(
              "App Version 1.2",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to delete account
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text("DELETE ACCOUNT"),
            ),
          ],
        ),
      ),
    );
  }
}
