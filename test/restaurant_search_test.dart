import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:submission_tiga_notif/data/model/restaurant_search.dart';

void main() {
    test('Restaurant search model fromJson test', () {
      const jsonString = '''
                 {
                    "error": false,
                    "founded": 1,
                    "restaurants": [
                        {
                            "id": "fnfn8mytkpmkfw1e867",
                            "name": "Makan mudah",
                            "description": "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
                            "pictureId": "22",
                            "city": "Medan",
                            "rating": 3.7
                        }
                    ]
                }
              ''';
      final restaurant = RestaurantSearchResult.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
      expect(restaurant.restaurants[0].id, "fnfn8mytkpmkfw1e867");
    });
}
