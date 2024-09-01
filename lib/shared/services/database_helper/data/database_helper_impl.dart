import 'package:okrika/shared/services/database_helper/data/data_seed.dart';
import 'package:okrika/shared/services/database_helper/domain/repositories/database_helper_repo.dart';
import 'package:okrika/shared/utils/app_strings.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelperImpl extends DatabaseHelperRepo {
  static const _databaseVersion = 1;

  // make this a singleton class
  DatabaseHelperImpl._privateConstructor();

  static final DatabaseHelperImpl instance =
      DatabaseHelperImpl._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  @override
  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), AppStrings.DATABASE_NAME);
    return await openDatabase(path, version: _databaseVersion,
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE ${AppStrings.CATEGORY_TABLE_NAME} (
            ${AppStrings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${AppStrings.columnCategory} TEXT NOT NULL
          )
          ''');

      await db.execute('''
          CREATE TABLE ${AppStrings.PRODUCT_TABLE_NAME} (
            ${AppStrings.columnId} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${AppStrings.columnName} TEXT NOT NULL,
            ${AppStrings.columnCategory} INTEGER NOT NULL,
            ${AppStrings.columnPrice} INTEGER NOT NULL,
            ${AppStrings.columnCoverImage} TEXT NOT NULL,
            ${AppStrings.columnDescription} TEXT NOT NULL,
            FOREIGN KEY (${AppStrings.columnCategory}) REFERENCES ${AppStrings.CATEGORY_TABLE_NAME} (${AppStrings.columnId})                  
            ON DELETE NO ACTION ON UPDATE NO ACTION
          )
          ''');

      for (var element in DataSeed.categories) {
        await db.insert(AppStrings.CATEGORY_TABLE_NAME, {
          AppStrings.columnCategory: element,
        });
      }
      for (var element in DataSeed.products) {
        await db.insert(AppStrings.PRODUCT_TABLE_NAME, element);
      }
    });
  }
}
