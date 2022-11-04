import 'package:flutter/material.dart';
import 'package:mini_project_flutter_alterra/db/database_helper.dart';
import 'package:mini_project_flutter_alterra/models/restaurant_model.dart';
import 'package:mini_project_flutter_alterra/models/review_model.dart';
import 'package:mini_project_flutter_alterra/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  late DatabaseHelper _dbHelper;

  List<RestaurantModel> _favorite = [];
  List<RestaurantModel> get favorite => _favorite;

  List<ReviewModel> _review = [];
  List<ReviewModel> get review => _review;

  // mengimplementasi state management untuk mengakses data dari database
  DatabaseProvider() {
    _dbHelper = DatabaseHelper();
    _getAllFavorites();
    _getAllReviews();
  }

  ResultState _state = ResultState.loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  void _getAllFavorites() async {
    _favorite = await _dbHelper.getFavorite();
    if (_favorite.isNotEmpty) {
      _state = ResultState.none;
    } else {
      _state = ResultState.error;
      _message = 'Tidak ada data favorite';
    }
    notifyListeners();
  }

  Future<void> addFavorite(RestaurantModel restaurant) async {
    try {
      await _dbHelper.insertFavorite(restaurant);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await _dbHelper.getFavoriteById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void deleteFavorite(String id) async {
    try {
      await _dbHelper.deleteFavorite(id);
      _getAllFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
    }
    notifyListeners();
  }

  //=========================REVIEW PROVIDER=============================//

  void _getAllReviews() async {
    _review = await _dbHelper.getReview();
    notifyListeners();
  }

  Future<void> addReview(ReviewModel review) async {
    await _dbHelper.insertReview(review);
    _getAllReviews();
  }

  Future<ReviewModel> getReviewById(int id) async {
    return await _dbHelper.getReviewById(id);
  }

  void updateReview(ReviewModel review) async {
    await _dbHelper.updateReview(review);
    _getAllReviews();
  }

  void deleteReview(int id) async {
    await _dbHelper.deleteReview(id);
    _getAllReviews();
  }
}
