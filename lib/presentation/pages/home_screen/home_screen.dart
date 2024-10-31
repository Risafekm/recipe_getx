import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
import 'package:recipe_getx/domain/services/recipe_service.dart';
import 'package:recipe_getx/infrastructure/controller/recipe_controller.dart';
import 'package:recipe_getx/presentation/pages/home_screen/description_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize RecipeController
    final RecipeController recipeController = Get.put(RecipeController());
    recipeController.loadRecipes();

    final List languages = [
      {"name": "English", "locale": const Locale('en', 'US')},
      {"name": "Malayalam", "locale": const Locale('ml', 'IN')},
    ];

    void changeLanguage(Locale locale) {
      Get.back();
      final box = Hive.box('language');
      box.put('locale', '${locale.languageCode}_${locale.countryCode}');
      Get.updateLocale(locale);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home_appbar'.tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialogBox(context, languages, changeLanguage);
            },
            icon: const Icon(Icons.change_circle),
          ),
        ],
      ),
      body: Obx(() {
        if (recipeController.recipes.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Text(
                'home_content'.tr,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }
        return ListView.builder(
          itemCount: recipeController.recipes.length,
          itemBuilder: (context, index) {
            final RecipeModel recipe = recipeController.recipes[index];
            return GestureDetector(
              onTap: () => Get.to(() => DescriptionScreen(recipeModel: recipe)),
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16, top: 6),
                child: Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: recipe.imageUrl.isNotEmpty
                              ? Image.network(
                                  recipe.imageUrl,
                                  height: 100,
                                  width: 100,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    height: 100,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child:
                                        const Center(child: Text('No image')),
                                  ),
                                )
                              : Container(
                                  height: 100,
                                  width: 100,
                                  decoration:
                                      const BoxDecoration(color: Colors.grey),
                                  child: const Center(child: Text('No image')),
                                ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 30),
                            child: Text(recipe.name,
                                style: const TextStyle(fontSize: 18)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10, top: 20),
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {
                                await recipeController.deleteRecipe(index);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Future<dynamic> showDialogBox(BuildContext context, List<dynamic> languages,
      void Function(Locale locale) changeLanguage) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Languages'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              itemCount: languages.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => changeLanguage(languages[index]['locale']),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      languages[index]['name'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        );
      },
    );
  }
}
