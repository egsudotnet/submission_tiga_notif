import 'dart:async';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:submission_tiga_notif/data/model/restaurant_review.dart';

enum ResultReviewState { start, loading, noData, hasData, error }

class RestaurantReviewProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantReviewProvider({required this.apiService}) {
    _state = ResultReviewState.start;
  }

  late RestaurantReviewResult _restaurantReviewResult;
  late ResultReviewState _state;
  String _message = '';

  String get message => _message;

  RestaurantReviewResult get result => _restaurantReviewResult;

  ResultReviewState get state => _state;

  Future<dynamic> addComent(String id, String name, String review) async {
    try {
      _state = ResultReviewState.loading;
      notifyListeners();
      final restaurantReviewResult =
          await apiService.addComment(id, name, review);
      if (restaurantReviewResult.customerReviews.isEmpty) {
        _state = ResultReviewState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultReviewState.hasData;
        notifyListeners();
        return _restaurantReviewResult = restaurantReviewResult;
      }
    } catch (e) {
      _state = ResultReviewState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
