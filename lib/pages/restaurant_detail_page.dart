import 'package:dicoding_restaurant_app/models/restaurant.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/heading.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/makanan_minuman_grid_view.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const String routeName = '/restaurant-detail-page';
  final RestaurantElement restaurant;

  const RestaurantDetailPage(this.restaurant, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool isScrolled) {
            return [
              SliverAppBar(
                pinned: false,
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
                flexibleSpace: FlexibleSpaceBar(
                  background: Image.network(
                    restaurant.pictureId,
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
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Icon(Icons.pin_drop_outlined,
                          color: Colors.black38),
                      const SizedBox(width: 4.0),
                      Text(restaurant.city),
                    ],
                  ),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      const Icon(Icons.star_rate_outlined,
                          color: Colors.black38),
                      const SizedBox(width: 4.0),
                      Text(restaurant.rating.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(restaurant.description),
                  const SizedBox(
                    height: 4.0,
                  ),
                  const SizedBox(height: 32.0),
                  const Heading(title: 'Makanan', size: "md"),
                  const SizedBox(height: 8.0),
                  MakananMinumanGridView(listMakanan: restaurant.menus.foods),
                  const Heading(title: 'Minuman', size: "md"),
                  const SizedBox(height: 8.0),
                  MakananMinumanGridView(listMakanan: restaurant.menus.drinks),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
