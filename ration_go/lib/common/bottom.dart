import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ration_go/colors.dart';

class bottomNavbar extends StatefulWidget {
  int currentIndex = 0;
  bottomNavbar(this.currentIndex, {Key? key}) : super(key: key);

  @override
  _BottomnavbarState createState() => _BottomnavbarState();
}

class _BottomnavbarState extends State<bottomNavbar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: AppColors.primaryAccent,
      showUnselectedLabels: true,
      enableFeedback: true,
      showSelectedLabels: true,
      selectedIconTheme: const IconThemeData(color: AppColors.black),
      unselectedIconTheme: IconThemeData(color: Colors.grey[600]),
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.black,
      selectedLabelStyle: const TextStyle(color: AppColors.black, fontSize: 14),
      unselectedLabelStyle:
          const TextStyle(color: AppColors.secondary, fontSize: 14),
      currentIndex: widget.currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home_outlined,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_outlined,
            ),
            label: 'Tests'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.pie_chart_outline_rounded,
          ),
          label: 'Reports',
        ),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.person_2_outlined,
            ),
            label: 'Profile'),
      ],
      onTap: (value) {
        if (value == 0 && widget.currentIndex != 0) {
          Get.offAllNamed('/home');
        }
        if (value == 1 && widget.currentIndex != 1) {
          Get.offAllNamed('/health_test');
        }
        if (value == 2 && widget.currentIndex != 2) {
          Get.offAllNamed('/reports');
        }
        if (value == 3 && widget.currentIndex != 3) {
          Get.offAllNamed('/Profile');
        }
      },
    );
  }
}
