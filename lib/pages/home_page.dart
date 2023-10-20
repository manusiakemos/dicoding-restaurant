import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/pages/setting_page.dart';
import 'package:dicoding_restaurant_app/utils/background_service.dart';
import 'package:dicoding_restaurant_app/utils/notification_helper.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

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
    const RestaurantListPage(),
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
        surfaceTintColor: primaryColor,
        flexibleSpace: const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: NavbarWidget(),
          ),
        ),
        toolbarHeight: MediaQuery.of(context).size.height * 0.1,
        backgroundColor: primaryColor,
        foregroundColor: primaryColor,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 16,
        ),
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: Color(0xFFFFFFFF)),
            left: BorderSide(color: Color(0xFFFFFFFF)),
            bottom: BorderSide(color: Color(0xFFFFFFFF)),
            right: BorderSide(color: Color(0xFFFFFFFF)),
          ),
          color: accentColor,
          borderRadius: BorderRadius.all(Radius.circular(100)),
        ),
        child: GNav(
            rippleColor: secondaryColor,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.black,
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.white,
            color: Colors.black,
            selectedIndex: _navIndex,
            onTabChange: (int index) {
              setState(() {
                _navIndex = index;
              });
            },
            tabs: const <GButton>[
              GButton(
                iconColor: Colors.white,
                icon: LineIcons.home,
                text: 'Home',
              ),
              GButton(
                iconColor: Colors.white,
                icon: LineIcons.heart,
                text: 'Favorite',
              ),
              GButton(
                iconColor: Colors.white,
                icon: LineIcons.cog,
                text: 'Setting',
              ),
            ]),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _listWidget.elementAt(_navIndex),
          ),
        ),
      ),
    );
  }
}
