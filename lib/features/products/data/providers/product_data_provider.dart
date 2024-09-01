import 'package:okrika/features/products/data/datasource/product_datasource.dart';
import 'package:okrika/shared/services/database_helper/providers/database_helper_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../shared/services/database_helper/domain/repositories/database_helper_repo.dart';

part 'product_data_provider.g.dart';

@riverpod
class ProductData extends _$ProductData {
  @override
  ProductRemoteDataSource build() {
    final DatabaseHelperRepo dbInstance = ref.read(databaseHelperProvider);
    return ProductRemoteDataSource(dbInstance);
  }
// Add methods to mutate the state
}
