import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/models/user.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/screens/signup/signup_congrat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupConfirmScreen extends StatefulWidget {
  const SignupConfirmScreen({
    super.key,
    required this.ref,
  });

  final WidgetRef ref;

  @override
  _SignupConfirmScreenState createState() => _SignupConfirmScreenState();
}

class _SignupConfirmScreenState extends State<SignupConfirmScreen> {
  var _selection = 0;
  // final user = ref.watch(userProvider);
  // _SignupConfirmScreenState(this._ref);

  late UserAccount user;

  @override
  void initState() {
    super.initState();
    user = widget.ref.watch(userProvider);
  }

  Future<void> addUserToFirestore() async {
    try {
      var photo_name;
      switch (_selection) {
        case 0:
          photo_name = "dog";
          break;
        case 1:
          photo_name = "cat";
          break;
        default:
          photo_name = "dog";
          break;
        // TODO: Add more icons
      }

      // Add photo id to Firestore
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'photo': photo_name,
      });

      // set Image on local user
      var img = widget.ref.read(userProvider.notifier).parsePhotoId(photo_name);
      widget.ref.read(userProvider.notifier).setImage(img);

      // Send toast
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Updated profile picture!')),
      );

      // Navigate to confirmation (profile) page after successful addition
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => const SignupCongratScreen(),
        ),
      );
    } catch (e) {
      print("Error adding user: $e");
    }
  }

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
                addUserToFirestore();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Done!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "To change your account information",
                  // style: TextStyle(color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  "go to the settings!",
                  // style: TextStyle(color: Colors.blue),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
