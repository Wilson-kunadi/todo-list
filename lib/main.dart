import 'package:flutter/material.dart';
import 'package:todo_list/screens/note_screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: noteList(),
    );
  }
}
