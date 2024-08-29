import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          title: const Text('RationGo!',
              style: TextStyle(color: AppColors.primary)),
        ),
        backgroundColor: Colors.white,
        body: Placeholder());
  }
}
