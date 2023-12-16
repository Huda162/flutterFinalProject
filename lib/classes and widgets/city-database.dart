import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'city.dart';



class DatabaseProvider extends ChangeNotifier{

  DatabaseProvider._privateConstructor();

  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();
  static Database? _database;
  static const int version = 2;

  Future<Database> get database async{
    if (_database != null){
      return _database!;
    }
    _database = await initDB();
    return _database!;
  }


  Future<Database> initDB() async{
    String path = join(await getDatabasesPath(), 'cityDB.db');
    return openDatabase(
      path,
      version: version,
      onCreate: (Database db, int version) async{
        await db.execute(
          '''
          CREATE TABLE city (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          country TEXT,
          isFavorite INTEGER
          )
          '''
        );
      },
      onUpgrade: (Database db, int oldversion, int newversion){

      }
    );
  }

  add(City city) async{
    final db = await database;
    db.insert('city', city.toMap());
    notifyListeners();
  }

  delete(String name) async {
    final db = await database;

    db.delete('city', where: 'name=?', whereArgs: [name]);
    notifyListeners();
  }

  Future<List<City>> getAllCities() async {
    final db = await database;
    List<Map<String, dynamic>> records = await db.query('city');

    List<City> cities = [];
    for(var record in records){
      City city = City.fromMap(record);
      cities.add(city);
    }

    return cities;
  }

  Future<bool> doesCityExist(String name) async {
    final db = await database;
    List<Map<String, dynamic>> records = await db.query('city',
        where: 'name = ?',
        whereArgs: [name],
        limit: 1);

    return records.isNotEmpty;
  }

  Future<int?> getCityIdByName(String name) async {
    final db = await database;
    List<Map<String, dynamic>> records = await db.query(
      'city',
      columns: ['id'],
      where: 'name = ?',
      whereArgs: [name],
      limit: 1,
    );

    if (records.isNotEmpty) {
      return records.first['id'];
    } else {
      return null;
    }
  }
}