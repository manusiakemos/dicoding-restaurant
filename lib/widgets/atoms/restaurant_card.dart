import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/heading.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/sub_heading.dart';
import 'package:flutter/material.dart';

import '../../models/restaurant_list.dart';

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
          arguments: restaurant.id,
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
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      height: 100,
                      width: 150,
                      fit: BoxFit.cover,
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
                            const Icon(Icons.star, color: Colors.white,),
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
