import 'package:flutter/foundation.dart';
import 'package:okrika/shared/utils/app_strings.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../shared/services/database_helper/domain/repositories/database_helper_repo.dart';
import '../../domain/models/category_model.dart';
import '../../domain/models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> fetchProducts();

  Future<List<ProductModel>> filterProducts(Map<String, dynamic> filterData);

  Future<ProductModel> fetchProduct(int id);

  Future<void> deleteProduct(int id);

  Future<List<CategoryModel>> fetchCategories();
}

class ProductRemoteDataSource implements ProductDataSource {
  final DatabaseHelperRepo dbInstance;

  ProductRemoteDataSource(this.dbInstance);

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    final Database db = await dbInstance.database;
    try {
      List<Map<String, Object?>> response =
          await db.query(AppStrings.CATEGORY_TABLE_NAME);
      if (kDebugMode) {
        print("Product categories:: $response");
      }
      return CategoryModel.parseCategoryList(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> fetchProducts() async {
    final Database db = await dbInstance.database;

    try {
      List<Map<String, Object?>> response =
          await db.query(AppStrings.PRODUCT_TABLE_NAME, columns: [
        AppStrings.columnId,
        AppStrings.columnName,
        AppStrings.columnPrice,
        AppStrings.columnCoverImage
      ]);
      if (kDebugMode) {
        print("Products:: $response");
      }

      return ProductModel.parseProductList(response);
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      rethrow;
    }
  }

  @override
  Future<ProductModel> fetchProduct(int id) async {
    final Database db = await dbInstance.database;

    try {
      List<Map<String, Object?>> response = await db.query(
          AppStrings.PRODUCT_TABLE_NAME,
          where: '${AppStrings.columnId} = ?',
          whereArgs: [id]);
      if (kDebugMode) {
        print("Products:: $response");
      }

      return ProductModel.fromJson(response[0]);
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      rethrow;
    }
  }

  @override
  Future<List<ProductModel>> filterProducts(
      Map<String, dynamic> filterData) async {
    final Database db = await dbInstance.database;

    try {
      String whereClause = '';
      List<dynamic> whereArgs = [];

      if (filterData.containsKey('category')) {
        if (filterData['category'] == 0) {
        } else {
          whereClause += '${AppStrings.columnCategory} = ?';
          whereArgs.add(filterData['category']);
        }
      }

      if (filterData.containsKey('minPrice') &&
          filterData.containsKey('maxPrice')) {
        if (whereClause.isNotEmpty) whereClause += ' AND ';
        whereClause += '${AppStrings.columnPrice} BETWEEN ? AND ?';
        whereArgs.add(filterData['minPrice']);
        whereArgs.add(filterData['maxPrice']);
      } else if (filterData.containsKey('minPrice')) {
        if (whereClause.isNotEmpty) whereClause += ' AND ';
        whereClause += '${AppStrings.columnPrice} >= ?';
        whereArgs.add(filterData['minPrice']);
      } else if (filterData.containsKey('maxPrice')) {
        if (whereClause.isNotEmpty) whereClause += ' AND ';
        whereClause += '${AppStrings.columnPrice} <= ?';
        whereArgs.add(filterData['maxPrice']);
      }

      List<Map<String, Object?>> response = await db.query(
        AppStrings.PRODUCT_TABLE_NAME,
        columns: [
          AppStrings.columnId,
          AppStrings.columnName,
          AppStrings.columnPrice,
          AppStrings.columnCoverImage
        ],
        where: whereClause.isNotEmpty ? whereClause : null,
        whereArgs: whereArgs.isNotEmpty ? whereArgs : null,
      );

      if (kDebugMode) {
        print("Products:: $response");
      }

      return response.map((product) => ProductModel.fromJson(product)).toList();
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(int id) async {
    final Database db = await dbInstance.database;

    try {
      int response = await db.delete(AppStrings.PRODUCT_TABLE_NAME,
          where: '${AppStrings.columnId} = ?', whereArgs: [id]);
      if (kDebugMode) {
        print("Products:: $response");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error $e");
      }
      rethrow;
    }
  }
}
