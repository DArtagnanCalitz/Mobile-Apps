import 'package:flutter/material.dart';

class UserInfoMajor extends StatefulWidget {
  const UserInfoMajor({
    super.key,
    required this.degreeController,
    required this.onChange,
  });

  final String degreeController;
  final Function onChange;

  @override
  State<UserInfoMajor> createState() => _UserInfoMajorState();
}

class _UserInfoMajorState extends State<UserInfoMajor> {
  String? degreeController;

  @override
  void initState() {
    super.initState();
    degreeController = widget.degreeController;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: degreeController,
      items: const [
        DropdownMenuItem(
            value: 'Software Engineering', child: Text('Software Engineering')),
        DropdownMenuItem(value: 'Finance', child: Text('Finance')),
        DropdownMenuItem(value: 'Business', child: Text('Business')),
      ],
      onChanged: (String? newValue) {
        widget.onChange(newValue);
        setState(() {
          degreeController = newValue;
        });
      },
    );
  }
}
