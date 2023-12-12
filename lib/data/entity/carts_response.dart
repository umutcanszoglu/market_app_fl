// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bootcamp_final/data/entity/carts.dart';

class CartsResponse {
  List<Carts> carts;
  int success;
  CartsResponse({
    required this.carts,
    required this.success,
  });

  factory CartsResponse.fromJson(Map<String, dynamic> json) {
    int success = json["success"] as int;
    var jsonArray = json["sepet_yemekler"] as List;

    List<Carts> carts = jsonArray.map((e) => Carts.fromJson(e)).toList();
    return CartsResponse(carts: carts, success: success);
  }
}
