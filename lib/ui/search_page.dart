import 'package:provider/provider.dart';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:flutter/material.dart';
import 'package:submission_tiga_notif/provider/restaurant_search_provider.dart';
import 'package:submission_tiga_notif/widgets/card_restaurant.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search_page';
  const SearchPage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Consumer<RestaurantSearchProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultState.error) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else {
          return const Center(
            child: Material(
              child: Text(''),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) =>
          RestaurantSearchProvider(apiService: ApiService(), query: ""),
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<RestaurantSearchProvider>(
              builder: (context, stateSeaarch, _) {
            return TextField(
              cursorColor: Colors.white,
              style: const TextStyle(fontSize: 20.0, color: Colors.white),
              decoration: const InputDecoration(
                hintText: "Cari...",
                hintStyle: TextStyle(
                    fontSize: 20.0, color: Color.fromARGB(255, 169, 169, 169)),
              ),
              onChanged: (val) {
                stateSeaarch.searchRestaurant(val.toLowerCase());
              },
            );
          }),
        ),
        body: _buildList(),
      ),
    );
  }
}
