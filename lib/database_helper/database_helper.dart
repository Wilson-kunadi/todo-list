import 'package:todo_list/noteList.dart'; //object we'll be saving and retrieving back from database
import 'package:sqflite/sqflite.dart';
import 'dart:async'; // for async
import 'dart:io'; //writting things into file
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:todo_list/screens/note_screens.dart';

class databaseHelper {
  static databaseHelper _databaseHelper; //Singleton
  static Database _database; //Singleton

  String noteTable = "note_table";
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  databaseHelper._createInstance();

  factory databaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = databaseHelper._createInstance();
    }
    return _databaseHelper;
  }

// custom getter
  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path + 'List Of Notes.db');

    var notesDB = await openDatabase(path, version: 1, onCreate: _createDB);
    return notesDB;
  }

  void _createDB(Database db, int newVersion) async {
    await db.execute(
      'CREATE TABLE $noteTable($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)',
    );
  }

  // this.database == custom getter
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;

    // Optional
    // var result = await db.rawQuery("SELECT * FROM ${this.noteTable} ORDER BY ${this.colPriority}");

    var result = await db.query(
      this.noteTable,
      orderBy: '$colPriority ASC',
    );
    return result;
  }

  Future<int> insertNote(note note) async {
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updatetNote(note note) async {
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
        where: '${this.colID} = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async {
    Database db = await this.database;
    var result = await db
        .rawDelete("DELETE FROM ${this.noteTable} WHERE ${this.colID} = $id");
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT(*) FROM ${this.noteTable}');
    int res = Sqflite.firstIntValue(x);
    return res;
  }

  Future<List<note>> getNoteList() async {
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;

    List<note> noteList = List<note>();

    for (var i = 0; i < count; i++) {
      noteList.add(note.fromMapObject(noteMapList[i]));
    }
    // return noteMapList;
  }
}
