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
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();


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
              leading: Text('${allNotes[index][DBHelper.columnNoteSNo]}'),
              title: Text(allNotes[index][DBHelper.columnNoteTitle]),
              subtitle: Text(allNotes[index][DBHelper.columnNoteDesc]),
              trailing: SizedBox(
                width: 50,
                child: Row(
                  children: [
                    InkWell(
                      onTap: (){
                        mainDB!.updateNote(title: "Updated Note", desc: "This is Updated desc", sno: allNotes[index][DBHelper.columnNoteSNo]);
                        getInitialNotes();
                      },
                        child: Icon(Icons.edit, color: Colors.blue,)),
                    InkWell(
                      onTap: (){
                        mainDB!.deleteNote(sno: allNotes[index][DBHelper.columnNoteSNo]);
                        getInitialNotes();
                      },
                        child: Icon(Icons.delete, color: Colors.red,)),
                  ],
                ),
              ),
            );
          }) : Center(
        child: Text('No Notes yet!',style: TextStyle(fontSize: 25),),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: (){

          showModalBottomSheet(context: context,
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
          getInitialNotes();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addNoteInDB() async{
    var mTitle = titleController.text.toString();
    var mDesc = descController.text.toString();

    bool check = await mainDB!.addNote(title: mTitle, desc: mDesc);
    String msg = "Note adding failed!!";

    if(check){
      msg = "Note added successfully!!";
      getInitialNotes();
    }



    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  }
}