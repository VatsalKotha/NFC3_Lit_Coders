import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
          emit(ProductSuccess(
            products,
          ));
        } else {
          emit(ProductFailure('Failed to send OTP'));
        }
      } catch (e) {
        emit(ProductFailure(e.toString()));
      }
    });
  }
}
