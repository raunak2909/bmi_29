import 'package:bmi_291/add_note_page.dart';
import 'package:bmi_291/cubit/note_db_cubit.dart';
import 'package:bmi_291/cubit/note_db_state.dart';
import 'package:bmi_291/data/local/db_helper.dart';
import 'package:bmi_291/data/models/note_model.dart';
import 'package:bmi_291/main.dart';
import 'package:bmi_291/note_db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DBPage extends StatefulWidget{

  @override
  State<DBPage> createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {
  //DBHelper? mainDB;
  List<NoteModel> allNotes = [];

  @override
  void initState() {
    super.initState();
    //context.read<NoteDBProvider>().getInitialNotes();
    context.read<NoteDBCubit>().fetchInitialNotes();
  }

  //TextEditingController titleController = TextEditingController();
  /*void getInitialNotes() async{
    //allNotes = await mainDB!.getAllNotes();
    //print(allNotes.length);
    *//*setState(() {

    });*//*
  }*/

  @override
  Widget build(BuildContext context) {
    print('Build called');

    //allNotes = context.watch<NoteDBProvider>().getNoteData();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      /*body: Consumer<NoteDBProvider>(
        builder: (_, provider, __){
          allNotes = provider.getNoteData();
          return allNotes.isNotEmpty ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index){
                return ListTile(
                  leading: Text('${index+1}'),
                  title: Text(allNotes[index].title),
                  subtitle: Text(allNotes[index].desc),
                  trailing: SizedBox(
                    width: 50,
                    child: Row(
                      children: [
                        InkWell(
                            onTap: (){
                              *//* mainDB!.updateNote(title: "Updated Note", desc: "This is Updated desc", sno: allNotes[index].s_no!);
                        getInitialNotes();*//*
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isUpdate: true, updatedNote: allNotes[index]),));
                            },
                            child: Icon(Icons.edit, color: Colors.blue,)),
                        InkWell(
                            onTap: (){
                              *//* mainDB!.deleteNote(sno: allNotes[index].s_no!);
                        getInitialNotes();*//*
                              context.read<NoteDBProvider>().deleteNote(sno: allNotes[index].s_no!);
                            },
                            child: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              }) : Center(
            child: Text('No Notes yet!',style: TextStyle(fontSize: 25),),
          );
        },
      ),*/

      body: BlocBuilder<NoteDBCubit, NoteDBState>(
        builder: (_, state){

          if(state is NoteDBLoadingState){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if(state is NoteDBErrorState){
            return Center(
              child: Text('Error: ${state.errorMsg}'),
            );
          }

          if(state is NoteDBLoadedState){
            return state.mNotes.isNotEmpty ? ListView.builder(
                itemCount: state.mNotes.length,
                itemBuilder: (_, index){
                  return ListTile(
                    leading: Text('${index+1}'),
                    title: Text(state.mNotes[index].title),
                    subtitle: Text(state.mNotes[index].desc),
                    trailing: SizedBox(
                      width: 50,
                      child: Row(
                        children: [
                          InkWell(
                              onTap: (){
                                /* mainDB!.updateNote(title: "Updated Note", desc: "This is Updated desc", sno: allNotes[index].s_no!);
                                getInitialNotes();*/
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isUpdate: true, updatedNote: state.mNotes[index]),));
                              },
                              child: Icon(Icons.edit, color: Colors.blue,)),
                          InkWell(
                              onTap: (){
                                /* mainDB!.deleteNote(sno: allNotes[index].s_no!);
                                getInitialNotes();*/
                                //context.read<NoteDBProvider>().deleteNote(sno: allNotes[index].s_no!);
                              },
                              child: Icon(Icons.delete, color: Colors.red,)),
                        ],
                      ),
                    ),
                  );
                }) : Center(
              child: Text('No Notes yet!',style: TextStyle(fontSize: 25),),
            );
          }


          return Container();
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),));

         /* showModalBottomSheet(context: context,
             // isDismissible: false,
             // enableDrag: false,
              builder: (_){
            return Container(
              padding: EdgeInsets.all(11),
              width: double.infinity,
              child: Column(
                children: [
                  Text('Add Note', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),),
                  SizedBox(
                    height: 21,
                  ),
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('Title'),
                      hintText: 'Enter title here..',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      ),
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
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21)
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 11,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(onPressed: (){
                        addNoteInDB();
                        titleController.clear();
                        descController.clear();
                        Navigator.pop(context);
                      }, child: Text('Add')),
                      OutlinedButton(onPressed: (){
                        Navigator.pop(context);
                      }, child: Text('Cancel'))
                    ],
                  )
                ],
              ),
            );
          });
          getInitialNotes();*/
        },
        child: Icon(Icons.add),
      ),
    );
  }

  /*void addNoteInDB() async{
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    bool check = await mainDB!.addNote(NoteModel(title: mTitle, desc: mDesc));
    String msg = "Note adding failed!!";

    if(check){
      msg = "Note added successfully!!";
      getInitialNotes();
    }



    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  }*/
}