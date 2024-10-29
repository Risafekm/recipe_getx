// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_getx/core/api_const.dart';
import 'package:recipe_getx/presentation/pages/home_screen/widgets/home_screen.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomeScreen(),
      bottomNavigationBar: BottomAppBar(
        height: 67,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed('/calendar'),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.calendar_month_rounded, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'calendar'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          itemCount: items.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(items[index]['icon'],
                                    color: Colors.white),
                              ),
                              title: Text(
                                items[index]['title'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              onTap: () {
                                // Handle tap on item
                                Navigator.pop(
                                    context); // Close the bottom sheet
                                // Perform the navigation or action here
                                print('${items[index]['title']} tapped!');
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_box_outlined, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'add'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed('/grocery'),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_grocery_store_rounded, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'grocery'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
