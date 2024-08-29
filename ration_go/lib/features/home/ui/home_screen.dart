import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';
import 'package:ration_go/features/auth/bloc/auth_bloc.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomNavbar(0),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: false,
            expandedHeight: 140.0,
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
                  padding: const EdgeInsets.fromLTRB(25, 70, 25, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on,
                              color: Colors.white, size: 20),
                          const SizedBox(width: 4),
                          const Text(
                            'Delivery',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Icon(Icons.expand_circle_down_outlined,
                              color: Colors.white, size: 20),
                        ],
                      ),
                      const Text(
                        'Andheri, Maharashtra',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for products...',
                            border: InputBorder.none,
                            icon: Icon(Icons.search, color: AppColors.black),
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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 140,
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
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
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Explore Products',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColors.black,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondary,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Rice',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('₹20/kg',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    height: 0,
                                                    color: Colors.grey.shade500,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.remove,
                                                  color: Colors.white,
                                                  size: 20),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("1",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(Icons.add,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondary,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Wheat',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('₹25/kg',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    height: 0,
                                                    color: Colors.grey.shade500,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.remove,
                                                  color: Colors.white,
                                                  size: 20),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("2",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(Icons.add,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 180,
                        width: double.infinity,
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                              padding:
                                  const EdgeInsets.fromLTRB(10, 10, 10, 10),
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
                                              margin: EdgeInsets.fromLTRB(
                                                  0, 10, 0, 0),
                                              decoration: BoxDecoration(
                                                color: AppColors.secondary,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Sugar',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: AppColors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Text('₹30/kg',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    height: 0,
                                                    color: Colors.grey.shade500,
                                                    fontWeight:
                                                        FontWeight.w400)),
                                          ],
                                        ),
                                        Container(
                                          height: 30,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(Icons.remove,
                                                  color: Colors.white,
                                                  size: 20),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("1",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16)),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Icon(Icons.add,
                                                  color: Colors.white,
                                                  size: 20),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
