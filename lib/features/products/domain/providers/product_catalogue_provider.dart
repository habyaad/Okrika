import 'package:okrika/features/products/data/providers/product_data_provider.dart';
import 'package:okrika/features/products/data/repository/product_catalogue_impl.dart';
import 'package:okrika/features/products/domain/repositories/product_catalogue_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasource/product_datasource.dart';

part 'product_catalogue_provider.g.dart';

@riverpod
class ProductCatalogue extends _$ProductCatalogue {
  @override
  ProductCatalogueRepository build() {
    final ProductDataSource dataSource = ref.read(productDataProvider);
    return ProductCatalogueImpl(dataSource);
  }
// Add methods to mutate the state
}
