import 'package:flutter/material.dart';
import 'package:todo_list/noteList.dart';
import 'package:todo_list/database_helper/database_helper.dart';
import 'package:intl/intl.dart';

class noteDetail extends StatefulWidget {
  final note notes;
  final String title;

  noteDetail({Key key, @required this.notes, this.title}) : super(key: key);
  // noteDetail(this.notes, this.title);

  @override
  // apabila ingin taro nilai ke variable, gunakan ini.
  _noteDetailState createState() => _noteDetailState(this.title, this.notes);
}

class _noteDetailState extends State<noteDetail> {
  static var _priorities = ['High', 'Low'];
  databaseHelper dbHelper = databaseHelper();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String title;
  note notess;

  _noteDetailState(this.title, this.notess);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = notess.title;
    descriptionController.text = notess.description;

    return WillPopScope(
      onWillPop: () {
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.cyanAccent,
        appBar: AppBar(
          title: Text(this.title),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                moveToLastScreen();
              }),
        ),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusDirectional.circular(20),
            ),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 15,
                    bottom: 5,
                    right: 5,
                  ),
                  child: ListTile(
                    leading: Icon(Icons.low_priority),
                    title: DropdownButton<String>(
                        items: _priorities.map(
                          (String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                dropDownStringItem,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        value: updatePriorityAsString(notess.priority),
                        onChanged: (valueSelectedByUser) {
                          setState(() {
                            updatePriorityAsInt(valueSelectedByUser);
                          });
                        }),
                  ),
                ),

                // Second Element
                Padding(
                  padding: EdgeInsets.only(
                    top: 15.0,
                    bottom: 15.0,
                    left: 15.0,
                    right: 15,
                  ),
                  child: TextField(
                    controller: titleController,
                    style: textStyle,
                    onChanged: (value) {
                      updateTitle();
                    },
                    decoration: InputDecoration(
                      labelText: 'Title',
                      labelStyle: textStyle,
                      icon: Icon(Icons.title),
                    ),
                  ),
                ),

                // third element
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                  child: TextField(
                    controller: descriptionController,
                    style: textStyle,
                    onChanged: (value) {
                      updateDescription();
                    },
                    decoration: InputDecoration(
                      labelText: 'Details',
                      icon: Icon(Icons.details),
                    ),
                  ),
                ),
                // Fourth Element
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.green,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Save',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              debugPrint("Save button clicked");
                              _save();
                            });
                          },
                        ),
                      ),
                      Container(
                        width: 5.0,
                      ),
                      Expanded(
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.red,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Delete',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _deleteNote();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateTitle() {
    notess.title = titleController.text;
  }

  void updateDescription() {
    notess.description = descriptionController.text;
  }

  _save() async {
    moveToLastScreen();

    notess.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    notess.id != null
        ? result = await dbHelper.updatetNote(notess)
        : result = await dbHelper.insertNote(notess);

    print(result);
    result != 0
        ? _showAlertDialog("Status", "Note Save Successfully")
        : _showAlertDialog("Status", "Problem Saving Note");
  }

  void _deleteNote() async {
    moveToLastScreen();

    if (notess.id == null) {
      _showAlertDialog("Status", "First Add note");
    }

    int result = await dbHelper.deleteNote(notess.id);
    result != 0
        ? _showAlertDialog("Status", "Note Deleted Successfully")
        : _showAlertDialog("Status", "Error");
  }

  // convert String to Integer to save into database
  void updatePriorityAsInt(String value) {
    print(value == 'High');
    switch (value) {
      case 'High':
        notess.priority = 1;
        print(notess.priority);
        break;
      case 'Low':
        notess.priority = 2;
        print(notess.priority);
        break;
    }
  }

  // convert integer to string to show user
  String updatePriorityAsString(int value) {
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
    }
    return priority;
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void _showAlertDialog(String title, String msg) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
    );

    showDialog(
        context: context, builder: (BuildContext context) => alertDialog);
  }
}
