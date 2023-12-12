import 'package:bootcamp_final/data/entity/foods.dart';
import 'package:bootcamp_final/ui/cubit/main_page_cubit.dart';
import 'package:bootcamp_final/ui/views/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:type_text/type_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<MainPageCubit>().getFoods();
  }

  @override
  Widget build(BuildContext context) {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/";
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(
            Icons.shopping_cart,
            size: 35,
            color: Colors.redAccent,
          ),
        ),
        title: TypeText(
          "Foods",
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          duration: 500.ms,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<MainPageCubit, List<Foods>>(
        builder: (context, foods) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListView.builder(
              itemCount: foods.length,
              itemBuilder: (context, index) {
                var food = foods[index];
                return Align(
                    child: Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: Hero(
                          tag: food.picture,
                          child: Image.network(baseUrl + food.picture),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  food.name,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Price: ${food.price} ₺",
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            const Spacer(),
                            CircleAvatar(
                              backgroundColor: Colors.redAccent,
                              child: IconButton(
                                color: Colors.white,
                                onPressed: () {
                                  Get.to(DetailPage(food: food));
                                },
                                icon: const Icon(Icons.add),
                              ),
                            )
                                .animate(onPlay: (controller) => controller.repeat())
                                .shimmer(delay: 300.ms, duration: 1800.ms),
                            const SizedBox(width: 8),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn().scale().move(delay: 300.ms, duration: 600.ms));
              },
            ),
          );
        },
      ),
    );
  }
}
