// ignore_for_file: unused_local_variable

import 'package:get/get.dart';

class LocalizationServices extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'home_content': 'Welcome to the My Recipe Box app!',
          'grocery_appbar': 'Grocery',
          'shopping_list': 'Shopping list',
          'calendar_appbar': 'Calendar',
          'home_appbar': 'All',
          'new_recipe': 'New Recipe',
          'calendar': 'Calendar',
          'grocery': 'Grocery',
          'add': 'Add',
          'add_from_internet': 'Add from internet',
          'scan_recipe_beta': 'Scan Recipe (beta)',
          'description': 'Description',
        },
        'ml_IN': {
          'home_content': 'എൻ്റെ Recipe Box ആപ്പിലേക്ക് സ്വാഗതം',
          'grocery_appbar': 'പലചരക്ക്',
          'shopping_list': 'ഷോപ്പിംഗ് ലിസ്റ്റ്',
          'calendar_appbar': 'കലണ്ടർ',
          'home_appbar': 'എല്ലാം',
          'new_recipe': 'പുതിയ പാചക',
          'calendar': 'കലണ്ടർ',
          'grocery': 'പലചരക്ക്',
          'add': 'ചേർക്കുക',
          'add_from_internet': 'ഇൻ്റർനെറ്റിൽ നിന്ന് ചേർക്കുക',
          'scan_recipe_beta': 'സ്കാൻ പാചകക്കുറിപ്പ് (ബീറ്റ)',
          'description': 'വിവരണം',
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
