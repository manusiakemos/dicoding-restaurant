import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({super.key});

  static const routeName = 'restaurant_favorite_page';

  @override
  Widget build(BuildContext context) {
    return Consumer<DbRestaurantProvider>(
      builder: (
        BuildContext context,
        DbRestaurantProvider value,
        Widget? child,
      ) {
        final items = value.restaurants;
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            final item = items[index];
            return Dismissible(
              key: Key(item.id.toString()),
              onDismissed: (DismissDirection direction) {
                value.deleteRestaurant(item.id);
              },
              child: RestaurantCard(
                key: Key(item.id.toString()),
                restaurant: item,
              ),
            );
          },
        );
      },
    );
  }
}
