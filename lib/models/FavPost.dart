class DbPost {
  int _id;
  String _title;
  String _description;
  String _date;
  String _author;
  String _authorDescription;

  DbPost(this._title, this._description, this._date, this._author,
      this._authorDescription);

  DbPost.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._date = obj['date'];
    this._author = obj['author'];
    this._authorDescription = obj['authorDescription'];
  }

  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  String get author => _author;
  String get authorDescription => _authorDescription;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['author'] = _author;
    map['authorDescription'] = _authorDescription;

    return map;
  }

  DbPost.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._author = map['author'];
    this._authorDescription = map['authorDescription'];
  }
}
