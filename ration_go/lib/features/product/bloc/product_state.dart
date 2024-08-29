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
  final String message;

  ProductSuccess(this.message);
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
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      width: 160,
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
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 60,
                      height: 70,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      decoration: BoxDecoration(
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
                      "https://res.cloudinary.com/di9sgzulx/image/upload/v1724942290/ztcyjvoecnrgtc76ha6m.png",
                      height: 80,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, 0, 8, 5),
            decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product_name,
                        style: TextStyle(
                            fontSize: 16,
                            color: AppColors.black,
                            fontWeight: FontWeight.w500)),
                    Text(
                        '₹' +
                            widget.price.toString() +
                            " / " +
                            widget.product_size,
                        style: TextStyle(
                            fontSize: 14,
                            height: 0,
                            color: Colors.grey.shade500,
                            fontWeight: FontWeight.w400)),
                  ],
                ),
                Container(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.remove, color: Colors.white, size: 20),
                      SizedBox(
                        width: 2,
                      ),
                      Text(widget.cart.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 16)),
                      SizedBox(
                        width: 2,
                      ),
                      Icon(Icons.add, color: Colors.white, size: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}