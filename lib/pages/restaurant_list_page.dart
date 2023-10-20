import 'package:dicoding_restaurant_app/data/enum/enum_state.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_list_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../data/model/restaurant.dart';

Logger logger = Logger();

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/';

  const RestaurantListPage({super.key});

  Widget _buildList() {
    return Consumer<RestaurantListProvider>(
      builder: (
        BuildContext context,
        RestaurantListProvider restauranListProvider,
        _,
      ) {
        if (restauranListProvider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (restauranListProvider.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: restauranListProvider.restaurantResult.restaurants.length,
            itemBuilder: (context, index) {
              Restaurant restaurantElement = restauranListProvider.restaurantResult.restaurants[index];
              return RestaurantCard(restaurant: restaurantElement);
            },
          );
        } else if (restauranListProvider.state == ResultState.noData) {
          return Center(
            child: Material(child: Text(restauranListProvider.message)),
          );
        } else if (restauranListProvider.state == ResultState.error) {
          return Center(
            child: Material(child: Text(restauranListProvider.message)),
          );
        } else {
          return const Center(
            child: Material(child: Text('something wrong happened...')),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
