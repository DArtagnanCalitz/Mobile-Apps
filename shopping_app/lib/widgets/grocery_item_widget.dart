import 'package:flutter/material.dart';
import 'package:shopping_list/models/grocery_item.dart';

class GroceryItemWidget extends StatefulWidget {
  final GroceryItem item;
  final ValueChanged<GroceryItem> onCheckOff;
  final bool isChecked;
  final int index;
  final Function onShare;

  const GroceryItemWidget({
    Key? key,
    required this.item,
    required this.onCheckOff,
    required this.isChecked,
    required this.index,
    required this.onShare,
  }) : super(key: key);

  @override
  State<GroceryItemWidget> createState() => _GroceryItemWidgetState();
}

class _GroceryItemWidgetState extends State<GroceryItemWidget> {
  int? _selectedIndex;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (details) {
        setState(() {
          _selectedIndex = widget.index;
        });
        _showOptions(context, details.globalPosition, widget.index);
      },
      child: Container(
        color: _selectedIndex == widget.index
            ? Colors.blue.withOpacity(0.2)
            : null,
        child: ListTile(
          title: Text(widget.item.name),
          leading: Container(
            width: 24,
            height: 24,
            color: widget.item.category.color,
          ),
          subtitle: Text(widget.item.quantity.toString()),
          trailing: Checkbox(
            value: widget.isChecked,
            onChanged: (value) {
              if (value != null && value) {
                widget.onCheckOff(widget.item);
              }
            },
          ),
        ),
      ),
    );
  }

  void _showOptions(BuildContext context, Offset position, int index) {
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        MediaQuery.of(context).size.width - position.dx,
        MediaQuery.of(context).size.height - position.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Text('Edit'),
        ),
        PopupMenuItem(
          value: 'share',
          child: Text('Share'),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Text('Delete'),
        ),
      ],
    ).then((value) {
      setState(() {
        _selectedIndex = null; // Clear selection
      });
      if (value != null) {
        _handleOptionSelection(context, value, index);
      }
    });
  }

  void _handleOptionSelection(BuildContext context, String option, int index) {
    switch (option) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Edit selected for item $index')),
        );
        break;
      case 'share':
        widget.onShare();
        break;
      case 'delete':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Delete selected for item $index')),
        );
        break;
    }
  }
}
