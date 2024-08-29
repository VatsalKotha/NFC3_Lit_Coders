import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:meta/meta.dart';
import 'package:ration_go/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../common/server.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final Dio _dio;
  ProductBloc(this._dio) : super(ProductInitial()) {
    on<GetProducts>((event, emit) async {
      emit(ProductLoading());

      SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        final response =
            await _dio.post('${ServerConstants.server_url}/get_store_products',
                options: Options(headers: {
                  "Authorization": "Bearer ${prefs.getString("access_token")}",
                }));

        if (response.statusCode == 200) {
          List<Product> products = [];
          for (var product in response.data['products']) {
            products.add(Product(
              cart: product['cart'],
              price: product['price'].toDouble(),
              product_category: product['product_category'],
              product_id: product['product_id'],
              product_image: product['product_image'],
              product_name: product['product_name'],
              product_size: product['product_size'],
            ));
          }

          List<ProductCart> cart = [];

          for (var product in response.data['user']['cart']) {
            cart.add(ProductCart(
              product_id: product['product_id'],
              quantity: product['quantity'],
              actual_price: double.parse(product['actual_price'].toString()),
              product_name: product['product_name'],
            ));
          }
          emit(ProductSuccess(
            products,
            cart,
            response.data['user'],
            response.data['fps_store'],
          ));
        } else {
          emit(ProductFailure('Failed to send OTP'));
        }
      } catch (e) {
        emit(ProductFailure(e.toString()));
        print(e);
      }
    });

    on<AddToCart>((event, emit) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      try {
        final response =
            await _dio.post('${ServerConstants.server_url}/add_to_cart',
                data: {
                  "product_id": event.productId,
                  "quantity": event.quantity,
                  "actual_price": event.actual_price
                },
                options: Options(headers: {
                  "Authorization": "Bearer ${prefs.getString("access_token")}",
                }));

        if (response.statusCode == 200) {
          GetProducts();
          ScaffoldMessenger.of(event.context).showSnackBar(
            SnackBar(
              content: Text(response.data["msg"]),
              backgroundColor: AppColors.primary,
            ),
          );
        } else {
          emit(ProductFailure('Failed to update cart'));
        }
      } catch (e) {
        emit(ProductFailure(e.toString()));
      }
    });
  }
}
