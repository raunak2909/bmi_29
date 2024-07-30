import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{

  ///singleton
  ///private constructor
  DBHelper._();
  static final DBHelper getInstance = DBHelper._();


  /// my global database
  Database? myDB;

  Future<Database> getDb() async{
    myDB ??= await openDb();

    return myDB!;

  }

  Future<Database> openDb() async{
    ///path data/data/yourPackageName/databases
    Directory appDirectory = await getApplicationDocumentsDirectory();

    String rootPath = appDirectory.path;

    /// path data/data/yourPackageName/databases/notes.db
    String dbPath = join(rootPath, "notes.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version){
      /// table create (all)
      db.rawQuery("create table noteData ( s_no integer primary key autoincrement, title text, desc text )");
    });
  }


}
