import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:submission_tiga_notif/data/model/restaurant_review.dart';

void main() {
    test('Restaurant review model fromJson test', () {
      const jsonString = '''
                  {
                      "error": false,
                      "message": "success",
                      "customerReviews": [
                      {
                          "name": "Ahmad",
                          "review": "Tidak rekomendasi untuk pelajar!",
                          "date": "13 November 2019"
                      },
                      {
                          "name": "test",
                          "review": "makanannya lezat",
                          "date": "29 Oktober 2020"
                      }
                  ]
                  }
              ''';
      final restaurant = RestaurantReviewResult.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
      expect(restaurant.customerReviews[0].name, "Ahmad");
    });
}
