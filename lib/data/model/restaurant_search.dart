import 'dart:convert'; 
import 'package:submission_tiga_notif/data/model/restaurant.dart';

RestaurantSearchResult restaurantSearchResultFromJson(String str) => RestaurantSearchResult.fromJson(json.decode(str));

String restaurantSearchResultToJson(RestaurantSearchResult data) => json.encode(data.toJson());

class RestaurantSearchResult {
    RestaurantSearchResult({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    bool error;
    int founded;
    List<Restaurant> restaurants;

    factory RestaurantSearchResult.fromJson(Map<String, dynamic> json) => RestaurantSearchResult(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}
 