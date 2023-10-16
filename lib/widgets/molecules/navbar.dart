import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_search_page.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Restaurant',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: secondaryColor,
                  letterSpacing: -2,
                  fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantFavoritePage.routeName,
                    );
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RestaurantSearchPage.routeName,
                    );
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 32,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          'Recommendation restaurant for you',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
