import 'package:dicoding_restaurant_app/common/styles.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_favorite_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:dicoding_restaurant_app/pages/setting_page.dart';
import 'package:dicoding_restaurant_app/providers/home_provider.dart';
import 'package:dicoding_restaurant_app/widgets/molecules/navbar.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const routeName = 'home_page';
  
  HomePage({super.key});

  final List<Widget> _listWidget = [
    const RestaurantListPage(),
    const RestaurantFavoritePage(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Logger logger = Logger();
    return ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context){
        return HomeProvider(context: context);
      },
      child: Consumer<HomeProvider>(
        builder: (BuildContext context, HomeProvider homeProvider, Widget? child) {
          logger.d(homeProvider.navIndex);
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
                  selectedIndex: homeProvider.navIndex,
                  onTabChange: (int index) {
                    homeProvider.setNavIndex(index);
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
                  child: _listWidget.elementAt(homeProvider.navIndex)
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
