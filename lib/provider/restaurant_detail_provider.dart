import 'dart:async';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:submission_tiga_notif/data/model/restaurant_detail.dart';

enum ResultDetailState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;
  final String id;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchDetailRestaurant();
  }

  late RestaurantDetailResult _restaurantDetailResult;
  late ResultDetailState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResult get result => _restaurantDetailResult;

  ResultDetailState get state => _state;

  void setData() {
    _fetchDetailRestaurant();
  }

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultDetailState.loading;
      notifyListeners();
      final restaurantDetail = await apiService.detail(id);
      if (restaurantDetail.restaurant.id.isEmpty) {
        _state = ResultDetailState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultDetailState.hasData;
        notifyListeners();
        return _restaurantDetailResult = restaurantDetail;
      }
    } catch (e) {
      _state = ResultDetailState.error;
      notifyListeners();
      return _message = '$e';
    }
  }
}
