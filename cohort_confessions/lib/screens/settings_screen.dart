import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            Text(
              "YEAR: ${user.year}\nUSERNAME: ${user.name}\nMAJOR: ${user.major}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 30),
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
              child: Text("CHANGE USERNAME"),
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
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Logic to log out
                // set user info to default
                // Move to login screen
                Navigator.pushNamed(context, '/');
                // toast
                ScaffoldMessenger.of(context).clearSnackBars();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text('Logged out of Cohort Confessions'),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("LOGOUT"),
            ),
            SizedBox(height: 50),
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
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
