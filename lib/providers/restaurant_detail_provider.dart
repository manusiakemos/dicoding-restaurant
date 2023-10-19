import 'package:dicoding_restaurant_app/data/api/api_service.dart';
import 'package:dicoding_restaurant_app/data/enum/enum_state.dart';
import 'package:dicoding_restaurant_app/data/model/restaurant_detail.dart';
import 'package:flutter/foundation.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetail(id);
  }

  late RestaurantDetail _restaurantDetail;
  late ResultState _state;
  String _message = '';

  RestaurantDetail get restaurantResult => _restaurantDetail;
  ResultState get state => _state;
  String get message => _message;

  Future<dynamic> _fetchRestaurantDetail(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantResult = await apiService.getDetailRestaurant(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetail = restaurantResult;
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Not connected to the internet...';
    }
  }
}
