import 'package:flutter/material.dart';

class UserInfoYear extends StatefulWidget {
  const UserInfoYear({
    super.key,
    required this.yearController,
    required this.onChange,
  });

  final String yearController;
  final Function onChange;

  @override
  State<UserInfoYear> createState() => _UserInfoYearState();
}

class _UserInfoYearState extends State<UserInfoYear> {
  String? yearController;

  @override
  void initState() {
    super.initState();
    yearController = widget.yearController;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: yearController,
      items: const [
        DropdownMenuItem(value: '2022', child: Text('2022')),
        DropdownMenuItem(value: '2023', child: Text('2023')),
        DropdownMenuItem(value: '2024', child: Text('2024')),
      ],
      onChanged: (String? newValue) {
        widget.onChange(newValue);
        setState(() {
          yearController = newValue;
        });
      },
    );
  }
}
