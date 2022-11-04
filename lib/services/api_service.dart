import 'package:dio/dio.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';

class ApiService {

  Future<List<RestaurantModel>> restaurantList() async {
    const String baseUrl = 'https://restaurant-api.dicoding.dev';
    final dio = Dio();
    final response = await dio.get('$baseUrl/list');
    if (response.statusCode == 200) {
      return List<RestaurantModel>.from(response.data["restaurants"]
          .map((resto) => RestaurantModel.fromJson(resto))
          .toList());
    }
    return [];
  }

}