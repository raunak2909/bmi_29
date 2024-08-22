import 'package:bmi_291/cubit/note_db_state.dart';
import 'package:bmi_291/data/models/note_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/local/db_helper.dart';

class NoteDBCubit extends Cubit<NoteDBState>{

  DBHelper dbHelper;
  NoteDBCubit({required this.dbHelper}):super(NoteDBInitialState());

  ///events
  void addNote({required NoteModel newNote}) async{
    emit(NoteDBLoadingState());
    bool check = await dbHelper.addNote(newNote);
    if(check){
      var data = await dbHelper.getAllNotes();
      emit(NoteDBLoadedState(mNotes: data));
    } else {
      emit(NoteDBErrorState(errorMsg: "Note not added!!"));
    }
  }

  ///initial notes
  void fetchInitialNotes() async{
    emit(NoteDBLoadingState());

    List<NoteModel> data = await dbHelper.getAllNotes();
    emit(NoteDBLoadedState(mNotes: data));
  }

  ///update note
  void updateNote({required NoteModel updatedNote, required int sno}) async{

    emit(NoteDBLoadingState());

    bool check = await dbHelper.updateNote(updatedNote: updatedNote, sno: sno);

    if(check){
      List<NoteModel> allNotes = await dbHelper.getAllNotes();
      emit(NoteDBLoadedState(mNotes: allNotes));
    } else {
      emit(NoteDBErrorState(errorMsg: "Note not updated!!"));
    }

  }



}