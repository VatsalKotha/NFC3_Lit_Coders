import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/constants.dart';
import 'package:ration_go/features/product/bloc/product_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
  }

  var total = 0.0;
  var order_type = 'Delivery';
  var payment_method = 'Online';
  var payment_id = Random().nextInt(1000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title:
            const Text('RationGo!', style: TextStyle(color: AppColors.primary)),
      ),
      backgroundColor: Colors.white,
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ProductSuccess) {
            if (state.cart_products.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Your cart is empty',
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
              );
            }
            total = 0.0;
            for (var i = 0; i < state.cart_products.length; i++) {
              total += state.cart_products[i].actual_price *
                  state.cart_products[i].quantity;
            }

            return Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('My Cart',
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.black,
                                fontWeight: FontWeight.w600)),
                        InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Text('Total: ₹ ' + total.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.cart_products.length,
                        itemBuilder: (context, index) {
                          return state.cart_products[index];
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Order Type:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  Text(order_type,
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600)),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        order_type == 'Delivery'
                                            ? order_type = 'Pickup'
                                            : order_type = 'Delivery';
                                      });
                                    },
                                    child: Icon(Icons.change_circle_outlined,
                                        color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    order_type == 'Delivery'
                                        ? 'Delivery by ' +
                                            state.fps_store[
                                                'next_available_date']
                                        : 'Pickup by ' +
                                            state.fps_store[
                                                'next_available_date'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600)),
                                Divider(color: Colors.grey.shade300),
                                Text(
                                    order_type == 'Delivery'
                                        ? state.user['address']
                                        : state.fps_store['store_name'] +
                                            ", " +
                                            state.fps_store['address'],
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.black,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Payment Method:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: AppColors.black,
                                      fontWeight: FontWeight.w600)),
                              Row(
                                children: [
                                  payment_method == "Online"
                                      ? Image.network(
                                          'https://res.cloudinary.com/di9sgzulx/image/upload/v1724971903/gtecrt2v3wnehfpiyj9p.png',
                                          height: 40,
                                        )
                                      : Text("Cash",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: AppColors.primary,
                                              fontWeight: FontWeight.w600)),
                                  payment_method == "Online"
                                      ? SizedBox(width: 0)
                                      : SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        payment_method == 'Online'
                                            ? payment_method = 'Cash'
                                            : payment_method = 'Online';
                                      });
                                    },
                                    child: Icon(Icons.change_circle_outlined,
                                        color: AppColors.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          InkWell(
                            onTap: () async {
                              if (payment_method == "Online") {
                                Razorpay().open({
                                  'key': 'rzp_test_1DP5mmOlF5G5ag',
                                  'amount': total * 100,
                                  'name': 'RationGo',
                                  'description': 'Payment for ration order',
                                });
                              }

                              Dio _dio = Dio();
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              try {
                                final response = await _dio.post(
                                    '${ServerConstants.server_url}/add_order',
                                    data: {
                                      "order_type": order_type,
                                      "payment_method": payment_method,
                                      "payment_id": payment_id,
                                    },
                                    options: Options(
                                        headers: {
                                          "Authorization":
                                              "Bearer ${prefs.getString("access_token")}",
                                        },
                                        validateStatus: (status) {
                                          return status! < 500;
                                        }));

                                if (response.statusCode == 200) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content:
                                          Text('Order Placed Successfully!'),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                  Get.back();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Failed to place order: ' +
                                          response.data['msg']),
                                      backgroundColor: AppColors.primary,
                                    ),
                                  );
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text('Error! Failed to place order'),
                                    backgroundColor: AppColors.primary,
                                  ),
                                );
                                print(e);
                              }
                            },
                            child: Container(
                              height: 60,
                              width: double.infinity,
                              padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        AppColors.primary,
                                        AppColors.primary.withAlpha(120),
                                      ]),
                                  color: AppColors.primary,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: const Center(
                                  child: Text(
                                "Place Order",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          } else {
            if (state is ProductFailure) {
              print(state.message);
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
