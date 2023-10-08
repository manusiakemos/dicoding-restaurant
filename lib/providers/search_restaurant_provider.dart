import 'package:dicoding_restaurant_app/data/api_service.dart';
import 'package:dicoding_restaurant_app/models/enum_state.dart';
import 'package:dicoding_restaurant_app/models/restaurant_search.dart';
import 'package:flutter/foundation.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService}) {
    searchRestaurant(query);
  }

  late RestaurantSearch _restaurantResult;
  late ResultState _state;
  String _query = '';
  String _message = 'Searching for restaurants';

  RestaurantSearch get restaurantSearch => _restaurantResult;
  ResultState get state => _state;
  String get message => _message;
  String get query => _query;

  Future<dynamic> searchRestaurant(String search) async {
    try {
      _state = ResultState.loading;
      _query = search;
      notifyListeners();
      if(search.isNotEmpty){
        final restaurant = await apiService.searchRestaurant(search);
        if (restaurant.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'No data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantResult = restaurant;
        }
      }else{
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No data';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    }
  }

}