class User {
  // ignore: unused_field
  int? _id;
  late String _username;
  late String _password;

  User(this._username, this._password);

  User.fromMap(dynamic obj) {
    _id = obj['id'];
    _username = obj['username'];
    _password = obj['password'];
  }

  int? get id => _id;
  String get username => _username;
  String get password => _password;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["username"] = _username;
    map["password"] = _password;
    return map;
  }
}
