import 'package:bootcamp_final/data/repo/test_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPageCubit extends Cubit<void> {
  DetailPageCubit() : super(0);

  var testRepo = TestRepository();

  Future<void> addToCart(
      String name, String picture, String price, String count, String username) async {
    await testRepo.addToCart(name, picture, price, count, username);
  }
}
