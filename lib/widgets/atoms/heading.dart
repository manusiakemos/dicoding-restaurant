import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String title;
  final String size;

  const Heading({
    Key? key, // Fixed the key parameter
    required this.title,
    this.size = "lg",
  }) : super(key: key); // Fixed the constructor syntax
  @override
  Widget build(BuildContext context) {
    double fontSize = 10.04;
    if (size == 'lg') {
      fontSize = 32.0; // Changed to a double value
    } else {
      fontSize = 16.0; // Changed to a double value
    }

    return Text(
      title,
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
        color: mutedColor,
        fontWeight: FontWeight.bold,
        fontSize: fontSize,
      )
    );
  }
}
