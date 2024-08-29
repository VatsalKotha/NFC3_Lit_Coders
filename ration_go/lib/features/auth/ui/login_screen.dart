import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ration_go/colors.dart';
import 'dart:async'; // Import for Timer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController rationNumber = TextEditingController();
  bool isOtpSent = false;
  int _start = 60; // 1 minute
  Timer? _timer;

  @override
  void dispose() {
    _timer
        ?.cancel(); // Cancel the timer if it’s active when the widget is disposed
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _start = 60; // Reset the timer to 60 seconds
    });
    _timer?.cancel(); // Cancel any previous timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

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
              SizedBox(
                height: 20,
              ),
              !isOtpSent
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Text('Ration Card Number',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          decoration: const BoxDecoration(
                              color: AppColors.secondary,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: rationNumber,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
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
                              hintText: "Enter Ration Card Number",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 12),
                              isDense: true,
                            ),
                            onChanged: ((value) {}),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            Text('Enter the OTP Received',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: OtpTextField(
                            numberOfFields: 6,
                            borderColor: AppColors.primary,
                            showFieldAsBox: false,
                            onCodeChanged: (String code) {},
                            onSubmit: (String verificationCode) {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Verification Code"),
                                      content: Text(
                                          'Code entered is $verificationCode'),
                                    );
                                  });
                            },
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: _start == 0
                              ? () {
                                  // Reset the timer and resend the OTP
                                  startTimer();
                                  // Add logic to resend OTP here
                                }
                              : null,
                          child: Text(
                            _start == 0
                                ? 'Resend OTP'
                                : 'Resend OTP in $_start seconds',
                            style: TextStyle(
                                fontSize: 16,
                                color: _start == 0
                                    ? AppColors.primary
                                    : Colors.grey,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isOtpSent = true;
                  });
                  startTimer(); // Start the timer when OTP is sent
                },
                child: Container(
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
                      borderRadius:
                          const BorderRadius.all(Radius.circular(15))),
                  child: const Center(
                      child: Text(
                    "Proceed",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
