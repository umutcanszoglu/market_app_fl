import 'package:bootcamp_final/data/entity/foods.dart';
import 'package:bootcamp_final/ui/cubit/count_cubit.dart';
import 'package:bootcamp_final/ui/cubit/detail_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:type_text/type_text.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.food});
  final Foods food;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/";
    return Scaffold(
      appBar: AppBar(
        title: TypeText(
          widget.food.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
          duration: 500.ms,
        ),
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  Hero(
                    tag: widget.food.picture,
                    child: Image.network(baseUrl + widget.food.picture),
                  )
                      .animate()
                      .shimmer(delay: 300.ms, duration: 1800.ms)
                      .shake(hz: 4, curve: Curves.easeInOutCubic)
                      .scaleXY(end: 1.1, duration: 600.ms)
                      .then(delay: 600.ms)
                      .scaleXY(end: 1 / 1.1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                          onPressed: () {
                            context.read<CountCubit>().remove();
                          },
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      BlocBuilder<CountCubit, int>(
                        builder: (context, state) {
                          return Text(
                            state.toString(),
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 16),
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        child: IconButton(
                          onPressed: () {
                            context.read<CountCubit>().add();
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<CountCubit, int>(
                        builder: (context, state) {
                          return Text(
                            "Total Price: ${int.parse(widget.food.price) * state} ₺",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<DetailPageCubit>().addToCart(
                                widget.food.name,
                                widget.food.picture,
                                widget.food.price,
                                context.read<CountCubit>().state.toString(),
                                "unique1",
                              );
                          context.read<CountCubit>().refresh();
                          Get.back();
                          Get.snackbar(
                            widget.food.name,
                            "Added!",
                            backgroundColor: Colors.green,
                            colorText: Colors.white,
                            duration: 900.ms,
                          );
                        },
                        child: const Text("Add To Cart")
                            .animate(onPlay: (controller) => controller.repeat())
                            .shimmer(delay: 300.ms, duration: 1800.ms),
                      ),
                    ],
                  ),
                  Lottie.asset("assets/cart.json", width: 100),
                ],
              ),
            ).animate().fadeIn(duration: 1000.ms).moveX(begin: 100),
          ],
        ),
      ),
    );
  }
}
