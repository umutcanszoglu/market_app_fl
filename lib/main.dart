import 'package:bootcamp_final/ui/cubit/cart_page_cubit.dart';
import 'package:bootcamp_final/ui/cubit/count_cubit.dart';
import 'package:bootcamp_final/ui/cubit/detail_page_cubit.dart';
import 'package:bootcamp_final/ui/cubit/main_page_cubit.dart';
import 'package:bootcamp_final/ui/views/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainPageCubit()),
        BlocProvider(create: (context) => DetailPageCubit()),
        BlocProvider(create: (context) => CartPageCubit()),
        BlocProvider(create: (context) => CountCubit()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Market App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
          useMaterial3: true,
        ),
        home: const BottomNavigationPage(),
      ),
    );
  }
}
