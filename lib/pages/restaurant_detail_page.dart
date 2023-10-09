import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/models/enum_state.dart';
import 'package:dicoding_restaurant_app/models/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/providers/restaurant_detail_provider.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/heading.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/customer_review_widget.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/restaurant_category_widget.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/makanan_minuman_grid_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const String routeName = '/restaurant-detail-page';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  Widget _consumerWiget(BuildContext context, Restaurant restaurant) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool isScrolled) {
        return [
          SliverAppBar(
            pinned: true,
            floating: false,
            leading: Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: Colors.white,
                  )),
            ),
            expandedHeight: 300,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                fit: BoxFit.cover,
              ),
            ),
          )
        ];
      },
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Heading(
                title: restaurant.name,
                size: 'lg',
              ),
              const SizedBox(height: 8.0),
              RestaurantCategoryWidget(
                categories: restaurant.categories,
              ),
              const SizedBox(height: 8.0),
              Flex(
                direction: Axis.horizontal,
                children: [
                  const Icon(Icons.pin_drop, color: Colors.amber),
                  const SizedBox(width: 4.0),
                  Text(restaurant.city),
                ],
              ),
              const SizedBox(height: 4.0),
              Flex(
                direction: Axis.horizontal,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4.0),
                  Text(restaurant.rating.toString()),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(restaurant.description),
              const SizedBox(height: 8.0),
              const SizedBox(height: 32.0),
              const Heading(title: 'Makanan', size: "md"),
              const SizedBox(height: 8.0),
              MakananMinumanGridWidget(
                listMakanan: restaurant.menus.foods,
              ),
              const SizedBox(height: 16.0),
              const Heading(title: 'Minuman', size: "md"),
              const SizedBox(height: 8.0),
              MakananMinumanGridWidget(
                listMakanan: restaurant.menus.drinks,
              ),
              const SizedBox(height: 16.0),
              const Heading(title: 'Customer Reviews', size: "md"),
              const SizedBox(height: 8.0),
              CustomerReviewWidget(
                customerReviews: restaurant.customerReviews,
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        body: ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (BuildContext context) => RestaurantDetailProvider(
            apiService: ApiService(),
            id: id,
          ),
          child: Consumer<RestaurantDetailProvider>(
            builder: (
              BuildContext context,
              RestaurantDetailProvider value,
              Widget? child,
            ) {
              if (value.state == ResultState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (value.state == ResultState.hasData) {
                return _consumerWiget(
                  context,
                  value.restaurantResult.restaurant,
                );
              } else if (value.state == ResultState.error) {
                return Center(
                  child: Text(value.message),
                );
              } else if (value.state == ResultState.noData) {
                return Center(
                  child: Text(value.message),
                );
              } else {
                return const Placeholder();
              }
            },
          ),
        ));
  }
}
