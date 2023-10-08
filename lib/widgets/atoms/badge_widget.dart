import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String nama;

  const BadgeWidget({
    super.key,
    required this.nama,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: accentColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Text(
          nama,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: mutedColor, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
