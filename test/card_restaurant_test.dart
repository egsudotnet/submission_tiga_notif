import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:submission_tiga_notif/data/model/restaurant_detail.dart';  
import 'package:submission_tiga_notif/widgets/comment_restaurant.dart';  
  
final List<CustomerReview> review = [
  CustomerReview(date: '', name: '', review: ''),
  CustomerReview(date: '', name: '', review: '')
];

Widget createHomeScreen() => MaterialApp(
        home: CommentRestaurant(review: review,),
      );
    
void main() {
  group('Comment Restaurant Widget Test', () { 
    testWidgets('Testing if ListView shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ListView), findsOneWidget);
    });

    WidgetsFlutterBinding.ensureInitialized();
    testWidgets('Testing if Card shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(Card), findsWidgets);
    });

    testWidgets('Testing if Column shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('Testing if ExpandableText shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(ExpandableText), findsWidgets);
    });   
  });
}