import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:recipe_getx/domain/models/recipes_model.dart';
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
      {"name": "english".tr, "locale": const Locale('en', 'US')},
      {"name": "malayalam".tr, "locale": const Locale('ml', 'IN')},
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
              child: Dismissible(
                key: Key(recipe.name),
                background: Container(
                  color: Colors.red, // Background color when swiped
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  // Remove the item from the list and the database
                  recipeController.deleteRecipe(index);

                  // Show a snackbar after deletion
                  Get.snackbar(
                    'Deleted',
                    '${recipe.name} has been removed from the list',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
                confirmDismiss: (direction) async {
                  // Optionally confirm dismissal
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('This will delete the item.'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
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
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child:
                                          const Center(child: Text('No image')),
                                    ),
                                  )
                                : Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/no_image.png'),
                                          scale: .5,
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 30),
                              child: Text(recipe.name,
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
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
          title: Text('languages'.tr),
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
