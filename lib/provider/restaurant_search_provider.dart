import 'dart:async';

import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:submission_tiga_notif/data/model/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;
  final String query;

  RestaurantSearchProvider({required this.apiService, required this.query}) {
    _fetchAllRestaurant(query);
  }

  late RestaurantSearchResult _restaurantSearchResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantSearchResult get result => _restaurantSearchResult;

  ResultState get state => _state;

  void searchRestaurant(String query) {
    _fetchAllRestaurant(query);
  }

  Future<dynamic> _fetchAllRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurantSearchResult = await apiService.search(query);
      if (restaurantSearchResult.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantSearchResult = restaurantSearchResult;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
