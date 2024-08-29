import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';
import 'package:ration_go/features/product/bloc/product_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    context.read<ProductBloc>().add(GetProducts());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

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
      bottomNavigationBar: bottomNavbar(1),
      body: BlocListener<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccess && searchController.text.isNotEmpty) {
            // Optionally handle any actions you want when products are successfully loaded and search is active
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is ProductSuccess) {
                  var filteredProducts = state.products.where((product) {
                    return product.product_name
                        .toLowerCase()
                        .contains(searchController.text.toLowerCase());
                  }).toList();

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {}); // This will refresh the UI
                          },
                          decoration: InputDecoration(
                            hintText: 'Search for items...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: AppColors.black),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (searchController.text.isNotEmpty)
                        const Text("Search Results",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black)),
                      if (searchController.text.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: filteredProducts
                                .map((product) => product)
                                .toList(),
                          ),
                        ),
                      if (searchController.text.isNotEmpty)
                        Divider(color: Colors.grey.shade300),
                      //
                      const Text("Food Grains",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.products
                                .where((product) =>
                                    product.product_category == "Food Grains")
                                .toList(),
                          )),
                      Divider(color: Colors.grey.shade300),
                      //
                      const Text("Cooking Essentials",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.products
                                .where((product) =>
                                    product.product_category == "Essentials")
                                .toList(),
                          )),
                      Divider(color: Colors.grey.shade300),
                      //
                      const Text("Pulses and Spices",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)),
                      SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: state.products
                                .where((product) =>
                                    product.product_category == "Pulses")
                                .toList(),
                          )),
                      Divider(color: Colors.grey.shade300),
                      //
                      const Text("Fuel and Gas",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)),
                      if (true)
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: state.products
                                  .where((product) =>
                                      product.product_category == "Fuel")
                                  .toList(),
                            )),
                    ],
                  );
                } else {
                  return const Center(
                    child: Text('Error loading products'),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
