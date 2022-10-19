import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:submission_tiga_notif/provider/restaurant_review_provider.dart';

NumberFormat myFormat = NumberFormat.decimalPattern('en_us');

class AddCommentPage extends StatefulWidget {
  static const routeName = '/add_comment';
  final String id;
  const AddCommentPage({Key? key, required this.id}) : super(key: key);

  @override
  State<AddCommentPage> createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  late String name;
  late String review;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantReviewProvider>(
      create: (_) => RestaurantReviewProvider(apiService: ApiService()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add Comment"),
        ),
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(children: [
            TextField(
              decoration: const InputDecoration(
                hintText: "Name",
              ),
              onChanged: (String value) {
                setState(() {
                  name = value;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: "Comment",
              ),
              onChanged: (String value) {
                setState(() {
                  review = value;
                });
              },
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 5.0),
                child: Consumer<RestaurantReviewProvider>(
                  builder: (contextRestaurantReview, stateRestaurantReview, _) {
                    if (stateRestaurantReview.state == ResultReviewState.start) {
                      return ElevatedButton(
                          onPressed: () {
                            saveComment(context, stateRestaurantReview,
                                widget.id, name, review);
                          },
                          child: const Text("Save"));
                    } else if (stateRestaurantReview.state ==
                        ResultReviewState.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (stateRestaurantReview.state ==
                        ResultReviewState.error) {
                      return Center(
                        child: Material(
                          child: Column(children: <Widget>[
                            ElevatedButton(
                                onPressed: () {
                                  saveComment(context, stateRestaurantReview,
                                      widget.id, name, review);
                                },
                                child: const Text("Save")),
                            Text(stateRestaurantReview.message),
                          ]),
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
                )),
          ]),
        ),
      ),
    );
  }
}

void saveComment(context, RestaurantReviewProvider stateRestaurantReview,
    String id, String name, String review) {
  late Future<dynamic> restaurantReview;
  restaurantReview = stateRestaurantReview.addComent(id, name, review);
  restaurantReview.then((response) {
    if (response.customerReviews.isNotEmpty) {
      Navigator.pop(context, response.customerReviews);
    }
  });
}
