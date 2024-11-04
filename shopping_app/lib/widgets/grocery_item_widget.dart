import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemWidget extends StatelessWidget {
  final GroceryItem item;
  final Function onCheckOff;

  const GroceryItemWidget({
    Key? key,
    required this.item,
    required this.onCheckOff,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      onDismissed: (direction) => onCheckOff(item),
      key: ValueKey(item.id),
      child: ListTile(
        title: Text(item.name),
        leading: Container(
          width: 24,
          height: 24,
          color: item.category.color,
        ),
        trailing: Checkbox(
          value: false, // Set this value based on your logic for checked items
          onChanged: (value) {
            onCheckOff(item);
          },
        ),
      ),
    );
  }
}
