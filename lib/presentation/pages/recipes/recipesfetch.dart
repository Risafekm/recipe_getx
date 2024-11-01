import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('recipe_appbar'.tr),
        automaticallyImplyLeading: false,
      ),
      body: const Center(child: Text('recipe')),
    );
  }
}
