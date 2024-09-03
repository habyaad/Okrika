import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/domain/providers/product_catalogue_provider.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';
import 'package:okrika/features/products/presentation/providers/filter_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_products_provider.g.dart';

@Riverpod(keepAlive: true)
class FetchProducts extends _$FetchProducts {
  @override
  Future<List<ProductModel>> build() async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    return await productRepo.fetchProducts();
  }

  Future<void> setFilter() async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    final Map<String, dynamic> filterData = ref.read(filterProvider);
    state = AsyncData(await productRepo.filterProducts(filterData));
  }

  Future<void> addProduct(Map<String, dynamic> productData) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    try {
      await productRepo.createNewProduct(productData);
      await setFilter();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteProduct(
    int id,
  ) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    try {
      await productRepo.deleteProduct(id);
      await setFilter();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> editProduct(int id, Map<String, dynamic> productData) async {
    final ProductCatalogueRepository productRepo =
        ref.read(productCatalogueProvider);
    try {
      await productRepo.editProduct(id, productData);
      await setFilter();
    } catch (e) {
      rethrow;
    }
  }
}
