import 'package:flutter/material.dart';

class IconLabel extends StatelessWidget {
  const IconLabel({
    Key? key,
    required this.icon,
    required this.label,
    required this.color,
  }) : super(key: key);

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16.0, color: Color.fromARGB(255, 187, 31, 31)),
        SizedBox(width: 4.0),
        Text(label, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
