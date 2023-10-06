import 'dart:convert';
import 'package:dicoding_restaurant_app/models/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/models/restaurant_list.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<RestaurantList> getListRestaurant() async {
    try {
      final response = await http.get(Uri.parse("${_baseUrl}list"));
      if (response.statusCode == 200) {
        return RestaurantList.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant list');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<RestaurantDetail> getDetailRestaurant(String id) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl/detail/$id"));
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
