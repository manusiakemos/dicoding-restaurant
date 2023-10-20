import 'package:dicoding_restaurant_app/data/database/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../data/enum/enum_state.dart';
import '../data/model/restaurant.dart';

class RestaurantFavoriteProvider extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  late ResultState _state;
  late DatabaseHelper _databaseHelper;
  String _message = '';

  String get message => _message;
  ResultState get state => _state;
  List<Restaurant> get restaurants => _restaurants;

  RestaurantFavoriteProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllRestaurants();
  }

  void _getAllRestaurants() async {
    Logger logger = Logger();
    try{
      _state = ResultState.loading;
      _restaurants = await _databaseHelper.getRestaurant();

      if (_restaurants.isNotEmpty) {
        _state = ResultState.hasData;
      } else {
        _state = ResultState.noData;
        _message = 'Empty data';
      }
      notifyListeners();
    }on Exception catch(error){
      logger.e(error);
      _state = ResultState.error;
      _message = 'Failed to fetch data from local database';
      notifyListeners();
    }
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
    return favoritedRestaurant.isNotEmpty;
  }
}
