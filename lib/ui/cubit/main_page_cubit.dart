import 'package:bootcamp_final/data/entity/foods.dart';
import 'package:bootcamp_final/data/repo/food_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageCubit extends Cubit<List<Foods>> {
  MainPageCubit() : super(<Foods>[]);

  var foodRepo = FoodRepository();

  Future<void> getFoods() async {
    var foods = await foodRepo.getFoods();
    emit(foods);
  }
}
