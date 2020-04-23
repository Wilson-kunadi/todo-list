import 'package:flutter/material.dart';
import 'package:todo_list/noteList.dart';
import 'package:todo_list/database_helper/database_helper.dart';
import 'package:intl/intl.dart';

class noteDetail extends StatefulWidget {
  final note notes;
  final String title;

  // noteDetail({Key key, @required this.notes, this.title}) : super(key: key);
  noteDetail(this.notes, this.title);

  @override
  _noteDetailState createState() => _noteDetailState();
}

class _noteDetailState extends State<noteDetail> {
  static var _priority = ['High', 'Low'];
  databaseHelper dbHelper = databaseHelper();
  String title;
  note notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );
  }
}
