import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
import 'package:recipe_getx/domain/services/recipe_service.dart';

class RecipeController extends GetxController {
  final RecipeService _recipeService = RecipeService();
  RxList<RecipeModel> recipes = <RecipeModel>[].obs;

  //controllers

  final TextEditingController nameController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController cookingTimeController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Set up a listener to update the recipe list in real time
    Hive.box<RecipeModel>('recipes').listenable().addListener(() {
      loadRecipes();
    });
  }

  //add recipes

  addRecipes() async {
    final recipe = RecipeModel(
      name: nameController.text,
      imageUrl: imageUrlController.text,
      description: descriptionController.text,
      cookingTime: cookingTimeController.text,
      ingredients: ingredientsController.text,
    );
    await _recipeService.addRecipe(recipe);

    clear();

    //loading
    loadRecipes();
  }

  // Load all recipes from Hive and update the observable list
  Future<void> loadRecipes() async {
    final fetchedRecipes = await _recipeService.getRecipe();
    recipes.assignAll(fetchedRecipes);
  }

  // Delete recipe and update the list
  // Delete a specific recipe by index and update the list
  Future<void> deleteRecipe(int index) async {
    await _recipeService.deleteRecipe(index);
    loadRecipes(); // Refresh the list after deletion
  }
// In RecipeController

  void reorderRecipe(int oldIndex, int newIndex) async {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }

    final RecipeModel recipe = recipes.removeAt(oldIndex);
    recipes.insert(newIndex, recipe);

    // Clear and re-add all items in the correct order to the Hive box
    await _recipeService.recipeBox?.clear();
    for (final recipe in recipes) {
      await _recipeService.addRecipe(recipe);
    }
  }

// Save the recipes to Hive
  Future<void> saveRecipesToHive() async {
    // Make a copy of the list to avoid concurrent modification
    List<RecipeModel> recipeCopy = List.from(recipes);

    // Clear the existing Hive data before saving the updated list
    await _recipeService.recipeBox?.clear();

    // Iterate over the copied list to save each item
    for (var recipe in recipeCopy) {
      await _recipeService.addRecipe(recipe); // Save each recipe to Hive
    }
  }

  clear() {
    nameController.clear();
    imageUrlController.clear();
    descriptionController.clear();
    cookingTimeController.clear();
    ingredientsController.clear();
  }
}
