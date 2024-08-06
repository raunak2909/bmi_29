import 'dart:io';

import 'package:bmi_291/data/models/note_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';


///caching / cache management
class DBHelper {

  ///singleton
  ///private constructor
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  static final String tableNote = "noteData";
  static final String columnNoteSNo = "s_no";
  static final String columnNoteTitle = "title";
  static final String columnNoteDesc = "desc";








  /// my global database
  Database? myDB;

  ///get db
  Future<Database> getDb() async {
    myDB ??= await openDb();

    return myDB!;
  }

  ///open db
  Future<Database> openDb() async {
    ///path data/data/yourPackageName/databases
    Directory appDirectory = await getApplicationDocumentsDirectory();

    String rootPath = appDirectory.path;

    /// path data/data/yourPackageName/databases/notes.db
    String dbPath = join(rootPath, "notes.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      /// table create (all)
      db.rawQuery(
          "create table $tableNote ( $columnNoteSNo integer primary key autoincrement, $columnNoteTitle text, $columnNoteDesc text )");
    });
  }

  ///queries

  ///insert data
  Future<bool> addNote(NoteModel newNote) async {
    var db = await getDb();

    int rowsEffected = await db.insert(tableNote, newNote.toMap());

    return rowsEffected > 0;
  }

  ///get all data
  Future<List<NoteModel>> getAllNotes() async {
    var db = await getDb();

    List<NoteModel> mNotes = [];

    var data = await db.query(tableNote);

    for(Map<String, dynamic> eachNote in data){
      NoteModel eachModel = NoteModel.fromMap(eachNote);
      mNotes.add(eachModel);
    }

    return mNotes;
  }

  ///update note
  Future<bool> updateNote(
      {required String title, required String desc, required int sno}) async {
    var db = await getDb();

    int rowsEffected = await db.update(tableNote, {
      columnNoteTitle: title,
      columnNoteDesc: desc
    }, where: "$columnNoteSNo = $sno");

    return rowsEffected>0;
  }

///delete note
  Future<bool> deleteNote({required int sno}) async{
    var db = await getDb();

    int rowsEffected = await db.delete(tableNote, where: "$columnNoteSNo = ?", whereArgs: ['$sno']);

    return rowsEffected>0;
  }

}
