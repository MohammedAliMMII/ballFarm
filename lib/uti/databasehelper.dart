import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:ballfarm/models/shape.dart';
import 'package:ballfarm/models/user.dart';
class DatabaseHelper {
  final String shapes = "shapes";
  final String idColumn = "id";

  final String users = "users";
  static final DatabaseHelper _instance = DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database _db;

  Future<Database> get db async{
    if(_db != null){
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  DatabaseHelper.internal();
  initDb() async{
    Directory fileDirectory = await getApplicationDocumentsDirectory();
    String path = join(fileDirectory.path,"wewewe.db");
    var maindb = await openDatabase(path,version: 3,onCreate: _onCreate);
    return maindb;
  }

  void _onCreate(Database db,int newVersion) async{
    await db.execute(
        "CREATE TABLE $shapes($idColumn INTEGER PRIMARY KEY,shCode TEXT,name TEXT)"
    );
    await db.execute(
        "CREATE TABLE $users($idColumn INTEGER PRIMARY KEY,seeIt TEXT)"
    );
  }
  Future<int> saveShape(Shape shape) async{
    var dbClient = await db;
    int res = await dbClient.insert("$shapes", shape.toMap());
    return res;
  }
  Future<List> getAllShape() async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $shapes");
    return result;
  }
  Future<Shape> getShape(int id) async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $shapes WHERE $idColumn = $id");
    if(result.length == 0) {
      return null;
    }
    return Shape.fromMap(result.first);
  }
  Future<int> getShapesCount() async {
    var dbCllient = await db;
    return Sqflite.firstIntValue(
        await dbCllient.rawQuery("SELECT COUNT(*) FROM $shapes")
    );
  }
  Future<int> deleteShape(int id) async {
    var dbClient = await db;
    return await dbClient.delete(shapes,where: "$idColumn = ?",whereArgs: [ id]);
  }
  void deleteShapes() async {
    var dbClient = await db;
    await dbClient.delete(shapes);
  }
  Future<int> updateShape(Shape shape) async {
    var dbClient = await db;
    return await dbClient.update(shapes,shape.toMap(),
        where: "$idColumn = ?" , whereArgs: [shape.id]
    );
  }
  Future<int> saveUser(User user) async{
    var dbClient = await db;
    int res = await dbClient.insert("$users", user.toMap());
    return res;
  }
  Future<User> getUser(int id) async{
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $users WHERE $idColumn = $id");
    if(result.length == 0) {
      return null;
    }
    return User.fromMap(result.first);
  }
  Future<int> deleteUsers() async{
    var dbClient = await db;
    var re = await dbClient.delete(users);
    return re;
  }
}