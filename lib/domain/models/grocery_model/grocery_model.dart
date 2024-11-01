// lib/domain/models/grocery_model/grocery_model.dart
import 'package:hive/hive.dart';

part 'grocery_model.g.dart';

@HiveType(typeId: 1)
class GroceryModel {
  @HiveField(0)
  final String name;

  @HiveField(1) // Field for checkbox state
  bool isChecked;

  GroceryModel({
    required this.name,
    bool? isChecked, // Accept null and set default
  }) : isChecked = isChecked ?? false; // Default to false if null

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'isChecked': isChecked,
    };
  }

  // Convert from JSON
  factory GroceryModel.fromJson(Map<String, dynamic> json) {
    return GroceryModel(
      name: json['name'],
      isChecked: json['isChecked'] ?? false, // Default to false if null
    );
  }
}
