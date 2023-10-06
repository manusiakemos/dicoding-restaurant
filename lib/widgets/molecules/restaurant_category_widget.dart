import 'package:dicoding_restaurant_app/models/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/badge_widget.dart';
import 'package:flutter/material.dart';

class RestaurantCategoryWidget extends StatelessWidget {
  final List<Category> categories;
  const RestaurantCategoryWidget({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      children: categories.map((value) => BadgeWidget(nama: value.name)).toList(),
    );
  }
}
