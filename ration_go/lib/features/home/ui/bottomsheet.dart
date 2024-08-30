import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Bottomsheet extends StatefulWidget {
  final state;
  Bottomsheet(this.state, {Key? key}) : super(key: key);

  @override
  _BottomsheetState createState() => _BottomsheetState();
}

class _BottomsheetState extends State<Bottomsheet> {
  initState() {
    super.initState();
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
    return Container(
      height: 280,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Choose Order Method",
              style: TextStyle(
                  fontSize: 18,
                  color: AppColors.black,
                  fontWeight: FontWeight.w600)),
          Divider(color: Colors.grey.shade300),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('order_type', 'Delivery');
              order_type = 'Delivery';
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
              decoration: order_type == 'Delivery'
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withAlpha(120),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    )
                  : BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
              child: Row(
                children: [
                  Radio(
                      value: true,
                      groupValue: true,
                      fillColor: order_type == 'Delivery'
                          ? MaterialStateProperty.all(AppColors.white)
                          : MaterialStateProperty.all(AppColors.primary),
                      onChanged: (value) {}),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Delivery",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: order_type == 'Delivery'
                                      ? AppColors.white
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.state.fps_store['next_available_date'],
                              style: TextStyle(
                                  color: order_type == 'Delivery'
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          widget.state.user['address'],
                          style: TextStyle(
                              color: order_type == 'Delivery'
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(color: Colors.grey.shade300),
          InkWell(
            onTap: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString('order_type', 'Pickup');
              order_type = 'Pickup';
              setState(() {});
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(5, 10, 20, 10),
              decoration: order_type == 'Pickup'
                  ? BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withAlpha(120),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(22),
                    )
                  : BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(22),
                    ),
              child: Row(
                children: [
                  Radio(
                      value: true,
                      groupValue: true,
                      fillColor: order_type == 'Pickup'
                          ? MaterialStateProperty.all(AppColors.white)
                          : MaterialStateProperty.all(AppColors.primary),
                      onChanged: (value) {}),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Pickup",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: order_type == 'Pickup'
                                      ? AppColors.white
                                      : AppColors.primary,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              widget.state.fps_store['next_available_date'],
                              style: TextStyle(
                                  color: order_type == 'Pickup'
                                      ? AppColors.white
                                      : AppColors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Text(
                          widget.state.fps_store['store_name'] +
                              ", " +
                              widget.state.fps_store['address'],
                          style: TextStyle(
                              color: order_type == 'Pickup'
                                  ? AppColors.white
                                  : AppColors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
