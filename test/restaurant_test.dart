import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:submission_tiga_notif/data/model/restaurant.dart'; 

void main() {
    test('Restaurant model fromJson test', () {
      const jsonString = '''
              {
                  "error": false,
                  "message": "success",
                  "count": 20,
                  "restaurants": [
                      {
                          "id": "rqdv5juczeskfw1e867",
                          "name": "Melting Pot",
                          "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
                          "pictureId": "14",
                          "city": "Medan",
                          "rating": 4.2
                      },
                      {
                          "id": "s1knt6za9kkfw1e867",
                          "name": "Kafe Kita",
                          "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
                          "pictureId": "25",
                          "city": "Gorontalo",
                          "rating": 4
                      }
                  ]
              }
              ''';
      final restaurant = RestaurantResult.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);  
      expect(restaurant.restaurants[0].id, "rqdv5juczeskfw1e867");
    }); 
}