import 'package:okrika/features/products/data/datasource/product_datasource.dart';
import 'package:okrika/features/products/domain/models/category_model.dart';
import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';

class ProductCatalogueImpl extends ProductCatalogueRepository {
  final ProductDataSource datasource;

  ProductCatalogueImpl(this.datasource);

  @override
  Future<List<CategoryModel>> fetchCategories() {
    return datasource.fetchCategories();
  }

  @override
  Future<List<ProductModel>> fetchProducts() {
    return datasource.fetchProducts();
  }

  @override
  Future<ProductModel> fetchProduct(int id) {
    return datasource.fetchProduct(id);
  }

  @override
  Future<List<ProductModel>> filterProducts(Map<String, dynamic> filterData) {
    return datasource.filterProducts(filterData);
  }

  @override
  Future<void> deleteProduct(int id) {
    return datasource.deleteProduct(id);
  }

  @override
  Future<void> createNewProduct(Map<String, dynamic> productData) {
    return datasource.createNewProduct(productData);

  }
}
