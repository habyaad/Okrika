import 'package:flutter/material.dart';
import 'package:okrika/shared/utils/app_colors.dart';
import 'package:okrika/shared/widgets/custom_text.dart';
import 'package:okrika/shared/widgets/custom_text_form_field.dart';

class FilterBottomSheet extends StatelessWidget {
  static show(BuildContext context,
      {required TextEditingController minPriceController,
      required TextEditingController maxPriceController,
      required GlobalKey<FormState> key,
      required void Function() onPressed,
      required void Function() removeFilter}) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        builder: (context) {
          return FilterBottomSheet._(minPriceController, maxPriceController,
              onPressed, key, removeFilter);
        });
  }

  const FilterBottomSheet._(this.minPriceController, this.maxPriceController,
      this.onPressed, this.formKey, this.removeFilter);

  final TextEditingController minPriceController;
  final TextEditingController maxPriceController;
  final GlobalKey<FormState> formKey;
  final void Function() onPressed;
  final void Function() removeFilter;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Align(
                alignment: Alignment.center,
                child: CustomText(
                  title: "Filter",
                  weight: FontWeight.w600,
                  size: 18,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomText(
                        title: "By price",
                        weight: FontWeight.w500,
                        size: 16,
                      ),
                      Icon(
                        Icons.keyboard_arrow_right_rounded,
                        size: 18,
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: removeFilter,
                    child: const CustomText(
                      title: "Remove filter",
                      weight: FontWeight.w500,
                      color: AppColors.appRed,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: "Min Price",
                          weight: FontWeight.w500,
                          size: 12,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: minPriceController,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomText(
                          title: "Max Price",
                          weight: FontWeight.w500,
                          size: 12,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        CustomTextFormField(
                          keyboardType: TextInputType.number,
                          controller: maxPriceController,
                        )
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              InkWell(
                onTap: onPressed,
                child: Ink(
                  width: double.infinity,
                  height: 58,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.appOrange),
                  child: const Center(
                    child: CustomText(
                      title: "Apply filter",
                      size: 16,
                      weight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
