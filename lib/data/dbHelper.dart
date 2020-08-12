import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper {
  Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = openDatabase(dbPath, version: 1, onCreate: createDb);
    return eTradeDb;
  }

  void createDb(Database db, int version) async {
    var sqlQuery1 =
        "Create table products(id integer primary key, name text, description text, unitPrice integer)";
    await db.execute(sqlQuery1);
  }

// PRODUCT LIST
  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");
    return List.generate(result.length, (i) => Product.fromObject(result[i]));
    /* (i){
      return Product.fromObject(result[i]);
    } */
  }

// INSERT
  /* eger result kullanmadin problemini gormek istemiyorsan fonksiyon ismi icin int yerine void kullanabuilir ya da
  int varken var result yapmadan inserti calistirabilirsin fakat hicbirini yapmasan int varken var result olsa dahi
  problem gorunse bile bu herhangi bir sorun teskil etmez ..!!
  */
  // <int>
  Future<void> insert(Product product) async {
    Database db = await this.db;
    // ignore: unused_local_variable
    var result = await db.insert("products", product.toMap());
  }

// DELETE
  Future<int> delete(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("delete from products where id=$id");
    return result;
  }

// UPDATE
  Future<int> update(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
