// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bootcamp_final/data/entity/foods.dart';

class FoodResponse {
  List<Foods> foods;
  int success;
  FoodResponse({
    required this.foods,
    required this.success,
  });

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    int success = json["success"] as int;
    var jsonArray = json["yemekler"] as List;

    List<Foods> foods = jsonArray.map((e) => Foods.fromJson(e)).toList();
    return FoodResponse(foods: foods, success: success);
  }
}
