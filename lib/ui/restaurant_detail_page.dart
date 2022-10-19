import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:submission_tiga_notif/common/styles.dart';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:submission_tiga_notif/data/model/restaurant_detail.dart';
import 'package:submission_tiga_notif/data/model/restaurant_favorite.dart';
import 'dart:math' as math;

import 'package:submission_tiga_notif/provider/restaurant_detail_provider.dart';
import 'package:submission_tiga_notif/provider/restaurant_favorite_provider.dart';
import 'package:submission_tiga_notif/ui/add_comment.dart';
import 'package:submission_tiga_notif/widgets/comment_restaurant.dart'; 

NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';
  final String id;
  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  Widget _buildList() {
    return Consumer<RestaurantDetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultDetailState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultDetailState.hasData) {
          return _DetailPage(
            restaurant: state.result.restaurant,
          );
        } else if (state.state == ResultDetailState.noData) {
          return Center(
            child: Material(
              child: Text(state.message),
            ),
          );
        } else if (state.state == ResultDetailState.error) {
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
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: widget.id),
        child: Scaffold(
          body: _buildList(),
        ),
    );
  }
}

class _DetailPage extends StatefulWidget {
  final Restaurant restaurant;
  const _DetailPage({Key? key, required this.restaurant}) : super(key: key);

  @override
  State<_DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<_DetailPage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantFavoriteProvider>(context, listen: false)
    .isFavorite(widget.restaurant.id);

    return Scaffold(      
        appBar: AppBar(
        title: Text(widget.restaurant.name ),
        actions: <Widget>[
          Consumer<RestaurantFavoriteProvider>(
              builder: (contextFavorite, stateFavorite, _) {
            return IconButton(
              icon: stateFavorite.isPavorite
                  ? const Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                      size: 30.0,
                    )
                  : const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 30.0,
                    ),
              onPressed: () {
                if (!stateFavorite.isPavorite) {
                  final favorite = RestaurantFavorite(
                    id: widget.restaurant.id,
                    name: widget.restaurant.name,
                    description: widget.restaurant.description,
                    pictureId: widget.restaurant.pictureId,
                    city: widget.restaurant.city,
                    rating: widget.restaurant.rating,
                  );
                  Provider.of<RestaurantFavoriteProvider>(context,
                          listen: false)
                      .addFavorite(favorite);
                } else {
                  Provider.of<RestaurantFavoriteProvider>(context,
                          listen: false)
                      .deleteFavorite(widget.restaurant.id);
                }
                  Provider.of<RestaurantFavoriteProvider>(context, listen: false)
                      .isFavorite(widget.restaurant.id);
              },
            );
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
                tag: widget.restaurant.pictureId,
                child: Image.network(
                  "https://restaurant-api.dicoding.dev/images/small/${widget.restaurant.pictureId}",
                  fit: BoxFit.cover,
                  height: 300,
                )),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const Icon(
                        Icons.map,
                        color: Colors.blueAccent,
                        size: 30.0,
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.restaurant.city,
                        style: myTextTheme.caption,
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      const Icon(Icons.star, color: Colors.amber),
                      const SizedBox(height: 8.0),
                      Text(
                        widget.restaurant.rating.toString(),
                        style: myTextTheme.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Address :", style: myTextTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      widget.restaurant.address,
                      style: myTextTheme.caption,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Description :", style: myTextTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ExpandableText(widget.restaurant.description,
                        style: myTextTheme.caption,
                        maxLines: 4,
                        expandText: 'show more',
                        collapseText: 'show less'),
                  ]),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Categories :", style: myTextTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 30,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.restaurant.categories.map((item) {
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 205, 221, 241),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(255, 205, 221, 241),
                              spreadRadius: 3),
                        ],
                      ),
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Text(item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: myTextTheme.caption),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Foods :", style: myTextTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.restaurant.menus.foods.map((item) {
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/food.jpg",
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                            Text(item.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: myTextTheme.caption),
                            Text(random(), style: myTextTheme.overline),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text("Drinks :", style: myTextTheme.subtitle1),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: SizedBox(
                height: 105,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: widget.restaurant.menus.drinks.map((item) {
                    return Container(
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.white),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/drink.jpg",
                              fit: BoxFit.cover,
                              height: 60,
                              width: 60,
                            ),
                            Text(
                              item.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: myTextTheme.caption,
                            ),
                            Text(random(), style: myTextTheme.overline),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Row(children: [
                Text(
                  "Customer Reviews (${widget.restaurant.customerReviews.length}) :",
                  style: myTextTheme.subtitle1,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: InkWell(
                      onTap: () async {
                        Navigator.pushNamed(context, AddCommentPage.routeName,
                                arguments: widget.restaurant.id)
                            .then((value) => setState(() {
                                  if (value != null) {
                                    List<CustomerReview> newList = [];
                                    final args = value as List<dynamic>;
                                    for (var element in args) {
                                      CustomerReview newData = CustomerReview(
                                          name: element.name,
                                          review: element.review,
                                          date: element.date);
                                      newList.add(newData);
                                    }

                                    widget.restaurant.customerReviews = newList;
                                  }
                                }));
                      },
                      child: SizedBox(
                        height: 20,
                        width: 30,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white)),
                          child: const Text(
                            'Add',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              color: secondaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.white)),
                child: SizedBox(
                  height: 300,
                  child: CommentRestaurant(
                      review:
                          widget.restaurant.customerReviews.reversed.toList()),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}

String random() {
  return "IDR ${myFormat.format(math.Random().nextInt(100) * 100)}";
}
