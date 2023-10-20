import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/enum/enum_state.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({super.key});

  static const routeName = 'restaurant_favorite_page';

  @override
  Widget build(BuildContext context) {
    return Consumer<DbRestaurantProvider>(
      builder: (
        BuildContext context,
        DbRestaurantProvider dbRestaurantProvider,
        Widget? child,
      ) {
        logger.d(dbRestaurantProvider.state);
        if (dbRestaurantProvider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (dbRestaurantProvider.state == ResultState.noData) {
          return Center(
            child: Material(child: Text(dbRestaurantProvider.message)),
          );
        } else if (dbRestaurantProvider.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(dbRestaurantProvider.message),
            ),
          );
        } else {
          final items = dbRestaurantProvider.restaurants;
          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              final item = items[index];
              return Dismissible(
                key: Key(item.id.toString()),
                onDismissed: (DismissDirection direction) {
                  dbRestaurantProvider.deleteRestaurant(item.id);
                },
                child: RestaurantCard(
                  key: Key(item.id.toString()),
                  restaurant: item,
                ),
              );
            },
          );
        }
      },
    );
  }
}
