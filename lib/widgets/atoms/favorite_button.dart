import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/model/restaurant.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteButton({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {

    const snackBarAdded = SnackBar(
      content: Text('Added to favorites'),
    );

    const snackBarRemove = SnackBar(
      content: Text('Removed from favorites'),
    );

    return Consumer<DbRestaurantProvider>(
      builder: (BuildContext context, DbRestaurantProvider dbRestaurantProvider,
          Widget? child) {
        return FutureBuilder(
          future: dbRestaurantProvider.isFavorite(restaurant.id),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            final isFavorite = snapshot.data ?? false;
            return isFavorite
                ? IconButton(
                    color: Colors.red,
                    onPressed: () {
                      dbRestaurantProvider.deleteRestaurant(restaurant.id);
                      ScaffoldMessenger.of(context).showSnackBar(snackBarRemove);
                    },
                    icon: const Icon(
                      Icons.favorite,
                    ),
                  )
                : IconButton(
                    color: Colors.white,
                    onPressed: () {
                      dbRestaurantProvider.addRestaurant(restaurant);
                      ScaffoldMessenger.of(context).showSnackBar(snackBarAdded);
                    },
                    icon: const Icon(
                      Icons.favorite_outline,
                    ),
                  );
          },
        );
      },
    );
  }
}
