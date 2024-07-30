import 'package:bmi_291/data/local/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DBPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    //DBHelper db = DBHelper();
    DBHelper db = DBHelper.getInstance;


    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
    );
  }
}