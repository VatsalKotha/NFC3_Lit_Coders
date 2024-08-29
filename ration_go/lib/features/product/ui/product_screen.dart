import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavbar(1),
      body: Padding(
          padding: EdgeInsets.fromLTRB(25, 60, 25, 0),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for items...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search, color: AppColors.primary),
                ),
              ),
            ),
          ])),
    );
  }
}
