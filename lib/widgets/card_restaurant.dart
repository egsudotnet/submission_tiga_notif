import 'package:submission_tiga_notif/common/styles.dart';
import 'package:submission_tiga_notif/data/model/restaurant.dart';
import 'package:submission_tiga_notif/ui/restaurant_detail_page.dart';
import 'package:flutter/material.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Hero(
                  tag: restaurant.pictureId,
                  child: Image.network(
                      "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}")),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(restaurant.name, style: myTextTheme.subtitle1),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(restaurant.city),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(children: <Widget>[
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      Text(restaurant.rating.toString()),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
