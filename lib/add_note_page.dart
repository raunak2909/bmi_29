import 'package:bmi_291/cubit/note_db_cubit.dart';
import 'package:bmi_291/note_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/local/db_helper.dart';
import 'data/models/note_model.dart';

class AddNotePage extends StatefulWidget {
  bool isUpdate;
  NoteModel? updatedNote;

  /* int sno;
  String prevTitle;
  String prevDesc;*/

  AddNotePage({this.isUpdate = false, this.updatedNote});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  DBHelper? mainDB;

  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (widget.isUpdate) {
      titleController.text = widget.updatedNote!.title;
      descController.text = widget.updatedNote!.desc;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Update Note' : 'Add Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(11),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.isUpdate ? 'UpdateNote' : 'Add Note',
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                label: Text('Title'),
                hintText: 'Enter title here..',
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
              maxLines: 3,
              decoration: InputDecoration(
                label: Text('Desc'),
                hintText: 'Enter Desc here..',
                enabledBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
                focusedBorder:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(21)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: () {
                      addNoteInDB();
                      titleController.clear();
                      descController.clear();
                      Navigator.pop(context);
                    },
                    child: Text(widget.isUpdate ? 'Update' : 'Add')),
                OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'))
              ],
            )
          ],
        ),
      ),
    );
  }

  void addNoteInDB() async {
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    widget.isUpdate
        ? context.read<NoteDBCubit>().updateNote(
            updatedNote: NoteModel(title: mTitle, desc: mDesc),
            sno: widget.updatedNote!.s_no!)
        : context
            .read<NoteDBCubit>()
            .addNote(newNote: NoteModel(title: mTitle, desc: mDesc));

    /* widget.isUpdate
        ? context
            .read<NoteDBProvider>()
            .updateNote(updatedNote: NoteModel(title: mTitle, desc: mDesc), sno: widget.updatedNote!.s_no!)
        : context
            .read<NoteDBProvider>()
            .addNote(newNote: NoteModel(title: mTitle, desc: mDesc));*/

    /*Provider.of<NoteDBProvider>(context, listen: false)
        .addNote(newNote: NoteModel(title: mTitle, desc: mDesc));
*/
    /* mainDB = DBHelper.getInstance;

    bool check = await mainDB!.addNote(NoteModel(title: mTitle, desc: mDesc));
    String msg = "Note adding failed!!";

    if(check){
      msg = "Note added successfully!!";
    }


    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
*/
  }
}
