import 'dart:developer';

import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  Database? database;
  Future<void> initDatabase() async {
    database = await openDatabase(
      'apple.db',
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
            'CREATE TABLE Test (id INTEGER PRIMARY KEY, image TEXT, title TEXT, price TEXT)');
        log('DATABASE CREATED');
      },
      onOpen: (db) {
        //Open data base
        log('DATABASE OPEN');
      },
    );
  }

  Future<void> insertToDatabase(
      String? image, String? title, String? price) async {
    //
    await database!.transaction(
      (txn) async {
        await txn.rawInsert(
            'INSERT INTO Test(image, title, price) VALUES(?, ?, ?)',
            [image, title, price]).then(
          (value) {
            log('INSART DATABASE $value');
          },
        );
      },
    );
  }

  Future<List<Map>> getAll() async {
    return await database!.rawQuery('SELECT * FROM Test');
  }

  void updateDatabase(
      {String? image, String? title, String? price, int? id}) async {
    await database!.rawUpdate(
        'UPDATE Test SET image = ?, title = ?, price = ? WHERE id = ?',
        [image, title, price, id]);
  }

  Future<void> deleteDatabase({int? id}) async {
    await database!.rawDelete('DELETE FROM Test WHERE id = ?', [id]);
  }

  Future<int?> getCount() async {
    var x = await database!.rawQuery('SELECT COUNT (*) from Test');

    return x.length;
  }
}
