import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/providers/db_restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({super.key});

  static const routeName = 'restaurant_favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            tooltip: 'Go back',
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        title: Text(
          'Favorites',
          style: myTextTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Consumer<DbRestaurantProvider>(
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
                onDismissed: (DismissDirection direction){
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
      ),
    );
  }
}
