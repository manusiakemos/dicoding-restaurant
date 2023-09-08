import 'package:flutter/material.dart';

class SubHeading extends StatelessWidget {
  final String title;
  const SubHeading({
    super.key,
    required this.title
  });


  @override
  Widget build(BuildContext context) {
    return Text(title,style: const TextStyle(
        color: Colors.black54,
        fontWeight: FontWeight.normal,
    ));
  }
}
