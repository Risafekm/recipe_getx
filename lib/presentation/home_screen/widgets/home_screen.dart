// home_screen.dart
// ignore_for_file: unused_local_variable, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List languages = [
      {"name": "English", "locale": const Locale('en_US')},
      {"name": "Malayalam", "locale": const Locale('ml_IN')},
    ];

    void changeLanguage(Locale locale) {
      Get.back();
      Get.updateLocale(locale);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('home_appbar'.tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Languages'),
                    content: Container(
                      width: double.maxFinite,
                      child: ListView.separated(
                        itemCount: languages.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () =>
                                changeLanguage(languages[index]['locale']),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                languages[index]['name'],
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.change_circle,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text('home_content'.tr),
          ),
        ],
      ),
    );
  }
}
