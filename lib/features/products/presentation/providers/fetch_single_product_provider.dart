import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/domain/providers/product_catalogue_provider.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_single_product_provider.g.dart';

@Riverpod()
Future<ProductModel> fetchSingleProduct(
    FetchSingleProductRef ref, int id) async {
  final ProductCatalogueRepository productRepo =
      ref.read(productCatalogueProvider);
  return await productRepo.fetchProduct(id);
}
