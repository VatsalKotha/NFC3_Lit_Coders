import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ration_go/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController rationNumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30, 80, 30, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'RationGo!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        height: 1),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Ration at Ease',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 0,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/svg/login.svg',
                    height: 250,
                  ),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                margin: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                decoration: const BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: rationNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ration number';
                    }
                    return null;
                  },
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                  decoration: const InputDecoration(
                    hintText: "Enter Ration Number",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12),
                    isDense: true,
                  ),
                  onChanged: ((value) {}),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 5, 18, 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          AppColors.primary,
                          AppColors.primary.withAlpha(120),
                        ]),
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(15))),
                child: const Center(
                    child: Text(
                  "Proceed",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
