import 'package:bmi_291/data/local/db_helper.dart';

class NoteModel {
  int? s_no;
  String title;
  String desc;

  NoteModel({this.s_no, required this.title, required this.desc});

  ///fromMap -> Model
  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
        s_no: map[DBHelper.columnNoteSNo],
        title: map[DBHelper.columnNoteTitle],
        desc: map[DBHelper.columnNoteDesc]);
  }

  ///toMap <- from Model
  Map<String, dynamic> toMap(){
    return {
      DBHelper.columnNoteTitle : title,
      DBHelper.columnNoteDesc : desc,
    };
  }
}
