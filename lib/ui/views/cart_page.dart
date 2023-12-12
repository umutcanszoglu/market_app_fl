import 'package:bootcamp_final/data/entity/carts.dart';
import 'package:bootcamp_final/data/helper/helper.dart';
import 'package:bootcamp_final/ui/cubit/cart_page_cubit.dart';
import 'package:bootcamp_final/ui/views/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartPageCubit>().getCarts("unique1");
  }

  @override
  Widget build(BuildContext context) {
    var baseUrl = "http://kasimadalan.pe.hu/yemekler/resimler/";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your Cart",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocBuilder<CartPageCubit, List<Carts>>(
        builder: (context, carts) {
          var aggregate = Helper.aggregateCarts(carts);
          if (carts.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/empty.json"),
                  const Text("There is no item in your cart."),
                ],
              ),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: aggregate.length,
                    itemBuilder: (context, index) {
                      var cart = aggregate[index];
                      return Align(
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(8),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                height: 100,
                                child: Image.network(baseUrl + cart.picture),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cart.name,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text("Price:    ${cart.price}₺"),
                                  Text("Count:    ${cart.count}"),
                                ],
                              ),
                              const Spacer(),
                              CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: IconButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                        actionsPadding:
                                            const EdgeInsets.only(bottom: 16, left: 24, right: 24),
                                        actionsAlignment: MainAxisAlignment.center,
                                        title: const Text(
                                          "Do you want to remove?",
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const Text("No"),
                                              ),
                                              ElevatedButton(
                                                style: const ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll(Colors.redAccent),
                                                ),
                                                onPressed: () {
                                                  context
                                                      .read<CartPageCubit>()
                                                      .deleteCart(cart.name, cart.username);
                                                  Get.back();
                                                },
                                                child: const Text(
                                                  "Yes",
                                                  style: TextStyle(color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ).animate().fadeIn(duration: 500.ms).moveX(begin: 50),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 32),
                        const Text(
                          "Total price:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${aggregate.fold(0, (previousValue, element) => previousValue + int.parse(element.price))} ₺",
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.redAccent),
                        ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.redAccent,
                          child: IconButton(
                            onPressed: () {
                              Get.to(const BottomNavigationPage());
                              for (var cart in aggregate) {
                                context.read<CartPageCubit>().deleteCart(cart.name, cart.username);
                              }
                              Get.snackbar("Order Status", "Success",
                                  backgroundColor: Colors.green,
                                  colorText: Colors.white,
                                  duration: const Duration(seconds: 1));
                            },
                            icon: const Icon(
                              Icons.done_all,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
