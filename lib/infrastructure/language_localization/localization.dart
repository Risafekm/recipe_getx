// ignore_for_file: unused_local_variable

import 'package:get/get.dart';

class LocalizationServices extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home_content': 'Welcome to the My Recipe Box app!',
          'profile_appbar': 'Profile',
          'shopping_list': 'Shopping list',
          'calendar_appbar': 'Calendar',
          'home_appbar': 'All',
          'add': 'New Recipe',
        },
        'ml_IN': {
          'home_content': 'എൻ്റെ Recipe Box ആപ്പിലേക്ക് സ്വാഗതം',
          'profile_appbar': 'പ്രൊഫൈൽ',
          'shopping_list': 'ഷോപ്പിംഗ് ലിസ്റ്റ്',
          'calendar_appbar': 'കലണ്ടർ',
          'home_appbar': 'എല്ലാം',
          'add': 'പുതിയ പാചക',
        },
      };

  // @override
  // Map<String, Map<String, String>> get keys => {};

  // Future<void> accessApiLanguage() async {
  //   final response = await http.get(Uri.parse(api));

  //   if (response.statusCode == 200) {
  //     List<dynamic> data = json.decode(response.body);
  //     for (var item in data) {
  //       String languageId = item['id'] == '1' ? 'en_US' : 'ml_IN';
  //       keys[languageId] = {
  //         'home_content': item['home_content'],
  //         'profile': item['profile'],
  //         'shopping_list': item['shopping_list'],
  //         'calendar': item['calender'],
  //         'all_home': item['all_home'],
  //         'add': item['add'],
  //       };
  //     }
  //   } else {
  //     throw Exception("Failed to load translations from API");
  //   }
  // }
}