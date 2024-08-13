import 'package:bmi_291/data/local/db_helper.dart';
import 'package:bmi_291/main.dart';
import 'package:flutter/cupertino.dart';

import 'data/models/note_model.dart';

class NoteDBProvider extends ChangeNotifier{
  DBHelper mainDB;
  NoteDBProvider({required this.mainDB});
  //data
  List<NoteModel> _allNotes = [];

  ///events
  ///add note
  void addNote({required NoteModel newNote}) async{
    bool isNoteAdded = await mainDB.addNote(newNote);
    if(isNoteAdded){
     _allNotes = await mainDB.getAllNotes();
     notifyListeners();
    }
  }

  ///get Initial Notes
  void getInitialNotes() async{
    _allNotes = await mainDB.getAllNotes();
    notifyListeners();
  }

  List<NoteModel> getNoteData(){
    return _allNotes;
  }

  ///update Note
  void updateNote({required NoteModel updatedNote, required int sno}) async{
    bool isNoteUpdated = await mainDB.updateNote(updatedNote: updatedNote, sno: sno);
    if(isNoteUpdated){
      _allNotes = await mainDB.getAllNotes();
      notifyListeners();
    }
  }

  void deleteNote({required int sno}) async{
    bool isNoteDeleted = await mainDB.deleteNote(sno: sno);
    if(isNoteDeleted){
      _allNotes = await mainDB.getAllNotes();
      notifyListeners();
    }
  }

}