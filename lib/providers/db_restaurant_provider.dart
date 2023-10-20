import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dicoding_restaurant_app/data/database/database_helper.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:flutter/foundation.dart';

import '../data/enum/enum_state.dart';
import '../data/model/restaurant.dart';

class DbRestaurantProvider extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  late ResultState _state;
  late DatabaseHelper _databaseHelper;
  String _message = '';
  bool _isConnected = false;

  bool get isConnected => _isConnected;
  String get message => _message;
  ResultState get state => _state;
  List<Restaurant> get restaurants => _restaurants;

  DbRestaurantProvider() {
    _databaseHelper = DatabaseHelper();
    _getAllRestaurants();
  }

  void _getAllRestaurants() async {
    try{
      Connectivity().onConnectivityChanged.listen((connectivityResult) {
        _isConnected = connectivityResult != ConnectivityResult.none;
      });
      if(_isConnected){
        _state = ResultState.loading;
        _restaurants = await _databaseHelper.getRestaurant();
        if (_restaurants.isNotEmpty) {
          _state = ResultState.hasData;
        } else {
          _state = ResultState.noData;
          _message = 'Favorite data is empty';
        }
      }else{
        _state = ResultState.error;
        _message = 'Not connected to the internet';
        notifyListeners();
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
