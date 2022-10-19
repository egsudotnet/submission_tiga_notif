import 'package:submission_tiga_notif/data/model/restaurant.dart';
import 'package:submission_tiga_notif/provider/restaurant_favorite_provider.dart'; 
import 'package:submission_tiga_notif/widgets/card_restaurant.dart';
import 'package:submission_tiga_notif/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 

class RestaurantFavoritePage extends StatelessWidget {
  const RestaurantFavoritePage({Key? key}) : super(key: key);  
  
  Widget _buildList() {
    return Consumer<RestaurantFavoriteProvider>(
      builder: (context, state, _) {
        if (state.favorites.isNotEmpty ) { 
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.favorites.length,
            itemBuilder: (context, index) {
              var favorite = state.favorites[index];
              var restaurant = Restaurant(
                  id: favorite.id, 
                  name: favorite.name, 
                  description:favorite.description, 
                  pictureId:favorite.pictureId, 
                  city: favorite.city, 
                  rating: favorite.rating
                );

              return CardRestaurant(restaurant: restaurant);
            },
          ); 
        } else {
          return const Center(
            child: Material(
              child: Text('No Data Found'),
            ),
          );
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Favorite'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant Favorite'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
