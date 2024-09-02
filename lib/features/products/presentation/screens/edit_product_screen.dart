import 'dart:developer';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okrika/features/products/presentation/providers/fetch_categories_provider.dart';
import 'package:okrika/shared/services/toast_service.dart';
import 'package:okrika/shared/utils/app_colors.dart';
import 'package:okrika/shared/utils/validator.dart';
import 'package:okrika/shared/widgets/custom_appbar.dart';
import 'package:okrika/shared/widgets/custom_text.dart';
import 'package:okrika/shared/widgets/custom_text_form_field.dart';
import '../../../../shared/widgets/dialogs/loading_dialog.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';
import '../providers/fetch_products_provider.dart';
import '../providers/fetch_single_product_provider.dart';

class EditProductScreen extends ConsumerStatefulWidget {
  final int productID;

  const EditProductScreen(this.productID, {super.key});

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final SingleSelectController<CategoryModel> categoryController =
      SingleSelectController(null);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProductModel? fetchProduct;
  List<CategoryModel>? categories;

  Future<void> editProduct() async {
    Map<String, dynamic> product = {
      'name': nameController.text,
      'price': priceController.text,
      'category': categoryController.value?.id, // Electronics
      'description': descriptionController.text,
    };
    if (kDebugMode) {
      print(product);
    }
    LoadingDialog.show(context);
    try {
      await Future.delayed(const Duration(seconds: 1), () async {
        await ref
            .read(fetchProductsProvider.notifier)
            .editProduct(widget.productID, product);
      });
      if (!mounted) return;
      Navigator.pop(context);
      ToastService.success(context, "Product edited successfully");
    } catch (e) {
      Navigator.pop(context);
      ToastService.error(context, e.toString());
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      fetchProduct =
          await ref.read(fetchSingleProductProvider(widget.productID).future);
      categories = await ref.read(fetchCategoriesProvider.future);
      loadDetails();
    });

    super.initState();
  }

  loadDetails() {
    setState(() {
      nameController.text = fetchProduct!.name.toString();
      priceController.text = fetchProduct!.price.toString();
      descriptionController.text = fetchProduct!.description.toString();

      categoryController.value = categories
          ?.where((category) => fetchProduct?.category == category.id)
          .first;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoryModel>> fetchCategories =
        ref.read(fetchCategoriesProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: InkWell(
          onTap: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              editProduct();
            }
          },
          child: Ink(
            width: double.infinity,
            height: 58,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.appOrange),
            child: const Center(
              child: CustomText(
                title: "Edit Product",
                size: 16,
                weight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      appBar: const CustomAppBar(
        verticalPadding: 10,
        title: "Edit Product",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                const CustomText(
                  title: "Name",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Enter product name",
                  controller: nameController,
                  validator: (val) => Validator.validateName(val),
                ),
                const SizedBox(
                  height: 24,
                ),
                const CustomText(
                  title: "Description",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Enter product description",
                  minLine: 3,
                  maxLine: 3,
                  maxLength: 300,
                  controller: descriptionController,
                  validator: (val) => Validator.validateMaxiMin(val, 3, 300),
                ),
                const SizedBox(
                  height: 24,
                ),
                const CustomText(
                  title: "Price",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                CustomTextFormField(
                  hintText: "Enter product price",
                  keyboardType: TextInputType.number,
                  controller: priceController,
                  validator: (val) => Validator.validatePrice(val),
                ),
                const SizedBox(
                  height: 24,
                ),
                const CustomText(
                  title: "Category",
                  size: 16,
                  weight: FontWeight.w500,
                ),
                const SizedBox(
                  height: 12,
                ),
                switch (fetchCategories) {
                  AsyncData(:final value) => CustomDropdown<CategoryModel>(
                      hintText: 'Select product category',
                      controller: categoryController,
                      items: value.skip(1).toList(),
                      listItemBuilder: (context, val, _, __) {
                        return CustomText(
                          title: val.category,
                        );
                      },
                      headerBuilder: (context, val, _) {
                        return CustomText(
                          title: val.category,
                        );
                      },
                      //controller: categoryController,
                      decoration: const CustomDropdownDecoration(
                        closedFillColor: AppColors.appLight20,
                      ),
                      onChanged: (value) {
                        log('changing value to: $value');
                      },
                      validator: (val) {
                        if (val == null) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  AsyncError() =>
                    const Text('Oops, something unexpected happened'),
                  _ => const CustomShimmer(
                      height: 40,
                    ),
                },
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
