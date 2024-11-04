// To parse this JSON data, do
//
//     final fetchModel = fetchModelFromJson(jsonString);

import 'dart:convert';

List<FetchModel> fetchModelFromJson(String str) =>
    List<FetchModel>.from(json.decode(str).map((x) => FetchModel.fromJson(x)));

String fetchModelToJson(List<FetchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FetchModel {
  String id;
  String name;
  String imageUrl;
  String cookingTime;
  String ingredients;
  String making;

  FetchModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.cookingTime,
    required this.ingredients,
    required this.making,
  });

  factory FetchModel.fromJson(Map<String, dynamic> json) => FetchModel(
        id: json["id"],
        name: json["name"],
        imageUrl: json['imageUrl'] ?? 'no image', // Set empty string if null
        cookingTime: json["cooking_time"],
        ingredients: json["ingredients"],
        making: json["making"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "imageUrl": imageUrl,
        "cooking_time": cookingTime,
        "ingredients": ingredients,
        "making": making,
      };
}
