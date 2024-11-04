import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemWidget extends StatelessWidget {
  final GroceryItem item;
  final ValueChanged<GroceryItem> onCheckOff;
  final bool isChecked;

  const GroceryItemWidget({
    Key? key,
    required this.item,
    required this.onCheckOff,
    required this.isChecked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.name),
      leading: Container(
        width: 24,
        height: 24,
        color: item.category.color,
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (value) {
          if (value != null && value) {
            onCheckOff(item);
          }
        },
      ),
    );
  }
}
