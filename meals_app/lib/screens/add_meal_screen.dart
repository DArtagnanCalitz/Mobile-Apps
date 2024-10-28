import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/providers/meals_provider.dart';

class AddMealScreen extends ConsumerWidget {
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _stepsController = TextEditingController();
  File? _image;

  void _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      // Update the state with the new image
      _image = File(pickedFile.path);
    }
  }

  void _submitMeal(BuildContext context, WidgetRef ref) {
    final title = _titleController.text;
    final ingredients = _ingredientsController.text.split(',');
    final steps = _stepsController.text.split(',');

    if (title.isEmpty ||
        ingredients.isEmpty ||
        steps.isEmpty ||
        _image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please fill all fields and choose an image.')),
      );
      return;
    }

    final newMeal = Meal(
      id: DateTime.now().toString(),
      categories: [],
      title: title,
      imageUrl: _image!.path,
      ingredients: ingredients,
      steps: steps,
      duration: 30,
      complexity: Complexity.simple, // Set a default complexity
      affordability: Affordability.affordable, // Set a default affordability
      isGlutenFree: false,
      isLactoseFree: false,
      isVegetarian: false,
      isVegan: false,
    );

    // Adding the meal to your mealProvider
    final mealsNotifier = ref.read(mealsProvider.notifier);
    mealsNotifier
        .addMeal(newMeal); // Using the addMeal method to add the new meal

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Your Meal'),
      ),
      backgroundColor: Colors.black, // Set background color to black
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              style: const TextStyle(color: Colors.white), // White text
              decoration: const InputDecoration(
                labelText: 'Meal Title',
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Underline color when focused
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ingredientsController,
              style: const TextStyle(color: Colors.white), // White text
              decoration: const InputDecoration(
                labelText: 'Ingredients (comma-separated)',
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Underline color when focused
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _stepsController,
              style: const TextStyle(color: Colors.white), // White text
              decoration: const InputDecoration(
                labelText: 'Steps (comma-separated)',
                labelStyle: TextStyle(color: Colors.white), // White label text
                enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.white), // Underline color
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.white), // Underline color when focused
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_image == null ? 'No Image Chosen' : 'Image Selected',
                    style: const TextStyle(color: Colors.white)), // White text
                TextButton(
                  onPressed: () => _pickImage(context),
                  child: const Text('Choose Image',
                      style: TextStyle(
                          color: Colors
                              .blue)), // Change button text color if needed
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_image != null)
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                ),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _submitMeal(context, ref),
              child: const Text('Add Meal'),
            ),
          ],
        ),
      ),
    );
  }
}
