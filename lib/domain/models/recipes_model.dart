import 'package:hive/hive.dart';

part 'recipes_model.g.dart'; // Needed for the TypeAdapter

@HiveType(typeId: 0) // Specify a unique typeId
class RecipeModel {
  @HiveField(0)
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
    this.imageUrl =
        'no image', // Assign default empty string if no URL is provided
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
      imageUrl: json['imageUrl'] ?? 'no image', // Set empty string if null
      description: json['description'],
      cookingTime: json['cookingTime'],
      ingredients: json['ingredients'],
    );
  }

  get key => null;
}
