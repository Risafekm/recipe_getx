// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/core/theme.dart';
import 'package:recipe_getx/infrastructure/language_localization/localization.dart';
import 'package:recipe_getx/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:recipe_getx/presentation/pages/calendar/calendar.dart';
import 'package:recipe_getx/presentation/pages/home_screen/widgets/home_screen.dart';
import 'package:recipe_getx/presentation/pages/grocery/grocery.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('language'); // Open a box named 'settings'
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the saved locale from Hive
    final box = Hive.box('language');
    final localeString = box.get('locale', defaultValue: 'en_US');
    final localeParts = localeString.split('_');
    final locale =
        Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : '');

    return GetMaterialApp(
      locale: locale,
      translations: LocalizationServices(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: MyTheme().appTheme,
      ),
      home: BottomNavigator(),
      getPages: [
        GetPage(name: '/calendar', page: () => const CalendarScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/grocery', page: () => const GroceryScreen()),
      ],
    );
  }
}
