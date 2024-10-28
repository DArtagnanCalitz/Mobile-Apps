import 'package:flutter/material.dart';
import 'package:meals/screens/add_meal_screen.dart';

class MainDrawer extends StatelessWidget {
  final void Function(String identifier) onSelectScreen;

  const MainDrawer({Key? key, required this.onSelectScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(title: const Text('Cooking up!')),
          ListTile(
            title: const Text('Meals'),
            onTap: () => onSelectScreen('meals'),
          ),
          ListTile(
            title: const Text('Filters'),
            onTap: () => onSelectScreen('filters'),
          ),
          // In main_drawer.darwer
          ListTile(
            title: const Text('Add Your Own Meal'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => AddMealScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
