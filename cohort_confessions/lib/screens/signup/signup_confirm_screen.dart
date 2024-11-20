import 'package:cohort_confessions/screens/signup/signup_congrat_screen.dart';
import 'package:flutter/material.dart';

class SignupConfirmScreen extends StatefulWidget {
  @override
  _SignupConfirmScreenState createState() => _SignupConfirmScreenState();
}

class _SignupConfirmScreenState extends State<SignupConfirmScreen> {
  var _selection = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
            const Text(
              "Cohort Confessions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Please confirm a profile picture!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => setState(() => _selection = 0),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: _selection == 0
                        ? Colors.blueAccent
                        : Colors.transparent,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          Image.asset('assets/images/dog.jpg').image,
                    ),
                  ),
                ),
                const SizedBox(width: 25),
                GestureDetector(
                  onTap: () => setState(() => _selection = 1),
                  child: CircleAvatar(
                    radius: 55,
                    backgroundColor: _selection == 1
                        ? Colors.blueAccent
                        : Colors.transparent,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                          Image.asset('assets/images/cat.jpg').image,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                // addUserToFirestore();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SignupCongratScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Done!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to SearchScreen for sign-up
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
