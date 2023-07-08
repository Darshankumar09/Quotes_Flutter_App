import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quotes_app/views/screens/category_page.dart';
import 'package:quotes_app/views/screens/favorite_page.dart';
import 'package:quotes_app/views/screens/home_page.dart';
import 'package:quotes_app/views/screens/quote_details_page.dart';
import 'package:quotes_app/views/screens/theme_page.dart';

void main() async {
  await GetStorage.init();

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(useMaterial3: true),
      getPages: [
        // GetPage(
        //   name: "/",
        //   page: () => const SplashScreen(),
        // ),
        GetPage(
          name: "/",
          page: () => const HomePage(),
        ),
        GetPage(
          name: "/categoryPage",
          page: () => const CategoryPage(),
        ),
        GetPage(
          name: "/quoteDetailsPage",
          page: () => const QuoteDetailsPage(),
        ),
        GetPage(
          name: "/favoritePage",
          page: () => const FavoritePage(),
        ),
        GetPage(
          name: "/backGroundThemePage",
          page: () => const BackGroundThemePage(),
        ),
      ],
    ),
  );
}
