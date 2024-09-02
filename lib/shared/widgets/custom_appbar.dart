import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double? verticalPadding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? centerTitle;
  final Widget? flexibleSpace;
  final Color? bgColor;
  final Color? titleColor;
  final bool showBorder;
  final bool? automaticallyImplyLeading;
  final void Function()? onPressed;

  const CustomAppBar(
      {super.key,
      required this.title,
      this.suffixIcon,
      this.onPressed,
      this.prefixIcon,
      this.flexibleSpace,
      this.bgColor,
      this.titleColor,
      this.verticalPadding,
      this.centerTitle,
      this.automaticallyImplyLeading,
      this.showBorder = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: 10, vertical: verticalPadding ?? 0),
      child: AppBar(
        flexibleSpace: flexibleSpace,
        scrolledUnderElevation: 0,
        centerTitle: centerTitle ?? true,
        automaticallyImplyLeading: automaticallyImplyLeading ?? false,
        elevation: 0,
        backgroundColor: bgColor ?? Colors.white,
        bottom: showBorder
            ? PreferredSize(
                preferredSize: const Size.fromHeight(1.0),
                child: Container(
                  color: AppColors.appLight30,
                  height: 1.0,
                ),
              )
            : null,
        title: CustomText(
          title: title,
          color: titleColor,
          size: 16,
          weight: FontWeight.w600,
        ),
        leading: prefixIcon ??
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Container(
                width: 45.0,
                height: 45.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEFEFE),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF1D1E20).withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(0, 0), // changes position of shadow
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    size: 16,
                  ),
                  color: Colors.black,
                  onPressed: () {
                    Navigator.pop(
                        context); // You can replace this with your custom action
                  },
                ),
              ),
            ),
        actions: [suffixIcon ?? const SizedBox()],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
