import 'dart:convert';

import 'package:submission_tiga_notif/data/model/restaurant_detail.dart';

RestaurantReviewResult restaurantReviewResultFromJson(String str) => RestaurantReviewResult.fromJson(json.decode(str));

String restaurantReviewResultToJson(RestaurantReviewResult data) => json.encode(data.toJson());

class RestaurantReviewResult {
    RestaurantReviewResult({
        required this.error,
        required this.message,
        required this.customerReviews,
    });

    bool error;
    String message;
    List<CustomerReview> customerReviews;

    factory RestaurantReviewResult.fromJson(Map<String, dynamic> json) => RestaurantReviewResult(
        error: json["error"],
        message: json["message"],
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

 