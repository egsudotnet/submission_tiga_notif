import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart'; 
import 'package:submission_tiga_notif/provider/scheduling_provider.dart'; 
import 'package:submission_tiga_notif/ui/settings_page.dart';

 
Widget createHomeScreen() => ChangeNotifierProvider<SchedulingProvider>(
  create: (context) => SchedulingProvider(),
  child: const MaterialApp(
    home: SettingsPage(),
  ),
);

 
void main() {
  group('Restaurant Switch Page Widget Test', () {
    testWidgets('Testing if Switch shows up', (WidgetTester tester) async {
      await tester.pumpWidget(createHomeScreen());
      expect(find.byType(Switch), findsOneWidget);
    });
  });
}