import 'package:bootcamp_final/data/entity/carts.dart';

class Helper {
  //isimleri aynı olan cart itemlerini birleştrien fonks.
  static List<Carts> aggregateCarts(List<Carts> carts) {
    final map = <String, Carts>{};
    for (var cart in carts) {
      if (map.containsKey(cart.name)) {
        final countBefore = int.tryParse(map[cart.name]!.count) ?? 0;
        final countAfter = int.tryParse(cart.count) ?? 0;
        map[cart.name]!.count = (countBefore + countAfter).toString();
      } else {
        map[cart.name] = cart.copyWith();
      }
    }

    final result = map.values.toList();

    for (var cart in result) {
      final price = int.parse(cart.price);
      final count = int.parse(cart.count);

      cart.price = (price * count).toString();
    }
    return result;
  }
}
