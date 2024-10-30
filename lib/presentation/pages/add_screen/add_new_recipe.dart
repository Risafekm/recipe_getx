// lib/presentation/pages/home_screen/home_screen.dart
// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
import 'package:recipe_getx/domain/services/recipe_service.dart';
import 'package:recipe_getx/infrastructure/controller/recipe_controller.dart';
import 'package:recipe_getx/presentation/pages/add_screen/widgets/button.dart';
import 'package:recipe_getx/presentation/pages/add_screen/widgets/text_area.dart';

class AddNewRecipe extends StatelessWidget {
  const AddNewRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.put(RecipeController());

    final TextEditingController nameController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final TextEditingController cookingTimeController = TextEditingController();
    final TextEditingController ingredientsController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('new_recipe'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextArea(
              controller: nameController,
              keyboardType: TextInputType.text,
              name: 'Recipe Name',
              prefixIcon: const Icon(Icons.restaurant),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: imageUrlController,
              keyboardType: TextInputType.text,
              name: 'Image Url',
              prefixIcon: const Icon(Icons.image),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: descriptionController,
              keyboardType: TextInputType.multiline,
              name: 'Recipe Description',
              prefixIcon: const Icon(Icons.description),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 10,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: cookingTimeController,
              keyboardType: TextInputType.text,
              name: 'Cooking Time',
              prefixIcon: const Icon(Icons.timelapse),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: ingredientsController,
              keyboardType: TextInputType.multiline,
              name: 'Ingredients',
              prefixIcon: const Icon(Icons.food_bank),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 10,
            ),
            const SizedBox(height: 20),
            Button(
              text: 'Save',
              onTap: () async {
                final recipe = RecipeModel(
                  name: nameController.text,
                  imageUrl: imageUrlController.text,
                  description: descriptionController.text,
                  cookingTime: cookingTimeController.text,
                  ingredients: ingredientsController.text,
                );

                RecipeService().addRecipe(recipe);
                Get.back(); // Close the current screen
                nameController.clear();
                imageUrlController.clear();
                descriptionController.clear();
                cookingTimeController.clear();
                ingredientsController.clear();

                //loading
                recipeController.loadRecipes();
              },
            ),
          ],
        ),
      ),
    );
  }
}