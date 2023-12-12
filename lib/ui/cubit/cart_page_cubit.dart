import 'package:bootcamp_final/data/entity/carts.dart';
import 'package:bootcamp_final/data/repo/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPageCubit extends Cubit<List<Carts>> {
  CartPageCubit() : super(<Carts>[]);

  var foodRepo = FoodRepository();

  Future<void> getCarts(String username) async {
    var carts = await foodRepo.getCartFoods(username);

    emit(carts);
  }

  Future<void> deleteCart(String name, String username) async {
    var carts = <Carts>[];
    //ismi aynı olmayanları çıkardık ve ismi aynı olanları da backendden sildik.
    for (var cart in state) {
      if (cart.name != name) {
        carts.add(cart);
      } else {
        await foodRepo.deleteToCart(cart.id, username);
      }
    }
    emit(carts);
  }
}
