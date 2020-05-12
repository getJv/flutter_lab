class Todo {
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  Todo(this._title, this._priority, this._date, [this._description]);
  Todo.withId(this._id, this._title, this._priority, this._date,
      [this._description]);
  int get id => _id;
  int get priority => _priority;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title(String value) {
    _title = value.length < 255 ? value : null;
  }

  set description(String value) {
    _description = value.length < 255 ? value : null;
  }

  set priority(int value) {
    _priority = (value > 0 && value <= 3) ? value : 1;
  }

  set date(String value) => _date = value;

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    if (_id != null) map['id'] = _id;

    return map;
  }

  Todo.fromObject(dynamic o) {
    this._id = o['id'];
    this._title = o['title'];
    this._description = o['description'];
    this._priority = o['priority'];
    this._date = o['date'];
  }
}
