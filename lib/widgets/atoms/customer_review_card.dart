import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/models/restaurant_detail.dart';
import 'package:flutter/material.dart';

class CustomerReviewCard extends StatelessWidget {
  final CustomerReview customerReview;

  const CustomerReviewCard({
    super.key,
    required this.customerReview,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: accentColor,
        borderOnForeground: true,
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                customerReview.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              Text(
                customerReview.date,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white70,
                    ),
              ),
              const SizedBox(height: 16.0),
              Text(
                customerReview.review,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white70,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
