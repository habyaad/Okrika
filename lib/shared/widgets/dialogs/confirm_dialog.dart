import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../custom_text.dart';

class CustomNoticeDialog extends StatelessWidget {
  final void Function() buttonFunction;

  static show(BuildContext context, void Function() buttonFunction) {
    showDialog(
        context: context,
        barrierColor: AppColors.appGrey.withOpacity(0.8),
        barrierDismissible: false,
        builder: (context) {
          return CustomNoticeDialog._(
            buttonFunction: buttonFunction,
          );
        });
  }

  const CustomNoticeDialog._({
    required this.buttonFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      backgroundColor: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(15)),
        width: double.infinity,
        //height: 223,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              title: "Confirm",
              size: 14,
              weight: FontWeight.w700,
            ),
            const SizedBox(
              height: 24,
            ),
            const Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info,
                  size: 24,
                  color: AppColors.appOrange,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: CustomText(
                    title: "Delete this product?",
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: buttonFunction,
                  child: Container(
                    width: 87,
                    height: 41,
                    decoration: BoxDecoration(
                        color: AppColors.appOrange,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: const Text(
                      "Delete",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                // GeneralButton(
                //   buttonText: button1Text,
                //   onPressed: button1Function,
                //   width: 87,
                //   height: 41,
                //   fontSize: 14,
                //   borderRadius: 8,
                // ),
                const SizedBox(
                  width: 12,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 87,
                    height: 41,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.appOrange,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                        color: AppColors.appDark700,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                // GeneralButton(
                //   buttonText: button2Text,
                //   onPressed: button2Function,
                //   width: 87,
                //   height: 41,
                //   borderRadius: 8,
                //   textColor: AppColors.karotGray3,
                //   fontSize: 14,
                //   fontWeight: FontWeight.w400,
                //   buttonColor: Colors.white,
                //   border: Border.all(
                //     color: AppColors.karotOrange,
                //   ),
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
