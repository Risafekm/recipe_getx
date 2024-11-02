// lib/infrastructure/controller/grocery_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/domain/models/grocery_model/grocery_model.dart';
import 'package:recipe_getx/domain/services/grocery_service.dart';

class GroceryController extends GetxController {
  final GroceryService _groceryService = GroceryService();
  RxList<GroceryModel> grocery = <GroceryModel>[].obs;

  final TextEditingController nameController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    loadGrocery();

    // Set up a listener to update the grocery list in real-time
    Hive.box<GroceryModel>('grocery').listenable().addListener(() {
      loadGrocery();
    });
  }

  void addGrocery() async {
    final groceryItem = GroceryModel(
      name: nameController.text,
    );
    await _groceryService.addGrocery(groceryItem);
    clear();
    loadGrocery();
  }

  Future<void> loadGrocery() async {
    final fetchedGrocery = await _groceryService.getGrocery();
    grocery.assignAll(fetchedGrocery);
  }

  Future<void> deleteGrocery(int index) async {
    await _groceryService.deleteGrocery(index);
    update();
    loadGrocery();
  }

  void toggleCheckbox(int index, bool? value) {
    // Check if the value is null; if so, default it to false
    final bool isChecked = value ?? false;
    final currentItem = grocery[index];
    currentItem.isChecked = isChecked; // Update the isChecked property
    _groceryService.updateGrocery(
        index, currentItem); // Update the grocery in the service
    loadGrocery(); // Reload grocery items
  }

  void clear() {
    nameController.clear();
  }
}
