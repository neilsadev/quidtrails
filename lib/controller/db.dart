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
    // Set default value to the User Table row.
    _database!.insert(K.tableNameUser, {
      K.colNameUser["currency"]!: "\$",
      K.colNameUser["currencyMode"]!: 1,
    });
    // Set default value to the Sync Table row
    _database!.insert(K.tableNameDBSync, {
      K.colNameDBSync["localTs"]!: DateTime.now().millisecondsSinceEpoch,
    });
    // Set default value to the Summery table
    _database!.insert(K.tableNameSummery, {
      K.colNameSummery["month"]!: DateTime.now().toString().split(" ").first,
      K.colNameSummery["budget"]!: 5000,
      K.colNameSummery["spent"]!: 0,
    });
    return _database!;
  }

  // this function will create a new database with a table
  // with appropriate column names
  Future<Database> _initDB() async {
    return await openDatabase(join(await getDatabasesPath(), 'quidtrails.db'),
        onCreate: (db, version) async {
      await db.execute('''CREATE TABLE ${K.tableNameUser} (
          ${K.colNameUser["name"]} TEXT,
          ${K.colNameUser["currency"]} TEXT NOT NULL,
          ${K.colNameUser["currencyMode"]} INTEGER NOT NULL,
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
          ${K.colNameDBSync["dbTs"]} INTEGER
        )''');
      // Demo data For test
      await db.execute(
          '''INSERT INTO expense_table values ("Food", "Breakfast", 25, "2021-09-19 08:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Travel", "Cox Bazar", 150, "2021-09-18 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Travel", "Guest Inn", 400, "2021-09-20 11:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Gift", "Iphone", 2500, "2021-09-18 08:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Insurences", "Health", 250, "2021-09-19 07:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "GTAV", 170, "2021-09-18 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Upkeep", "Exaust pipe change", 4000, "2021-09-20 11:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Medical", "Hamstring", 180, "2021-09-17 06:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "Red dead redemption 2", 150, "2021-09-19 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Upkeep", "Oil change", 400, "2021-09-20 11:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Medical", "Bipass", 2500, "2021-09-19 11:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Insurences", "Health", 250, "2021-09-18 01:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "Skyrim", 15, "2021-09-17 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Upkeep", "Tires", 400, "2021-09-20 01:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Medical", "Life", 250, "2021-09-17 09:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "Netflix", 15, "2021-09-19 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Insurences", "Life", 250, "2021-09-19 08:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "Hulu", 15, "2021-09-19 13:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Upkeep", "Oil Change", 400, "2021-09-20 15:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Medical", "Cast", 170, "2021-09-20 08:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Entertainment", "Amazon prime", 10, "2021-09-18 17:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Upkeep", "Tire", 400, "2021-09-20 12:50:33.019")''');
      await db.execute(
          '''INSERT INTO expense_table values ("Medical", "Cancer", 2500, "2021-09-19 08:50:33.019")''');
    }, version: 1);
  }

  // this function takes a table name and a map of data to insert to the table
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<int> update(String tableName, Map<String, dynamic> row,
      {String? where, List<Object?>? whereArgs}) async {
    Database db = await instance.database;
    return await db.update(tableName, row, where: where, whereArgs: whereArgs);
  }

  // this function query all data from table that's name passed as a argument
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> query(
    String tableName, {
    String? where,
    List<Object?>? whereArgs,
  }) async {
    Database db = await instance.database;
    return await db.query(tableName, where: where, whereArgs: whereArgs);
  }

  // this function will drops the table as given table name
  // and creates an empty table there
  Future<void> dropTable(String tableName) async {
    Database db = await instance.database;
    String dbPath = join(await getDatabasesPath(), 'quidtrails.db');
    await db.execute('''DROP DATABASE $dbPath''');
  }
}
