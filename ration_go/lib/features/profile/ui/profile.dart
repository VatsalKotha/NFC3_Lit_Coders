import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ration_go/colors.dart';
import 'package:ration_go/common/bottom.dart';
import 'package:ration_go/features/product/bloc/product_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> userData = {
    "ration_card_no": "RC003",
    "name": "Vatsal Kotha",
    "fps_code": "FPS125",
    "fps_name": "Powai FPS",
    "members_list": [
      "Vatsal Kotha",
      "Meet Chavan",
      "Dhruv Mehta",
      "Gaurang Singhania"
    ],
    "total_monthly_quantity": 35.0,
    "current_quantity_consumed": 12.0,
    "has_LPG": true,
    "date_of_issue": "2018-09-12",
    "address": "B-304, , Mumbai, Maharashtra",
    "class_of_ration": "NPHH",
    "contact_number": "9123456789",
    "email": "vatsalkotha@example.com",
    "cart": []
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        title:
            const Text('RationGo!', style: TextStyle(color: AppColors.primary)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  color: Colors.grey.shade100,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.account_circle,
                            size: 80, color: AppColors.primary),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userData['name'],
                              style: const TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Ration Card No: ${userData['ration_card_no']}",
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                            Text(
                              userData['address'],
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Members List",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: AppColors.black)),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: userData['members_list'].length,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.grey.shade100,
                              elevation: 0,
                              margin: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: const EdgeInsets.all(8.0),
                                width: 120,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.person,
                                        size: 40, color: AppColors.primary),
                                    const SizedBox(height: 8),
                                    Text(
                                      userData['members_list'][index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Text("Ration Information",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8),
                  child: Card(
                    color: Colors.grey.shade100,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("FPS Name: ${userData['fps_name']}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text("FPS Code: ${userData['fps_code']}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                              "Class of Ration: ${userData['class_of_ration']}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                              "Total Monthly Quantity: ${userData['total_monthly_quantity']} kg",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text(
                              "Current Quantity Consumed: ${userData['current_quantity_consumed']} kg",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text("Has LPG: ${userData['has_LPG'] ? 'Yes' : 'No'}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
                Text("Contact Information",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black)),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    color: Colors.grey.shade100,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Contact Number: ${userData['contact_number']}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text("Email: ${userData['email']}",
                              style: const TextStyle(fontSize: 16)),
                          const SizedBox(height: 8),
                          Text("Date of Issue: ${userData['date_of_issue']}",
                              style: const TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      bottomNavigationBar: bottomNavbar(3),
    );
  }
}
