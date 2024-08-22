import 'package:bmi_291/cubit/note_db_cubit.dart';
import 'package:bmi_291/data/local/db_helper.dart';
import 'package:bmi_291/db_page.dart';
import 'package:bmi_291/note_db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

void main() {
  runApp(BlocProvider(
      create: (_) => NoteDBCubit(dbHelper: DBHelper.getInstance),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: DBPage(),
    );
  }
}

