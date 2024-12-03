import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/userinfo/major.dart';
import 'package:cohort_confessions/widgets/userinfo/username.dart';
import 'package:cohort_confessions/widgets/userinfo/year.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  String yearController = "2024";
  String degreeController = "Software Engineering";

  final UsernameController usernameController = UsernameController();

  // Function to show the popup dialog
  // Field options: YEAR, USERNAME, MAJOR
  void _showEditDialog(String field) {
    String field_text = field.toLowerCase().capitalize();

    changeMajorController(String newValue) {
      setState(() {
        degreeController = newValue;
      });
    }

    changeYearController(String newValue) {
      setState(() {
        yearController = newValue;
      });
    }

    Widget content = const SizedBox();
    if (field == "YEAR") {
      content = UserInfoYear(
        yearController: yearController,
        onChange: changeYearController,
      );
    }

    if (field == "USERNAME") {
      content = UserInfoUsername(controller: usernameController);
    }

    if (field == "MAJOR") {
      content = UserInfoMajor(
        degreeController: degreeController,
        onChange: changeMajorController,
      );
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets, // Adjust for keyboard
          child: Container(
            padding: const EdgeInsets.all(35),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Update $field_text',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                content,
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the sheet
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (field == "YEAR") {
                          int i = int.parse(yearController);
                          setState(() {
                            ref.watch(userProvider.notifier).setYear(i);
                          });
                        }
                        if (field == "USERNAME") {
                          String? res = await usernameController.validate();
                          if (res == null) {
                            return;
                          }
                          setState(() {
                            ref.watch(userProvider.notifier).setName(res);
                          });
                        }
                        if (field == "MAJOR") {
                          setState(() {
                            ref
                                .watch(userProvider.notifier)
                                .setMajor(degreeController);
                          });
                        }
                        Navigator.of(context).pop(); // Close the sheet
                      },
                      child: const Text('Update'),
                    ),
                  ],
                ),
                const SizedBox(height: 200),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Settings"),
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
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
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Logic to change year
                _showEditDialog("YEAR");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: const Text(
                "CHANGE YEAR",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to change name
                _showEditDialog("USERNAME");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: const Text(
                "CHANGE USERNAME",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to change major
                _showEditDialog("MAJOR");
              },
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: const Text(
                "CHANGE MAJOR",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
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
              child: const Text(
                "LOGOUT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              "App Version 1.2",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Logic to delete account
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "DELETE ACCOUNT",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
