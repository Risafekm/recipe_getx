// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';

class DescriptionScreen extends StatelessWidget {
  RecipeModel recipeModel;
  DescriptionScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: Text('description'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Image.network(
                recipeModel.imageUrl,
                height: 250,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 250,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(child: Text('No image')),
                ), // Display if network fails
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                recipeModel.name,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Cooking Time: ${recipeModel.cookingTime}",
                  style: const TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("ingredients: ${recipeModel.ingredients}",
                  style: const TextStyle(fontSize: 14)),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text("Making: ${recipeModel.description}",
                  style: const TextStyle(fontSize: 14)),
            ),
          ],
        ),
      ),
    );
  }
}
