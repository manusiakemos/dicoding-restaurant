import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/pages/setting_page.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/restaurant_list_widget.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/navbar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = 'home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _navIndex = 0;
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    const RestaurantListWidget(),
    const RestaurantFavoritePage(),
    const SettingPage(),
  ];

  @override
  void initState() {
    super.initState();
    port.listen((_) async {
      await BackgroundService.callback();
    });
    _notificationHelper.selectedNotificationRestaurant(context, RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        toolbarOpacity: 1,
        centerTitle: true,
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        surfaceTintColor: primaryColor,
        flexibleSpace: Container(
          margin: const EdgeInsets.only(top: 50, bottom: 0, left: 8, right: 8),
          child: const NavbarWidget(),
        ),
        backgroundColor: primaryColor,
        foregroundColor: primaryColor,
      ),
      bottomSheet: BottomNavigationBar(
        elevation: 10,
        unselectedItemColor: Colors.white,
        backgroundColor: primaryColor,
        selectedItemColor: secondaryColor,
        currentIndex: _navIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.restaurant,
              color: Colors.white,
            ),
            label: 'Restaurant',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_outline,
              color: Colors.white,
            ),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              color: Colors.white,
            ),
            label: 'Settings',
          ),
        ],
        onTap: (index) {
          setState(() {
            _navIndex = index;
          });
        },
      ),
      body: Container(
        margin: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.05,
            bottom: MediaQuery.of(context).size.height * 0.10,
        ),
        height: MediaQuery.of(context).size.height * 0.9,
        child: _listWidget.elementAt(_navIndex),
      ),
    );
  }
}
