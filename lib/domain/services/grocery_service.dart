// lib/services/grocery_service.dart
import 'package:hive/hive.dart';
import 'package:recipe_getx/domain/models/grocery_model/grocery_model.dart';

class GroceryService {
  Box<GroceryModel>? groceryBox;

  Future<void> openBox() async {
    groceryBox = await Hive.openBox<GroceryModel>('grocery');
  }

  Future<void> closeBox() async {
    await groceryBox!.close();
  }

  // Create
  Future<void> addGrocery(GroceryModel grocery) async {
    if (groceryBox == null) {
      await openBox();
    }
    await groceryBox!.add(grocery);
  }

  // Read
  Future<List<GroceryModel>> getGrocery() async {
    if (groceryBox == null) {
      await openBox();
    }
    return groceryBox!.values.toList();
  }

  // Update
  Future<void> updateGrocery(int index, GroceryModel grocery) async {
    if (groceryBox == null) {
      await openBox();
    }
    await groceryBox!
        .putAt(index, grocery); // Update the item at the specified index
  }

  // Delete
  Future<void> deleteGrocery(int index) async {
    if (groceryBox == null) {
      await openBox();
    }
    await groceryBox!.deleteAt(index);
  }

  Future<void> saveReorderedGrocery(List<GroceryModel> groceryList) async {
    await groceryBox!.clear(); // Clear existing data
    for (final grocery in groceryList) {
      await groceryBox!.add(grocery); // Add items in new order
    }
  }
}
