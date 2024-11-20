import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePostPage extends ConsumerStatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends ConsumerState<CreatePostPage> {
  final TextEditingController postController = TextEditingController();
  String weather = '';
  bool isWeatherIncluded = false;

  // Function to check permissions and fetch weather
  Future<void> _getWeather() async {
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

  // Function to post the content
  Future<void> _postContent() async {
    final content = postController.text;
    final user = ref.watch(userProvider);
    if (content.isNotEmpty) {
      final postRef = FirebaseFirestore.instance.collection('posts').doc();
      await postRef.set({
        'uid': user.uid,
        'content': content,
        'weather': isWeatherIncluded
            ? weather
            : '', // Add weather only if it's included
        'createdAt': Timestamp.now(),
      });
      Navigator.pop(context); // Return to the previous page
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
              backgroundImage: user.photo.image,
            ),
            SizedBox(height: 8),
            const Text(
              "Write Your Post:",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            SizedBox(height: 16),
            TextField(
              controller: postController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Write your post...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getWeather, // Button to fetch weather
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: const Text(
                "Include Weather",
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              weather.isNotEmpty ? "Weather: $weather" : '',
              style: TextStyle(color: Colors.white, fontSize: 16),
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
}
