import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SearchLoading extends StatelessWidget {
  const SearchLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset('assets/json/search.json'),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Finding restaurant for you',
            style: myTextTheme.bodyMedium,
          ),
          Text(
            'Please wait',
            style: myTextTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
