part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class ProductLoading extends ProductState {}

final class FetchProductLoaded extends ProductState {
  final List<Product> products;

  FetchProductLoaded(this.products);
}

final class ProductFailure extends ProductState {
  final String message;

  ProductFailure(this.message);
}

final class ProductSuccess extends ProductState {
  List<Product> products;
  List<ProductCart> cart_products;
  var user;
  var fps_store;

  ProductSuccess(this.products, this.cart_products, this.user, this.fps_store);
}

class Product extends StatefulWidget {
  int cart;
  double price;
  String product_category;
  String product_id;
  String product_image;
  String product_name;
  String product_size;

  Product(
      {this.cart = 0,
      this.price = 0.0,
      this.product_category = '',
      this.product_id = '',
      this.product_image = '',
      this.product_name = '',
      this.product_size = '',
      Key? key});

  @override
  _ProductStateState createState() => _ProductStateState();
}

class _ProductStateState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),

      width: 160,
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(8),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.grey.withOpacity(0.2),
      //       spreadRadius: 1,
      //       blurRadius: 5,
      //       offset: const Offset(0, 3),
      //     ),
      //   ],
      // ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 60,
                      height: 70,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: const BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Image.network(
                      widget.product_image,
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 5),
            decoration: const BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.product_name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500)),
                Text(
                    '₹' + widget.price.toString() + " / " + widget.product_size,
                    style: TextStyle(
                        fontSize: 14,
                        height: 0,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400)),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: widget.cart == 0
                            ? InkWell(
                                onTap: () => setState(() {
                                      widget.cart++;
                                      context.read<ProductBloc>().add(AddToCart(
                                          widget.product_id,
                                          widget.cart,
                                          widget.price,
                                          context));
                                    }),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Add to Cart',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 14)),
                                  ],
                                ))
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                      onTap: () => setState(() {
                                            widget.cart--;
                                            context.read<ProductBloc>().add(
                                                AddToCart(
                                                    widget.product_id,
                                                    widget.cart,
                                                    widget.price,
                                                    context));
                                          }),
                                      child: const Icon(Icons.remove,
                                          color: Colors.white, size: 20)),
                                  Text(widget.cart.toString(),
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  InkWell(
                                      onTap: () => setState(() {
                                            widget.cart++;
                                            context.read<ProductBloc>().add(
                                                AddToCart(
                                                    widget.product_id,
                                                    widget.cart,
                                                    widget.price,
                                                    context));
                                          }),
                                      child: const Icon(Icons.add,
                                          color: Colors.white, size: 20)),
                                ],
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductCart extends StatefulWidget {
  int quantity;
  double actual_price;
  String product_name;
  String product_id;

  ProductCart(
      {this.quantity = 0,
      this.actual_price = 0.0,
      this.product_name = '',
      this.product_id = '',
      Key? key});

  @override
  _ProductCart createState() => _ProductCart();
}

class _ProductCart extends State<ProductCart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.product_name,
                          style: const TextStyle(
                              fontSize: 16,
                              color: AppColors.black,
                              fontWeight: FontWeight.w500)),
                      Text(
                          '₹' +
                              widget.actual_price.toString() +
                              " * " +
                              widget.quantity.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              height: 0,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Text('₹' + (widget.actual_price * widget.quantity).toString(),
              style: TextStyle(
                  fontSize: 16,
                  height: 0,
                  color: Colors.grey.shade900,
                  fontWeight: FontWeight.w400)),
          Expanded(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: widget.quantity == 0
                  ? InkWell(
                      onTap: () => setState(() {
                            widget.quantity++;
                            context.read<ProductBloc>().add(AddToCart(
                                widget.product_id,
                                widget.quantity,
                                widget.actual_price,
                                context));
                          }),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Add to Cart',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14)),
                        ],
                      ))
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            onTap: () => setState(() {
                                  widget.quantity--;
                                  context.read<ProductBloc>().add(AddToCart(
                                      widget.product_id,
                                      widget.quantity,
                                      widget.actual_price,
                                      context));

                                  if (widget.quantity == 0) {
                                    context
                                        .read<ProductBloc>()
                                        .add(GetProducts());
                                  }
                                }),
                            child: const Icon(Icons.remove,
                                color: Colors.white, size: 20)),
                        Text(widget.quantity.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                        InkWell(
                            onTap: () => setState(() {
                                  widget.quantity++;
                                  context.read<ProductBloc>().add(AddToCart(
                                      widget.product_id,
                                      widget.quantity,
                                      widget.actual_price,
                                      context));
                                  context
                                      .read<ProductBloc>()
                                      .add(GetProducts());
                                }),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 20)),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
