import 'package:flutter/material.dart';
import 'package:ration_go/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                          Text(
                            'Ration at Ease',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              height: 0,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
    ;
  }
}
