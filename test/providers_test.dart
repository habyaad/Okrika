import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:okrika/features/products/domain/models/product_model.dart';
import 'package:okrika/features/products/presentation/providers/fetch_products_provider.dart';
import 'package:okrika/features/products/presentation/providers/fetch_single_product_provider.dart';
import 'package:okrika/features/products/presentation/providers/filter_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'provider_container.dart';

void main() {
  setUpAll(() {
    // Initialize the databaseFactory for sqflite_common_ffi
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  group('FetchProductsProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      // Create a new ProviderContainer for each test.
      container = createContainer();
    });

    test('Fetch products returns list of products', () async {
      final products = await container.read(fetchProductsProvider.future);
      expect(products, isA<List<ProductModel>>());
    });

    test('Add product increments length of product list', () async {
      final initialProductLength =
          (await container.read(fetchProductsProvider.future)).length;

      await container.read(fetchProductsProvider.notifier).addProduct({
        'name': 'Samsung Galaxy S21',
        'price': 799,
        'category': 2, // Electronics
        'description': 'The Samsung Galaxy S21.',
        'imageUrl': 'product-1',
      });

      final finalProductLength =
          (await container.read(fetchProductsProvider.future)).length;

      expect(finalProductLength, equals(initialProductLength + 1));
    });

    test('Delete product decrements length of product list', () async {
      final initialProducts =
          await container.read(fetchProductsProvider.future);

      final initialProductLength = initialProducts.length;

      // Assuming there's a product with ID 5, otherwise, adapt the ID or make sure to add one before deletion
      await container
          .read(fetchProductsProvider.notifier)
          .deleteProduct(initialProducts.first.id!);

      final finalProductLength =
          (await container.read(fetchProductsProvider.future)).length;

      expect(finalProductLength, equals(initialProductLength - 1));
    });

    test('Edit product updates product details', () async {
      // Add a product to ensure there is something to edit
      await container.read(fetchProductsProvider.notifier).addProduct({
        'name': 'Old Product Name',
        'price': 500,
        'category': 1,
        'description': 'An old product description.',
        'imageUrl': 'product-2',
      });

      final products = await container.read(fetchProductsProvider.future);
      final productToEdit = products.last;

      await container.read(fetchProductsProvider.notifier).editProduct(
        productToEdit.id!,
        {
          'name': 'New Product Name',
          'price': 600,
          'category': 1,
          'description': 'A new product description.',
          'imageUrl': 'product-3',
        },
      );

      final editedProduct = await container
          .read(fetchSingleProductProvider(productToEdit.id!).future);

      expect(editedProduct.name, equals('New Product Name'));
      expect(editedProduct.price, equals(600));
      expect(editedProduct.description, equals('A new product description.'));
      expect(editedProduct.imageUrl, equals('product-3'));
    });

    test('Set filter updates product list based on filter criteria', () async {
      // Assume we are filtering for Electronics category (category = 2)
      final filterData = {
        'category': 2,
      };

      // Set the filter in the filterProvider
      container.read(filterProvider.notifier).state = filterData;

      // Apply the filter using the setFilter method
      await container.read(fetchProductsProvider.notifier).setFilter();

      final filteredProducts =
          await container.read(fetchProductsProvider.future);
      //print(filteredProducts);
      // Verify that all returned products match the filter criteria
      for (final product in filteredProducts) {
        expect(product.category, equals(2));
      }
    });
  });
}
