import 'package:okrika/features/products/domain/models/category_model.dart';
import 'package:okrika/features/products/domain/providers/product_catalogue_provider.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fetch_categories_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<CategoryModel>> fetchCategories(FetchCategoriesRef ref) async {
  final ProductCatalogueRepository productRepo =
      ref.read(productCatalogueProvider);
  return await productRepo.fetchCategories();
}
