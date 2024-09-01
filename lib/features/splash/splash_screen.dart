import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:okrika/shared/utils/app_colors.dart';

import '../../shared/widgets/custom_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed((const Duration(seconds: 2)), () {
      Navigator.of(context).pushReplacementNamed('/product-catalogue');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: LoadingIndicator(
              indicatorType: Indicator.orbit,
              colors: [Colors.blueGrey, Colors.redAccent],
              strokeWidth: 2,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Center(
            child: CustomText(
              title: "OKRIKA",
              size: 32,
              weight: FontWeight.w700,
              color: AppColors.appOrange,
            ),
          )
        ],
      ),
    );
  }
}
