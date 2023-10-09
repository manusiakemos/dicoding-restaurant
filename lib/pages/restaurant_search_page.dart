import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/models/enum_state.dart';
import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_search_provider.dart';
import 'package:dicoding_restaurant_app/utils/debouncer.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/restaurant_card.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/text_input.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/search_loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  static const String routeName = 'search_restaurant';

  RestaurantSearchPage({super.key});

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  Widget _searchInput() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextInput(
            readOnly: false,
            autoFocus: true,
            onChanged: (text) {
              _debouncer.run(() {
                state.restaurantSearchProvider(text);
              });
            },
          ),
        );
      },

    );
  }

  Widget _listRestaurantWidget(
    BuildContext context,
    List<Restaurant> restaurants,
  ) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: restaurants.length,
        itemBuilder: (BuildContext context, int index) {
          return RestaurantCard(restaurant: restaurants[index]);
        },
      ),
    );
  }

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
          'Search Coffee',
          style: myTextTheme.titleLarge?.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ChangeNotifierProvider<RestaurantSearchProvider>(
        create: (BuildContext context) {
          return RestaurantSearchProvider(apiService: ApiService());
        },
        child: Column(
          children: [
            _searchInput(),
            Consumer<RestaurantSearchProvider>(
              builder: (
                BuildContext context,
                RestaurantSearchProvider value,
                Widget? child,
              ) {
                if (value.state == ResultState.loading) {
                  return const SearchLoading();
                } else if (value.state == ResultState.hasData) {
                  return _listRestaurantWidget(
                    context,
                    value.restaurantSearch.restaurants,
                  );
                } else if (value.state == ResultState.error) {
                  return Expanded(
                    child: Center(
                      child: Text(value.message),
                    ),
                  );
                } else if (value.state == ResultState.noData) {
                  return Expanded(
                    child: Center(
                      child: Text(value.message),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Center(
                      child: Text(value.message),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
