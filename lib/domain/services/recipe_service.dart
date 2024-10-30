// lib/services/recipe_service.dart
import 'package:hive/hive.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';

class RecipeService {
  Box<RecipeModel>? recipeBox;

  Future<void> openBox() async {
    recipeBox = await Hive.openBox<RecipeModel>('recipes');
  }

  Future<void> closeBox() async {
    await recipeBox!.close();
  }

  // Create
  Future<void> addRecipe(RecipeModel recipe) async {
    if (recipeBox == null) {
      await openBox();
    }
    await recipeBox!.add(recipe);
  }

  Future<List<RecipeModel>> getRecipe() async {
    if (recipeBox == null) {
      await openBox();
    }
    return recipeBox!.values.toList();
  }

  Future<void> deleteRecipe(int index) async {
    if (recipeBox == null) {
      await openBox();
    }
    await recipeBox!.deleteAt(index);
  }
}
