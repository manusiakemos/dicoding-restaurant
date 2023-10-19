import 'package:dicoding_restaurant_app/data/database/database_helper.dart';
import 'package:flutter/foundation.dart';

import '../data/model/restaurant.dart';

class DbRestaurantProvider extends ChangeNotifier{
  List<Restaurant> _restaurants = [];
  late DatabaseHelper _databaseHelper;

  List<Restaurant> get restaurants => _restaurants;

  DbRestaurantProvider(){
    _databaseHelper = DatabaseHelper();
    _getAllRestaurants();
  }

  void _getAllRestaurants() async {
    _restaurants = await _databaseHelper.getRestaurant();
    notifyListeners();
  }

  Future<void> addRestaurant(Restaurant restaurant) async {
    await _databaseHelper.insertRestaurant(restaurant);
    _getAllRestaurants();
  }

  Future<void> updateRestaurant(Restaurant restaurant) async {
    await _databaseHelper.updateRestaurant(restaurant);
    _getAllRestaurants();
  }

  void deleteRestaurant(String id) async {
    await _databaseHelper.deleteRestaurant(id);
    _getAllRestaurants();
  }

  Future<Restaurant?> findRestaurant(String id) async {
    return await _databaseHelper.findRestaurant(id);
  }

  Future<bool> isFavorite(String id) async {
    final favoritedRestaurant = await _databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;  }

}