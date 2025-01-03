import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePostPage extends ConsumerStatefulWidget {
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController postController = TextEditingController();
  String weather = '';
  bool isWeatherIncluded = false;
  bool isLoadingWeather = false;

  // Function to check permissions and fetch weather
  Future<void> _getWeather() async {
    setState(() {
      isLoadingWeather = true; // Indicate that we're fetching weather
    });

    // Check the permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      // Request location permission if it is denied
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        // Handle permission denial
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permission denied')),
        );
        setState(() {
          isLoadingWeather = false;
        });
        return;
      }
    }

    // Proceed to get the user's location after permission is granted
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;

    // Fetch weather
    await _fetchWeather(latitude, longitude);
  }

  // Function to fetch the weather based on location
  Future<void> _fetchWeather(double latitude, double longitude) async {
    const apiKey = '11a5b159429d4f208290daa61e170ccc'; // Your API key
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    setState(() {
      isLoadingWeather = false; // Reset loading state
    });

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weather = '${data['main']['temp']}°C'; // Store the temperature
        isWeatherIncluded = true;
      });

      // Show confirmation message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Weather added: $weather')),
      );
    } else {
      setState(() {
        weather = 'Failed to fetch weather';
      });
      // Show error message if fetching weather fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch weather')),
      );
    }
  }

  /// Function to post the content
  Future<void> _postContent() async {
    final content = postController.text;
    final user = ref.watch(userProvider);
    if (content.isNotEmpty && content.length >= 5) {
      // Ensure content is long enough
      final postRef = FirebaseFirestore.instance.collection('posts').doc();
      await postRef.set({
        'uid': user.uid,
        'content': content,
        'weather': isWeatherIncluded
            ? weather
            : '', // Add weather only if it's included
        'createdAt': Timestamp.now(),
      });

      // Pass the postId to navigate back with the postId
      Navigator.popAndPushNamed(
          context, "/home"); // Pass the postId back to the previous screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Post content must be at least 5 characters long')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Cohort Confessions"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.grey,
              backgroundImage: user.photo.image, // Fallback for missing photo
            ),
            const SizedBox(height: 8),
            const Text(
              "Write Your Post:",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: postController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your post...",
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: isLoadingWeather
                  ? null
                  : _getWeather, // Disable if fetching weather
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: isLoadingWeather
                  ? const CircularProgressIndicator() // Show progress indicator
                  : const Text(
                      "Include Weather",
                      style: TextStyle(color: Colors.white),
                    ),
            ),
            const SizedBox(height: 16),
            Text(
              weather.isNotEmpty ? "Weather: $weather" : '',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _postContent,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Post",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> onWillPop() async {
    // Override the back button behavior to go directly to the HomePage
    Navigator.popUntil(context, ModalRoute.withName('/'));
    return false;
  }
}
