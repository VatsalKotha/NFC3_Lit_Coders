part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class GetProducts extends ProductEvent {}

class AddToCart extends ProductEvent {
  final String productId;
  final int quantity;
  final double actual_price;
  final BuildContext context;

  AddToCart(this.productId, this.quantity, this.actual_price, this.context);
}
