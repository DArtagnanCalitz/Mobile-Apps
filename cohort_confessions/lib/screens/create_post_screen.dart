import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController postController = TextEditingController();
  String weather = '';
  bool isWeatherIncluded = false;

  Future<void> _getWeather() async {
    // Get the user's current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final latitude = position.latitude;
    final longitude = position.longitude;

    // Fetch weather using OpenWeatherMap API
    final apiKey = '11a5b159429d4f208290daa61e170ccc'; // Add your API key here
    final url =
        'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weather = '${data['main']['temp']}°C'; // Store only the temperature
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
        SnackBar(content: Text('Failed to fetch weather')),
      );
    }
  }

  Future<void> _postContent() async {
    final content = postController.text;
    if (content.isNotEmpty) {
      final postRef = FirebaseFirestore.instance.collection('posts').doc();
      await postRef.set({
        'name':
            'User', // Replace with actual username from FirebaseAuth if needed
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
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Cohort Confessions"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 40, backgroundColor: Colors.grey),
            SizedBox(height: 8),
            Text(
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
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _getWeather,
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
              child: Text("Include Weather"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _postContent,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text("Post"),
            ),
          ],
        ),
      ),
    );
  }
}