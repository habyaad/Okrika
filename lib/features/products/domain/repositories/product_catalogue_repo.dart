import 'package:okrika/features/products/domain/models/product_model.dart';
import '../models/category_model.dart';

abstract class ProductCatalogueRepository{
  Future<List<ProductModel>> fetchProducts();
  Future<ProductModel> fetchProduct(int id);
  Future<List<CategoryModel>> fetchCategories();
  Future<List<ProductModel>> filterProducts(Map<String, dynamic> filterData);
  Future<void> deleteProduct(int id);
}