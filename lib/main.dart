import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipe_getx/core/theme.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
import 'package:recipe_getx/domain/services/recipe_service.dart';
import 'package:recipe_getx/infrastructure/language_localization/localization.dart';
import 'package:recipe_getx/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:recipe_getx/presentation/pages/add_screen/add_new_recipe.dart';
import 'package:recipe_getx/presentation/pages/calendar/calendar.dart';

import 'package:recipe_getx/presentation/pages/grocery/grocery.dart';
import 'package:recipe_getx/presentation/pages/home_screen/home_screen.dart';
import 'package:recipe_getx/presentation/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RecipeModelAdapter()); // Register the adapter
  await Hive.openBox('language');
  await RecipeService().openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
      home: const SplashScreen(),
      getPages: [
        GetPage(name: '/calendar', page: () => const CalendarScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/grocery', page: () => const GroceryScreen()),
        GetPage(name: '/add', page: () => const AddNewRecipe()),
        GetPage(name: '/bottom', page: () => const BottomNavigator())
      ],
    );
  }
}
