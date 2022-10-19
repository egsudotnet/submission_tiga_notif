import 'dart:convert'; 
import 'package:http/http.dart' as http;
import 'package:submission_tiga_notif/data/model/restaurant.dart';
import 'package:submission_tiga_notif/data/model/restaurant_detail.dart';
import 'package:submission_tiga_notif/data/model/restaurant_review.dart';
import 'package:submission_tiga_notif/data/model/restaurant_search.dart'; 

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/'; 

  Future<RestaurantResult> mainList() async {
    try{ 
      final response = await http.get(Uri.parse("${_baseUrl}list"));
      if (response.statusCode == 200) {
        return RestaurantResult.fromJson(json.decode(response.body));
       } else {
        throw 'No data found';
      }
    }catch(ex){  
        if(ex.toString().contains("lookup")){
          throw "No Internet Access";  
        }else{
          throw ex.toString(); 
        }
    }
  }
 
  Future<RestaurantDetailResult> detail(String id) async {
    try{ 
      final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
      if (response.statusCode == 200) {
        return RestaurantDetailResult.fromJson(json.decode(response.body));
       } else {
        throw 'No data found';
      }
    }catch(ex){  
        if(ex.toString().contains("lookup")){
          throw "No Internet Access";  
        }else{
          throw ex.toString(); 
        }
    }
  }
   
  Future<RestaurantReviewResult> detailReview(String id) async {
    try{ 
      final response = await http.get(Uri.parse("${_baseUrl}detail/$id"));
      if (response.statusCode == 200) {
        return RestaurantReviewResult.fromJson(json.decode(response.body));
       } else {
        throw 'No data found';
      }
    }catch(ex){  
        if(ex.toString().contains("lookup")){
          throw "No Internet Access";  
        }else{
          throw ex.toString(); 
        }
    }
  }

  Future<RestaurantSearchResult> search(String query) async {
    try{  
      if(query != ""){ 
        final response = await http.get(Uri.parse("${_baseUrl}search?q=$query"));
        if (response.statusCode == 200) {
          RestaurantSearchResult data = RestaurantSearchResult.fromJson(json.decode(response.body));
          if(data.restaurants.isNotEmpty){
            return data;
          }else{
            throw 'No data found';
          }
        } else {
          throw 'No data found';
        }
      }else{
          throw 'Please Find Your Restaurant!';
      }
    }catch(ex){  
        if(ex.toString().contains("lookup")){
          throw "No Internet Access";  
        }else{
        throw ex.toString(); 
        }
    }
  }

  
  Future<RestaurantReviewResult> addComment(String id, String name,String review) async {
    try{  
      if(name != "" && review != ""){ 
 
        final response = await http.post(
            Uri.parse("${_baseUrl}review"),
            headers: <String, String>{
              'Content-Type': 'application/json',
            },
            body: jsonEncode(<String, String>{
              "id" : id, 
              "name" : name, 
              "review" : review
            }
          )
        );

        if (response.statusCode == 201) {
          RestaurantReviewResult data = RestaurantReviewResult.fromJson(json.decode(response.body));
          if(data.customerReviews.isNotEmpty){
            return data;
          }else{
            throw 'No data found';
          }
        } else {
          throw 'No data found';
        }
      }else{
          throw 'Please Complete Your Input!';
      }
    }catch(ex){  
        if(ex.toString().contains("lookup")){
          throw "No Internet Access";  
        }else{
        throw ex.toString(); 
        }
    }
  }
}
