class note {
  int _id, _priority;
  String _title, _description, _date;

  note(this._title, this._priority, this._date, [this._description]);
  note.withID(
      this._id, this._title, this._priority, this._date, this._description);

// all the getters
  int get id => _id;
  int get priority => _priority;
  String get title => _title;
  String get description => _description;
  String get date => _date;

// all the setters
  set title(String newTitle) {
    if (newTitle.length <= 255) this._title = newTitle;
  }

  set description(String newDesc) {
    if (newDesc.length <= 255) this._description = newDesc;
  }

  set date(String newDate) => this._date = newDate;

  set priority(int newPriority) {
    if (newPriority > 0 && newPriority < 3) this._priority = newPriority;
  }

  // used to save and retrieve from db
  // convert note object to map object
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;

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
