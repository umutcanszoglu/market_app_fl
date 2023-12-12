import 'dart:convert';

import 'package:bootcamp_final/data/entity/carts.dart';
import 'package:bootcamp_final/data/entity/carts_response.dart';
import 'package:bootcamp_final/data/entity/foods.dart';
import 'package:bootcamp_final/data/entity/foods_response.dart';
import 'package:dio/dio.dart';

class TestRepository {
  List<Foods> parseFoodResponse(String response) {
    return FoodResponse.fromJson(json.decode(response)).foods;
  }

  List<Carts> parseCartsResponse(String response) {
    return CartsResponse.fromJson(json.decode(response)).carts;
  }

  Future<List<Foods>> getFoods() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseFoodResponse(response.data.toString());
  }

  Future<void> addToCart(
      String name, String picture, String price, String count, String username) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi": name,
      "yemek_resim_adi": picture,
      "yemek_fiyat": price,
      "yemek_siparis_adet": count,
      "kullanici_adi": username,
    };
    await Dio().post(url, data: FormData.fromMap(data));
  }

  Future<List<Carts>> getCartFoods(String username) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": username};
    try {
      var response = await Dio().post(url, data: FormData.fromMap(data));
      return parseCartsResponse(response.data.toString());
    } catch (e) {
      return [];
    }
  }

  Future<void> deleteToCart(String id, String username) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var data = {"sepet_yemek_id": id, "kullanici_adi": username};
    await Dio().post(url, data: FormData.fromMap(data));
  }
}
