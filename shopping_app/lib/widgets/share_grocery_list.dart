import 'package:share/share.dart';
import 'package:shopping_list/models/grocery_item.dart';

class ShareGroceryList {
  static void share(List<GroceryItem> groceryItems) {
    final itemList = groceryItems
        .map((item) => '${item.name} (${item.quantity})')
        .join('\n');
    final String message = 'Check out my grocery list:\n$itemList';

    Share.share(message);
  }
}
