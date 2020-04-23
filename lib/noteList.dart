class note {
  int _id, _priority;
  String _title, _description, _date;

  note(this._title, this._priority, this._date, [this._description]);
  note.withID(
      this._id, this._title, this._priority, this._date, this._description);

// all the getters
  int get id => this._id;
  int get priority => this._priority;
  String get title => this._title;
  String get description => this._description;
  String get date => this._date;

// all the setters
  set title(String newTitle) {
    newTitle.length <= 255 ? this._title = newTitle : null;
  }

  set description(String newDesc) {
    newDesc.length <= 255 ? this._description = newDesc : null;
  }

  set date(String newDate) => this._date = newDate;
  set priority(int newPriority) => (newPriority > 0 && newPriority < 3)
      ? this._priority = newPriority
      : null;

  // used to save and retrieve from db
  // convert note object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = this._id;
    }
    map['title'] = this._title;
    map['description'] = this._description;
    map['priority'] = this._priority;
    map['date'] = this._date;

    return map;
  }

  note.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}
