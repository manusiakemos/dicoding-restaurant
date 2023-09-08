import 'package:dicoding_restaurant_app/pages/restaurant_detail_page.dart';
import 'package:dicoding_restaurant_app/pages/restaurant_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'models/restaurant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final TextTheme myTextTheme = TextTheme(
      displayLarge: GoogleFonts.kumbhSans(
          fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
      displayMedium: GoogleFonts.kumbhSans(
          fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
      displaySmall:
      GoogleFonts.kumbhSans(fontSize: 46, fontWeight: FontWeight.w400),
      headlineMedium: GoogleFonts.kumbhSans(
          fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      headlineLarge:
      GoogleFonts.kumbhSans(fontSize: 23, fontWeight: FontWeight.w400),
      headlineSmall: GoogleFonts.kumbhSans(
          fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
      titleMedium: GoogleFonts.kumbhSans(
          fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
      titleSmall: GoogleFonts.kumbhSans(
          fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
      bodyLarge: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
      labelLarge: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
      bodySmall: GoogleFonts.poppins(
          fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
      labelSmall: GoogleFonts.poppins(
          fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
    );

    return MaterialApp(
      theme: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.amber,
              secondary: Colors.amberAccent,
              background: const Color(0xFFf1f5f9),
            ),
        textTheme: myTextTheme,
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: RestaurantListPage.routeName,
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
            ModalRoute.of(context)?.settings.arguments as RestaurantElement),
      },
    );
  }
}
