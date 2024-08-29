import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:ration_go/colors.dart';
import 'dart:async';

import 'package:ration_go/features/auth/bloc/auth_bloc_bloc.dart'; // Import for Timer

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController rationNumber = TextEditingController();
  String otp = '';
  bool isOtpSent = false;
  int _start = 30;
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startTimer() {
    setState(() {
      _start = 30;
    });
    _timer?.cancel();
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
                              onCodeChanged: (String code) {
                                otp = code;
                              },
                              onSubmit: (String verificationCode) {
                                otp = verificationCode;

                                context
                                    .read<AuthBlocBloc>()
                                    .add(LoginEvent(rationNumber.text, otp));
                              }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: _start == 0
                              ? () {
                                  startTimer();
                                  context
                                      .read<AuthBlocBloc>()
                                      .add(SendOtpEvent(rationNumber.text));
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
              BlocBuilder<AuthBlocBloc, AuthBlocState>(
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      startTimer();
                      if (isOtpSent) {
                        if (state is SendOtpSuccess) {
                          context
                              .read<AuthBlocBloc>()
                              .add(LoginEvent(rationNumber.text, otp));
                        }
                      } else {
                        context
                            .read<AuthBlocBloc>()
                            .add(SendOtpEvent(rationNumber.text));

                        setState(() {
                          isOtpSent = true;
                        });
                      }
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
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
