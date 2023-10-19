import 'package:dicoding_restaurant_app/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/widgets/atoms/customer_review_card.dart';
import 'package:flutter/material.dart';

class CustomerReviewWidget extends StatelessWidget {
  final List<CustomerReview> customerReviews;

  const CustomerReviewWidget({
    super.key,
    required this.customerReviews,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: customerReviews.map((value) => CustomerReviewCard(customerReview:value)).toList(),
    );
  }
}
