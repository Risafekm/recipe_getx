// lib/models/recipe_model.dart
import 'package:hive/hive.dart';

part 'recipes_model.g.dart'; // Needed for the TypeAdapter

@HiveType(typeId: 0) // Specify a unique typeId
class RecipeModel {
  @HiveField(0) // The field index must match the one used in the model
  final String name;

  @HiveField(1)
  final String imageUrl;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String cookingTime;

  @HiveField(4)
  final String ingredients;

  RecipeModel({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.cookingTime,
    required this.ingredients,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'cookingTime': cookingTime,
      'ingredients': ingredients,
    };
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      cookingTime: json['cookingTime'],
      ingredients: json['ingredients'],
    );
  }
}
