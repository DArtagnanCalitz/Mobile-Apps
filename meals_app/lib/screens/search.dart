import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart'; // Adjust the import based on your project structure
import 'package:meals/providers/meals_provider.dart'; // Adjust the import based on your project structure

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  String _searchTerm = '';
  List<Meal> _foundMeals = [];

  @override
  void initState() {
    super.initState();
    // Assuming meals are available via a provider.
    _foundMeals = ref
        .read(mealsProvider); // Replace with the correct provider if necessary.
  }

  void _searchMeals(String query) {
    setState(() {
      _searchTerm = query;
      _foundMeals = ref.read(mealsProvider).where((meal) {
        return meal.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Meals'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: _searchMeals,
              style: const TextStyle(
                  color: Colors.white), // Change text color to white
              decoration: InputDecoration(
                labelText: 'Search for a meal',
                labelStyle: const TextStyle(
                    color: Colors.white), // Change label color to white
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor:
                    Colors.black, // Change background color of the TextField
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _foundMeals.length,
              itemBuilder: (ctx, index) {
                final meal = _foundMeals[index];
                return ListTile(
                  title: Text(meal.title),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(meal.imageUrl),
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => MealDetailsScreen(meal: meal),
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
