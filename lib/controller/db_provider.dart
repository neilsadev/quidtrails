// this is a database helper file. It's main purpose to make
// working with database easy and simple.

import 'package:quidtrails/model/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  // we called a private constructor and make a static instance and a static
  // database so that there will be only one instance and
  // database during the whole execution

  DBProvider._();

  static final DBProvider instance = DBProvider._();
  static Database? _database;

  // this function returns a database. If a database exists then it
  // will return that database, otherwise it will create a new database
  // and return that.
  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB();
    return _database!;
  }

  // this function will create a new database with a table
  // with appropriate column names
  Future<Database> _initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'quidtrails.db'),
        onCreate: (db, version) async {
      await db.execute('''CREATE TABLE ${K.tableNameUser} (
          ${K.colNameUser["name"]} TEXT NOT NULL,
          ${K.colNameUser["currency"]} TEXT NOT NULL,
          ${K.colNameUser["currencyMode"]} TEXT NOT NULL,
          ${K.colNameUser["image"]} TEXT NOT NULL,
          ${K.colNameUser["remoteUID"]} TEXT
        )''');
      await db.execute('''CREATE TABLE ${K.tableNameExp} (
          ${K.colNameExp["category"]} TEXT NOT NULL,
          ${K.colNameExp["description"]} TEXT NOT NULL,
          ${K.colNameExp["amount"]} INTEGER NOT NULL,
          ${K.colNameExp["dateTime"]} TEXT NOT NULL
        )''');
      await db.execute('''CREATE TABLE ${K.tableNameSummery} (
          ${K.colNameSummery["month"]} TEXT NOT NULL,
          ${K.colNameSummery["budget"]} INTEGER NOT NULL,
          ${K.colNameSummery["spent"]} INTEGER NOT NULL
        )''');
      await db.execute('''CREATE TABLE ${K.tableNameDBSync} (
          ${K.colNameDBSync["localTs"]} INTEGER NOT NULL,
          ${K.colNameDBSync["dbTs"]} INTEGER NOT NULL
        )''');
    }, version: 1);
  }

  // this function takes a table name and a map of data to insert to the table
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // this function query all data from table that's name passed as a argument
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // this function will drops the table as given table name
  // and creates an empty table there
  Future<void> dropTable(String tableName) async {
    Database db = await instance.database;
    String dbPath = join(await getDatabasesPath(), 'quidtrails.db');
    await db.execute('''DROP DATABASE $dbPath''');
  }
}
