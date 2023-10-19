import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/enum/enum_state.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_list.dart';
import 'package:flutter/foundation.dart';

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchRestaurant();
  }

  late RestaurantList _restaurantResult;
  late ResultState _state;
  String _message = '';

  RestaurantList get restaurantResult => _restaurantResult;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    }
  }
}