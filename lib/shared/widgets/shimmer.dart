import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/app_colors.dart';

class CustomShimmer extends StatelessWidget {
  final double height;

  const CustomShimmer({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
        period: const Duration(seconds: 2),
        //Default value
        loop: 1,
        enabled: true,
        //Default value
        direction: ShimmerDirection.ltr,
        gradient: LinearGradient(
            colors: [Colors.white, Colors.grey.withOpacity(.01)]),
        child: Container(
          decoration: BoxDecoration(
              color: AppColors.appGrey, borderRadius: BorderRadius.circular(8)),
          width: double.infinity,
          height: height,
        ));
  }
}
