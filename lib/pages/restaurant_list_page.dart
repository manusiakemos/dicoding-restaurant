import 'package:dicoding_restaurant_app/models/enum_state.dart';
import 'package:dicoding_restaurant_app/models/restaurant_list.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

Logger logger = Logger();

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/';

  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.restaurantResult.restaurants.length,
            itemBuilder: (context, index) {
              Restaurant restaurantElement =
                  state.restaurantResult.restaurants[index];
              return RestaurantCard(restaurant: restaurantElement);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Placeholder(),
            ),
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
