import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/restaurant_search_provider.dart';
import '../../utils/debouncer.dart';
import '../atoms/text_input.dart';

class SearchInput extends StatelessWidget {
  SearchInput({super.key});

  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
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
}
