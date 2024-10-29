import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNewRecipe extends StatelessWidget {
  const AddNewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('new_recipe'.tr),
      ),
      body: Center(child: Text('Add new recipe')),
    );
  }
}
