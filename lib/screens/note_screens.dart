import 'package:flutter/material.dart';
import 'dart:async';
import '../database_helper/database_helper.dart';
import 'package:todo_list/noteList.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';
import 'note_details.dart';

class noteList extends StatefulWidget {
  @override
  _noteListState createState() => _noteListState();
}

class _noteListState extends State<noteList> {
  databaseHelper dbhelper = databaseHelper();
  List<note> noteL;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TODO List"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToDetails(note("", 0, ""), "add Note");
        },
        child: Icon(Icons.add),
        tooltip: "Add Note",
      ),
    );
  }

  void navigateToDetails(note note, String title) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return noteDetail(note, title);
        },
      ),
    );

    if (result == true) {
      // TODO: update the view

    }
  }
}
