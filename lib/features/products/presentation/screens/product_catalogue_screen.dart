import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okrika/features/products/presentation/providers/fetch_categories_provider.dart';
import 'package:okrika/features/products/presentation/providers/filter_provider.dart';
import 'package:okrika/features/products/presentation/widgets/carousel_widget.dart';
import 'package:okrika/shared/utils/app_colors.dart';
import 'package:okrika/shared/widgets/custom_appbar.dart';
import 'package:okrika/shared/widgets/custom_text.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../../../shared/widgets/shimmer.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';
import '../providers/fetch_products_provider.dart';
import '../widgets/filter_bottomsheet.dart';
import '../widgets/product_widget.dart';

class ProductCatalogueScreen extends ConsumerStatefulWidget {
  const ProductCatalogueScreen({super.key});

  @override
  ConsumerState<ProductCatalogueScreen> createState() =>
      _ProductCatalogueScreenState();
}

class _ProductCatalogueScreenState
    extends ConsumerState<ProductCatalogueScreen> {
  int categoryFilter = 0;
  final TextEditingController minPriceController = TextEditingController();
  final TextEditingController maxPriceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<CategoryModel>> fetchCategories =
        ref.watch(fetchCategoriesProvider);
    final AsyncValue<List<ProductModel>> fetchProducts =
        ref.watch(fetchProductsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/create-product");
        },
        backgroundColor: AppColors.appOrange,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: CustomAppBar(
        verticalPadding: 10,
        title: "",
        prefixIcon: Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.appLight20,
          ),
          child: SvgPicture.asset(
            "assets/svgs/menu.svg",
            colorFilter: const ColorFilter.mode(
              Colors.black,
              BlendMode.srcIn,
            ),
            fit: BoxFit.scaleDown,
          ),
        ),
        suffixIcon: Container(
          height: 45,
          width: 45,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.appLight20,
          ),
          child: SvgPicture.asset(
            "assets/svgs/Bag.svg",
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const CustomText(
                title: "Hello",
                size: 24,
                weight: FontWeight.w600,
              ),
              const CustomText(
                title: "Welcome to Okrika",
                color: AppColors.appDark500,
              ),
              const SizedBox(
                height: 16,
              ),
              const CarouselWidget(),
              const SizedBox(
                height: 16,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: "Categories",
                    size: 16,
                    weight: FontWeight.w500,
                  ),
                  CustomText(
                    title: "See all",
                    size: 16,
                    weight: FontWeight.w500,
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 40,
                child: switch (fetchCategories) {
                  AsyncData(:final value) => ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: value.length, // Number of items in the list
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              categoryFilter = index;
                            });

                            ref
                                .read(filterProvider.notifier)
                                .setKey('category', categoryFilter + 1);
                            ref
                                .read(fetchProductsProvider.notifier)
                                .setFilter();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: categoryFilter == index
                                  ? AppColors.appOrange
                                  : AppColors.appLight40,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Center(
                              child: CustomText(
                                title: value[index].category,
                                color: categoryFilter == index
                                    ? Colors.white
                                    : null,
                                size: 16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 8,
                        );
                      },
                    ),
                  AsyncError() =>
                    const Text('Oops, something unexpected happened'),
                  _ => const CustomShimmer(
                      height: 40,
                    ),
                },
              ),
              const SizedBox(
                height: 12,
              ),
              Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      FilterBottomSheet.show(
                        context,
                        minPriceController: minPriceController,
                        maxPriceController: maxPriceController,
                        key: formKey,
                        onPressed: () {
                          //formKey.currentState!.save();
                          if (minPriceController.text.isNotEmpty) {
                            ref.read(filterProvider.notifier).setKey('minPrice',
                                double.tryParse(minPriceController.text));
                          } else {
                            ref
                                .read(filterProvider.notifier)
                                .removeKey("minPrice");
                          }
                          if (maxPriceController.text.isNotEmpty) {
                            ref.read(filterProvider.notifier).setKey('maxPrice',
                                double.tryParse(maxPriceController.text));
                          } else {
                            ref
                                .read(filterProvider.notifier)
                                .removeKey("maxPrice");
                          }
                          ref.read(fetchProductsProvider.notifier).setFilter();
                          Navigator.pop(context);
                        },
                        removeFilter: () {
                          ref
                              .read(filterProvider.notifier)
                              .removeKey("minPrice");
                          ref
                              .read(filterProvider.notifier)
                              .removeKey("maxPrice");
                          ref.read(fetchProductsProvider.notifier).setFilter();
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: Ink(
                      padding: const EdgeInsets.all(4),
                      child: SvgPicture.asset(
                        "assets/svgs/filter.svg",
                        colorFilter: const ColorFilter.mode(
                          AppColors.appDark700,
                          BlendMode.srcIn,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  )),
              fetchProducts.when(
                  data: (value) {
                    return ResponsiveGridList(
                      listViewBuilderOptions: ListViewBuilderOptions(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()),
                      horizontalGridMargin: 6,
                      verticalGridMargin: 6,
                      minItemWidth: 160,
                      children: List.generate(
                          value.length,
                          (index) => ProductDetails(
                                model: value[index],
                                onDelete: () {
                                  ref
                                      .read(fetchProductsProvider.notifier)
                                      .deleteProduct(value[index].id!);
                                  Navigator.pop(context);
                                },
                              )),
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    if (kDebugMode) {
                      print(stackTrace);
                    }
                    return const Text("An error has occurred");
                  },
                  loading: () => const CustomShimmer(
                        height: 200,
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
