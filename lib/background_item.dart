import 'package:flutter/material.dart';

class BackgroundItem extends StatelessWidget {
  final String value;
  final String text;
  final String image;

  BackgroundItem({
    required this.value,
    required this.text,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/images/background/$image',
          height: 100,
          width: 100,
        ),
        SizedBox(width: 8.0),
        Text(text),
      ],
    );
  }
}
