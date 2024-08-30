import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';
import 'package:ration_go/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myorders extends StatefulWidget {
  const Myorders({Key? key}) : super(key: key);

  @override
  _MyordersState createState() => _MyordersState();
}

class _MyordersState extends State<Myorders> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  var orders = [];

  Future fetchData() async {
    Dio _dio = Dio();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      final response =
          await _dio.post('${ServerConstants.server_url}/get_my_orders',
              options: Options(headers: {
                "Authorization": "Bearer ${prefs.getString("access_token")}",
              }));

      if (response.statusCode == 200) {
        print(response.data['orders']);
        orders = response.data['orders'];
        setState(() {});
      } else {
        print('error');
      }
    } catch (e) {
      print(e);
    }
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
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title:
            const Text('RationGo!', style: TextStyle(color: AppColors.primary)),
      ),
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavbar(2),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
        child: orders.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(orders[index]['order_id']),
                      subtitle: Text('Order $index'),
                      trailing: Text('Order $index'),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
