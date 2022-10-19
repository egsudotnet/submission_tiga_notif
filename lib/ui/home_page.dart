import 'dart:io';
import 'package:submission_tiga_notif/common/styles.dart';
import 'package:submission_tiga_notif/data/api/api_service.dart';
import 'package:submission_tiga_notif/provider/restaurant_favorite_provider.dart';
import 'package:submission_tiga_notif/provider/restaurant_provider.dart'; 
import 'package:submission_tiga_notif/ui/restaurant_detail_page.dart';
import 'package:submission_tiga_notif/ui/restaurant_favorite_page.dart';
import 'package:submission_tiga_notif/ui/restaurant_list_page.dart';
import 'package:submission_tiga_notif/ui/search_page.dart'; 
import 'package:submission_tiga_notif/utils/notification_helper.dart'; 
import 'package:submission_tiga_notif/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> { 
  int _bottomNavIndex = 0;

  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    const SearchPage(), 
    const RestaurantFavoritePage(), 
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [ 
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.list_bullet : Icons.list_alt),
      label: "List",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.search : Icons.search),
      label: "Search",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite),
      label: "Favorite",
    ), 
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: _bottomNavBarItems,
        activeColor: secondaryColor,
      ),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
