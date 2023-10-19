import 'dart:convert';
import 'package:dicoding_restaurant_app/data/model/restaurant_detail.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_list.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_search.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final http.Client client;

  ApiService(this.client);

  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  static String get baseUrl => _baseUrl;

  Future<RestaurantList> getListRestaurant() async {
    try {
      final response = await client.get(Uri.parse("${_baseUrl}list"));
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
      final response = await client.get(Uri.parse("$_baseUrl/detail/$id"));
      if (response.statusCode == 200) {
        return RestaurantDetail.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (err) {
      throw Exception(err);
    }
  }

  Future<RestaurantSearch> searchRestaurant(String search) async {
    try {
      final response = await client.get(Uri.parse("$_baseUrl/search").replace(
        queryParameters: {
          'q': search,
        },
      ));
      if (response.statusCode == 200) {
        RestaurantSearch restaurantSearch =  RestaurantSearch.fromJson(json.decode(response.body));
        return restaurantSearch;
      } else {
        throw Exception('Failed to load restaurant detail');
      }
    } catch (err) {
      throw Exception(err);
    }
  }
}
