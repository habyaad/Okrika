import 'package:flutter_test/flutter_test.dart';
import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/presentation/providers/fetch_products_provider.dart';
import 'package:okrika/shared/services/database_helper/data/data_seed.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'provider_container.dart';

void main() {
  setUpAll(() {
    // Initialize the databaseFactory for sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });
  test('Fetch products returns list of products', () async {
    // Create a ProviderContainer for this test.
    final container = createContainer();

    // We expect fetchProductsProvider to return a Future that resolves to a List<ProductModel>.
    final products = await container.read(fetchProductsProvider.future);

    // Now, we assert that the returned value is a list and contains instances of ProductModel.
    expect(products, isA<List<ProductModel>>());
  });

  test('Add products increment length of list of products', () async {
    // Create a ProviderContainer for this test.
    final container = createContainer();

    // We expect fetchProductsProvider to return a Future that resolves to a List<ProductModel>.

    int initialProductLength =
        (await container.read(fetchProductsProvider.future)).length;
    await container.read(fetchProductsProvider.notifier).addProduct({
      'name': 'Samsung Galaxy S21',
      'price': 799,
      'category': 2, // Electronics
      'description': 'The Samsung Galaxy S21.',
      'imageUrl': 'product-1',
    });
    int finalProductLength =
        (await container.read(fetchProductsProvider.future)).length;
    // Now, we assert that the returned value is a list and contains instances of ProductModel.
    expect(finalProductLength, equals(initialProductLength + 1));
  });
}
