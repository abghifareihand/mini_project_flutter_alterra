import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/services/api_service.dart';
import 'package:mini_project_flutter_alterra/utils/result_state.dart';

class RestaurantProvider extends ChangeNotifier {
  ApiService apiService = ApiService();

  ResultState _state = ResultState.none;
  List<RestaurantModel> _restaurant = [];

  ResultState get state => _state;
  List<RestaurantModel> get restaurant => _restaurant;

  void getAllRestaurant() async {
    _state = ResultState.loading;
    try {
      final response = await apiService.restaurantList();
      _restaurant = response;
      notifyListeners();
      _state = ResultState.none;
    } catch (e) {
      _state = ResultState.error;
    }
  }
}
