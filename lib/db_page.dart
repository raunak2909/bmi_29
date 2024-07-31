import 'package:bmi_291/data/local/db_helper.dart';
import 'package:bmi_291/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DBPage extends StatefulWidget{
  @override
  State<DBPage> createState() => _DBPageState();
}

class _DBPageState extends State<DBPage> {

  DBHelper? mainDB;
  List<Map<String, dynamic>> allNotes = [];


  @override
  void initState(){
    super.initState();
    mainDB = DBHelper.getInstance;
    getInitialNotes();
  }

  void getInitialNotes() async{
    allNotes = await mainDB!.getAllNotes();
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: allNotes.isNotEmpty ? ListView.builder(
        itemCount: allNotes.length,
          itemBuilder: (_, index){
            return ListTile(
              title: Text(allNotes[index][DBHelper.columnNoteTitle]),
              subtitle: Text(allNotes[index][DBHelper.columnNoteDesc]),
              trailing: Row(
                children: [
                  Icon(Icons.edit, color: Colors.blue,),
                  Icon(Icons.delete, color: Colors.red,),
                ],
              ),
            );
          }) : Center(
        child: Text('No Notes yet!',style: TextStyle(fontSize: 25),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          mainDB!.addNote(title: "Note Title", desc: "Do what you Love or Love what you do.");
          getInitialNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}