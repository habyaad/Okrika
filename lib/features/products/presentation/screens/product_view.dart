import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/presentation/providers/fetch_single_product_provider.dart';
import 'package:okrika/shared/widgets/custom_appbar.dart';
import 'package:okrika/shared/widgets/custom_text.dart';

import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/widgets/shimmer.dart';

class ProductView extends ConsumerWidget {
  const ProductView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final args = ModalRoute.of(context)!.settings.arguments as int;
    final AsyncValue<ProductModel> fetchProduct =
        ref.watch(fetchSingleProductProvider(args));
    return Scaffold(
        backgroundColor: Colors.white,
        extendBodyBehindAppBar: true,
        bottomNavigationBar: InkWell(
          onTap: () {},
          child: Ink(
            height: 58,
            decoration: const BoxDecoration(color: AppColors.appOrange),
            child: const Center(
              child: CustomText(
                title: "Add to cart",
                weight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        appBar: CustomAppBar(
          verticalPadding: 12,
          bgColor: Colors.transparent,
          title: '',
          prefixIcon: Container(
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
          suffixIcon: Container(
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
              child: SvgPicture.asset(
                "assets/svgs/Bag.svg",
                fit: BoxFit.scaleDown,
              )),
        ),
        body: fetchProduct.when(
            data: (value) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: "picture-container-$args",
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 380,
                        decoration: BoxDecoration(
                            color: AppColors.appLight30,
                            image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/${value.imageUrl}.png"),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Expanded(
                                child: CustomText(
                                  title: "${value.name}",
                                  weight: FontWeight.w700,
                                  size: 20,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const CustomText(
                                    title: "Price",
                                    weight: FontWeight.w500,
                                    color: AppColors.medium300,
                                    size: 14,
                                  ),
                                  CustomText(
                                    title: "\$ ${value.price}",
                                    weight: FontWeight.w700,
                                    size: 20,
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          SizedBox(
                            height: 70,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: 5, // Number of items in the list
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {},
                                  child: AnimatedContainer(
                                    width: 70,
                                    duration: const Duration(milliseconds: 300),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: AppColors.appLight40,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/images/${value.imageUrl}.png"),
                                            fit: BoxFit.cover)),
                                  ),
                                );
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(
                                  width: 8,
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          const CustomText(
                            title: "Description",
                            weight: FontWeight.w600,
                            size: 16,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          CustomText(
                            title: "${value.description}",
                            weight: FontWeight.w500,
                            size: 14,
                            color: AppColors.medium300,
                            overflow: TextOverflow.clip,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
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
                )));
  }
}
