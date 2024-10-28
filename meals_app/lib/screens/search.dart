import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/providers/meals_provider.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() =>
      _SearchScreenState(); // Create the state for this widget.
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _searchTerm = ''; // Variable to hold the current search term.
  List<Meal> _foundMeals =
      []; // List to store meals that match the search term.

  @override
  void initState() {
    super.initState(); // Call the superclass initState.
    // Load the initial list of meals from mealsProvider.
    _foundMeals = ref.read(mealsProvider); // Read meals from mealsProvider.
  }

  // Function to search for meals based on the user's query.
  void _searchMeals(String query) {
    setState(() {
      _searchTerm = query; // Update the search term.
      // Filter meals based on whether the title contains the search query.
      _foundMeals = ref.read(mealsProvider).where((meal) {
        return meal.title.toLowerCase().contains(query.toLowerCase());
      }).toList(); // Convert the filtered results to a list.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meals'), // Set the title of the app bar.
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.all(16.0), // Add padding around the TextField.
            child: TextField(
              onChanged:
                  _searchMeals, // Call _searchMeals whenever the text changes.
              style: const TextStyle(
                  color: Colors.white), // Set text color to white.
              decoration: InputDecoration(
                labelText: 'Search for a meal', // Label for the TextField.
                labelStyle: const TextStyle(
                    color: Colors.white), // Set label color to white.
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                      12), // Rounded borders for the TextField.
                ),
                filled: true, // Fill the background of the TextField.
                fillColor: Colors
                    .black, // Set the background color of the TextField to black.
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundMeals
                  .length, // Number of meals found based on the search.
              itemBuilder: (ctx, index) {
                final meal =
                    _foundMeals[index]; // Get the meal at the current index.
                return ListTile(
                  title: Text(meal.title), // Display the meal title.
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(meal
                        .imageUrl), // Display the meal image in a circular avatar.
                  ),
                  onTap: () {
                    // Navigate to the MealDetailsScreen when the ListTile is tapped.
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MealDetailsScreen(
                            meal:
                                meal), // Pass the selected meal to the details screen.
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
