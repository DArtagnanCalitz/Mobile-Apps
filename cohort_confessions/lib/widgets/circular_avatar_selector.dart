import 'package:flutter/material.dart';

class CircularAvatarSelector extends StatelessWidget {
  const CircularAvatarSelector({
    super.key,
    required this.index,
    required this.image,
    required this.selection,
    required this.onSelect,
  });

  final int index;
  final int selection;
  final String? image;
  final Function onSelect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelect(index),
      child: CircleAvatar(
        radius: 55,
        backgroundColor:
            selection == index ? Colors.blueAccent : Colors.transparent,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Colors.grey,
          backgroundImage:
              image != null ? Image.asset(image!).image : null,
          child: image == null
              ? const Icon(Icons.person, size: 40, color: Colors.white)
              : null,
        ),
      ),
    );
  }
}
