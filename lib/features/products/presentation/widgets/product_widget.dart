import 'package:flutter/material.dart';
import 'package:okrika/features/products/presentation/screens/edit_product_screen.dart';
import 'package:okrika/shared/utils/app_colors.dart';
import '../../../../shared/widgets/custom_text.dart';
import '../../../../shared/widgets/dialogs/confirm_dialog.dart';
import '../../domain/models/product_model.dart';

class ProductDetails extends StatelessWidget {
  final ProductModel model;
  final void Function() onDelete;

  const ProductDetails({
    super.key,
    required this.model,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/product-view',
          arguments: model.id,
        );
      },
      child: AnimatedContainer(
        padding: const EdgeInsets.all(8),
        width: 160,
        decoration: BoxDecoration(
            color: AppColors.appLight20,
            borderRadius: BorderRadius.circular(12)),
        duration: const Duration(milliseconds: 500),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Hero(
              tag: "picture-container-${model.id}",
              child: Material(
                type: MaterialType.transparency,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 700),
                    height: 138,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/${model.imageUrl}.png"),
                            fit: BoxFit.cover)),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: PopupMenuButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: const Icon(
                            Icons.more_vert,
                            color: Colors.black,
                            size: 24,
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProductScreen(model.id!)));
                              },
                              child: const Text('Edit'),
                            ),
                            PopupMenuItem(
                              onTap: () {
                                CustomNoticeDialog.show(context, onDelete);
                              },
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ),
            const SizedBox(height: 8),

            // Product Name
            CustomText(
              title: model.name,
              size: 14,
              weight: FontWeight.w600,
            ),
            const SizedBox(height: 4),

            // Product Price
            CustomText(
              title: '\$${model.price?.toStringAsFixed(2)}',
              size: 12,
              color: AppColors.appBlue,
            ),
          ],
        ),
      ),
    );
  }
}
