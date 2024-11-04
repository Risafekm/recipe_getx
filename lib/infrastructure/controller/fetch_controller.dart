import 'package:get/get.dart';
import 'package:recipe_getx/domain/models/fetch_model/fetch_model.dart';
import 'package:recipe_getx/domain/services/api_service.dart';

class FetchController extends GetxController {
  RxList<FetchModel> fetchList = <FetchModel>[].obs;
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchRecipes();
    super.onInit();
  }

  void fetchRecipes() async {
    try {
      isLoading(true);
      var recipes = await apiService.fetchRecipes();
      if (recipes != null) {
        fetchList.assignAll(recipes);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading(false);
    }
  }
}
