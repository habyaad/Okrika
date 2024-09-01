import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/domain/providers/product_catalogue_provider.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_products_provider.g.dart';

@Riverpod()
class FetchProducts extends _$FetchProducts {
  @override
  Future<List<ProductModel>> build() async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    return await productRepo.fetchProducts();
  }

  Future<void> setFilter(Map<String, dynamic> filterData) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    state = AsyncData(await productRepo.filterProducts(filterData));
  }

  Future<void> addProduct(Map<String, dynamic> filterData) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    state = AsyncData(await productRepo.filterProducts(filterData));
  }

  Future<void> deleteProduct(int id, Map<String, dynamic>? filterData) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    await productRepo.deleteProduct(id);
    if (filterData != null) {
      setFilter(filterData);
    }
  }
}
