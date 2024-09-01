import 'package:sqflite/sqflite.dart';

abstract class DatabaseHelperRepo {
  Future<Database> get database;

  Future<Database> initDatabase();
}
