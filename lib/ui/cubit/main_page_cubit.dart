import 'package:bootcamp_final/data/entity/foods.dart';
import 'package:bootcamp_final/data/repo/test_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageCubit extends Cubit<List<Foods>> {
  MainPageCubit() : super(<Foods>[]);

  var testRepo = TestRepository();

  Future<void> getFoods() async {
    var foods = await testRepo.getFoods();
    emit(foods);
  }
}
