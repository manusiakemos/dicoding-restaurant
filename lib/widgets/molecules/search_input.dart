import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/restaurant_search_provider.dart';
import '../../utils/debouncer.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key});

  final Debouncer _debouncer = Debouncer(milliseconds: 500);
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              fillColor: accentColor,
              hintText: 'Search restaurants... ',
              hintStyle: const TextStyle(color: Colors.white),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 8.0,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 16,
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: secondaryColor, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                gapPadding: 16,
                borderRadius: BorderRadius.circular(100),
                borderSide: const BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            readOnly: false,
            onChanged: (String text) {
              _debouncer.run(() {
                state.restaurantSearchProvider(text);
              });
            },
          ),
        );
      },
    );
  }
}
