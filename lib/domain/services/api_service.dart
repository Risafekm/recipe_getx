// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:get/get.dart';
import 'package:recipe_getx/domain/models/fetch_model/fetch_model.dart';
import 'package:http/http.dart' as http;

class ApiService extends GetxService {
  final api =
      "https://recipe-risaf.muhammedhafiz.com/recipe_project/recipe/read_recipe.php";

  Future<List<FetchModel>?> fetchRecipes() async {
    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      var data = List<FetchModel>.from(
              jsonDecode(response.body).map((e) => FetchModel.fromJson(e)))
          .toList();
      return data; // Return the parsed data
    } else {
      throw Exception('Error fetching data');
    }
  }
}
