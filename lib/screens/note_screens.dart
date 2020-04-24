import 'package:flutter/material.dart';
import 'dart:async';
import '../database_helper/database_helper.dart';
import 'package:todo_list/noteList.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';

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
          navigateToDetails(note("", 2, ""), "add Note");
        },
        child: Icon(Icons.add),
        tooltip: "Add Note",
      ),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
      itemCount: this.count,
      itemBuilder: (BuildContext context, int i) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusDirectional.circular(10),
          ),
          color: Colors.grey,
          elevation: 4,
          child: ListTile(
            leading: Icon(Icons.priority_high),
            title: Text(
              this.noteL[i].title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              this.noteL[i].description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      },
    );
  }

  void navigateToDetails(note note, String title) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return noteDetail(
            notes: note,
            title: title,
          );
        },
      ),
    );

    if (result == true) {
      updatedListView();
    }
  }

  void updatedListView() {
    final Future<Database> dbFuture = dbhelper.initializeDatabase();
    dbFuture.then((db) {
      Future<List<note>> noteListFuture = dbhelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteL = noteList;
          print(noteList.length);
          this.count = noteList.length;
        });
      });
    });
  }
}
