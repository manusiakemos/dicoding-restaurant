import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/favorite_button.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/heading.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/sub_heading.dart';
import 'package:flutter/material.dart';

import '../../data/model/restaurant.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantCard({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //navigate to restaurant detail page
        Navigator.pushNamed(
          context,
          RestaurantDetailPage.routeName,
          arguments: restaurant,
        );
      },
      child: Card(
        color: accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      children: [
                        Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                          height: 100,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        FavoriteButton(
                          restaurant: restaurant,
                        ),
                      ],
                    ),
                  ),
                  Container(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 5),
                        Heading(
                          title: restaurant.name,
                          size: "md",
                        ),
                        Container(height: 5),
                        SubHeading(title: restaurant.city),
                        Container(height: 10),
                        Flex(
                          direction: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 5),
                            SubHeading(title: restaurant.rating.toString()),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
