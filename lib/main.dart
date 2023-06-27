import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quotes_app/views/screens/home_page.dart';

void main() {
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
      ],
    ),
  );
}
