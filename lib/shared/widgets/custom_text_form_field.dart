import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final Widget? suffixIcon;
  final Color? fillColor;
  final double? borderSize;
  final int? maxLine;
  final int? maxLength;
  final int? minLine;
  final InputBorder? border;
  final bool? obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField(
      {super.key,
      this.hintText,
      this.onChanged,
      this.suffixIcon,
      this.fillColor,
      this.controller,
      this.validator,
      this.keyboardType,
      this.border,
      this.obscureText,
      this.borderSize,
      this.maxLine,
      this.minLine,
      this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 1,
      minLines: minLine,
      maxLength: maxLength,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      validator: validator,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(left: 18, top: 16, bottom: 16, right: 5),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? AppColors.appLight20,
        hintText: hintText ?? '',
        hintStyle: const TextStyle(
            color: AppColors.medium300,
            fontSize: 15,
            fontWeight: FontWeight.w600),
        border: border ??
            OutlineInputBorder(
              borderSide:
                  BorderSide(width: borderSize ?? 1, color: AppColors.appGrey),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(width: borderSize ?? 1, color: AppColors.appGrey),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.medium200,
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(
            color: AppColors.appOrange,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
