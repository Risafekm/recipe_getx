import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
import 'package:recipe_getx/domain/services/recipe_service.dart';

class RecipeController extends GetxController {
  final RecipeService _recipeService = RecipeService();
  RxList<RecipeModel> recipes = <RecipeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecipes();

    // Set up a listener to update the recipe list in real time
    Hive.box<RecipeModel>('recipes').listenable().addListener(() {
      loadRecipes();
    });
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
}
