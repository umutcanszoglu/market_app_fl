import 'package:flutter_bloc/flutter_bloc.dart';

class CountCubit extends Cubit<int> {
  CountCubit() : super(1);

  void add() {
    emit(state + 1);
  }

  void refresh() {
    emit(1);
  }

  void remove() {
    if (state != 1) {
      emit(state - 1);
    }
  }

  // void totalPrice(int price) {
  //   emit(state * price);
  // }
}
