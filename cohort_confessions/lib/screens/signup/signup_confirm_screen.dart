import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/models/user.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/screens/signup/signup_congrat_screen.dart';
import 'package:cohort_confessions/widgets/circular_avatar_selector.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

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

  File? _selectedImage;
  bool _isUploading = false;

  final ImagePicker _imagePicker = ImagePicker();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  // Function to pick an image
  Future<bool> _pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
      return true;
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick an image: $e')),
      );
      return false;
    }
  }

  // Function to upload the image to Firebase Storage
  Future<String?> _uploadImage() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image')),
      );
      return null;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      // TODO: unconstrain to jpg?
      String fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
      UploadTask uploadTask =
          _firebaseStorage.ref(fileName).putFile(_selectedImage!);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image uploaded successfully: $downloadUrl')),
      );

      // Clear the selected image after upload
      setState(() {
        _selectedImage = null;
      });

      String link = await snapshot.ref.getDownloadURL();
      return "gfs://$link";
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Upload failed: $e')),
      );
      return null;
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  // Returns the path to object with gfs:// prefixed or null if error
  Future<String?> getCustomImage() async {
    bool e = await _pickImage();
    if (!e) return null;
    String? s = await _uploadImage();
    if (s != null) {
      return s;
    }
    return null;
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
        case 2:
          String? s = await getCustomImage();
          if (s == null) {
            return;
          }
          photo_name = s;
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

  setSelection(int index) {
    setState(() {
      _selection = index;
    });
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
                CircularAvatarSelector(
                  index: 0,
                  image: 'assets/images/dog.jpg',
                  selection: _selection,
                  onSelect: setSelection,
                ),
                const SizedBox(width: 15),
                CircularAvatarSelector(
                  index: 1,
                  image: 'assets/images/cat.jpg',
                  selection: _selection,
                  onSelect: setSelection,
                ),
                const SizedBox(width: 15),
                CircularAvatarSelector(
                  index: 2,
                  image: null,
                  selection: _selection,
                  onSelect: setSelection,
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                addUserToFirestore();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: _selection == 2
                  ? const Text(
                      "Select Image",
                      style: TextStyle(color: Colors.white),
                    )
                  : const Text(
                      "Done!",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Column(
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
