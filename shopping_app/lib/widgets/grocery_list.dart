import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list/data/categories.dart';
import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widgets/grocery_item_widget.dart';
import 'package:shopping_list/widgets/new_item.dart';
import 'package:shopping_list/widgets/share_grocery_list.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryItems = [];
  final Set<String> _checkedItems = {}; // Track checked items
  late Future<List<GroceryItem>> _loadedItems;

  @override
  void initState() {
    super.initState();
    _loadedItems = _loadItems(); // Start loading items
  }

  Future<List<GroceryItem>> _loadItems() async {
    final url = Uri.https(
        'flutter-prep-3def9-default-rtdb.firebaseio.com', 'shopping-list.json');

    final response = await http.get(url);

    if (response.statusCode >= 400) {
      throw Exception('Failed to fetch grocery items. Please try again later.');
    }

    if (response.body == 'null') {
      return [];
    }

    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> loadedItems = [];

    for (final item in listData.entries) {
      final category = categories.entries
          .firstWhere(
              (catItem) => catItem.value.title == item.value['category'])
          .value;
      loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }

    return loadedItems;
  }

  void _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) {
      return;
    }

    // Reload the items from the database to ensure they show up
    setState(() {
      _loadedItems = _loadItems();
    });
  }

  void _checkOffItem(GroceryItem item) async {
    setState(() {
      _checkedItems.add(item.id); // Add item ID to checked items
    });

    final url = Uri.https('flutter-prep-3def9-default-rtdb.firebaseio.com',
        'shopping-list/${item.id}.json');

    await http.delete(url); // Remove it from the database
  }

  void _shareList() {
    ShareGroceryList.share(_groceryItems); // Share the list
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<RefreshIndicatorState> _refreshKey =
        GlobalKey<RefreshIndicatorState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareList,
          ),
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: _loadedItems,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return const Center(child: Text('No items added yet.'));
          }

          return RefreshIndicator(
            key: _refreshKey,
            onRefresh: () {
              setState(() {
                _loadedItems = _loadItems();
              });

              return _loadedItems;
            },
            color: Colors.white,
            backgroundColor: Colors.blue,
            child: ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                final item = snapshot.data![index];
                final isChecked =
                    _checkedItems.contains(item.id); // Check if item is checked

                return GroceryItemWidget(
                  item: item,
                  onCheckOff: _checkOffItem,
                  isChecked: isChecked,
                  index: index,
                  onShare: _shareList,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
