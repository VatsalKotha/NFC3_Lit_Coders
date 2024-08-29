import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as Tr;
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';
import 'package:ration_go/features/auth/bloc/auth_bloc.dart';
import 'package:ration_go/features/home/ui/bottomsheet.dart';
import 'package:ration_go/features/product/bloc/product_bloc.dart';
import 'package:ration_go/features/product/ui/product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imageUrls = [
    'https://res.cloudinary.com/di9sgzulx/image/upload/v1724943264/phxu9orflcjb1oxkllvz.webp',
    'https://res.cloudinary.com/di9sgzulx/image/upload/v1724943263/lw84urfcew9ophjbfpqo.jpg',
    'https://res.cloudinary.com/di9sgzulx/image/upload/v1724943263/ypycgvm6kl5yemqiycqn.png',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<ProductBloc>().add(GetProducts());
    getorderType();
  }

  var order_type = 'Delivery';

  getorderType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    order_type = await prefs.getString('order_type') ?? 'Delivery';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColors.primary,
            AppColors.primary,
          ]),
          shape: BoxShape.circle,
        ),
        child: IconButton(
          onPressed: () {
            Get.toNamed('/cart');
          },
          icon: Icon(Icons.shopping_cart, color: Colors.white),
        ),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavbar(0),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is ProductLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProductSuccess) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: false,
                  expandedHeight: 150.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primary,
                            AppColors.primary.withAlpha(120),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(25, 50, 25, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    // Icon(Icons.location_on,
                                    //     color: Colors.white, size: 20),
                                    // const SizedBox(width: 4),
                                    Text(
                                      order_type,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    InkWell(
                                      onTap: () async {
                                        Get.bottomSheet(Bottomsheet(state))
                                            .then((value) => getorderType());
                                      },
                                      child: Icon(
                                          Icons.expand_circle_down_outlined,
                                          color: Colors.white,
                                          size: 20),
                                    ),
                                  ],
                                ),
                                Text(
                                  order_type == 'Delivery'
                                      ? state.user['address']
                                      : state.fps_store['address'],
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: TextField(
                                onSubmitted: (value) {
                                  Get.offAll(
                                      () => ProductScreen(
                                            searchQuery: value,
                                          ),
                                      transition: Tr.Transition.noTransition);
                                },
                                decoration: InputDecoration(
                                  hintText: 'Search for products...',
                                  border: InputBorder.none,
                                  icon: Icon(Icons.search,
                                      color: AppColors.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Explore Categories",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black)),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => Get.toNamed('/product'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: AppColors.secondary,
                                        ),
                                        Image.network(
                                          'https://res.cloudinary.com/di9sgzulx/image/upload/v1724942290/ztcyjvoecnrgtc76ha6m.png',
                                          height: 55,
                                          fit: BoxFit.fitHeight,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Food\nGrains",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => Get.toNamed('/product'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: AppColors.secondary,
                                        ),
                                        Image.network(
                                          'https://res.cloudinary.com/di9sgzulx/image/upload/v1724962521/oahfrqwlsjidkoa2jcy9.webp',
                                          height: 70,
                                          fit: BoxFit.fitHeight,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Cooking\nEssentials",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => Get.toNamed('/product'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: AppColors.secondary,
                                        ),
                                        Image.network(
                                          'https://res.cloudinary.com/di9sgzulx/image/upload/v1724962521/driv3jst4clkq4veehx5.png',
                                          height: 60,
                                          fit: BoxFit.fitHeight,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Pulses\n& Spices",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black)),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => Get.toNamed('/product'),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        CircleAvatar(
                                          radius: 35,
                                          backgroundColor: AppColors.secondary,
                                        ),
                                        Image.network(
                                          'https://res.cloudinary.com/di9sgzulx/image/upload/v1724962520/dk0u3pusvkhljvlogfku.png',
                                          height: 60,
                                          fit: BoxFit.fitHeight,
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Text("Fuel\n& Gas",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 14,
                                            height: 1,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.black)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(color: Colors.grey.shade300),
                        //

                        const Text("Explore Products",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.black)),
                        SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: state.products,
                            )),
                        Divider(color: Colors.grey.shade300),
                        //
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 160,
                              autoPlay: true,
                              aspectRatio: 16 / 9,
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                            ),
                            items: imageUrls.map((url) {
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Image.network(
                                  url,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }
}
