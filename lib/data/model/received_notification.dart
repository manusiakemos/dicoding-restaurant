import 'package:dicoding_restaurant_app/data/model/restaurant.dart';

class ReceivedNotification {
  final int? id;
  final String? title;
  final String? body;
  final Restaurant? payload;

  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });
}