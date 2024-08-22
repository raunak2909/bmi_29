import '../data/models/note_model.dart';

abstract class NoteDBState{}

class NoteDBInitialState extends NoteDBState{}
class NoteDBLoadingState extends NoteDBState{}
class NoteDBLoadedState extends NoteDBState{
  List<NoteModel> mNotes;
  NoteDBLoadedState({required this.mNotes});
}
class NoteDBErrorState extends NoteDBState{
  String errorMsg;
  NoteDBErrorState({required this.errorMsg});
}