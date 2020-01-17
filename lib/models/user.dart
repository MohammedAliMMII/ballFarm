class User {
  String _seeIt;
  User(this._seeIt);

  String get seeIt => _seeIt;
  set seeIt(String value) {
    _seeIt = value;
  }
  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["seeIt"] = _seeIt;
    return map;
  }
  User.fromMap(Map<String,dynamic> map){
    this._seeIt = map["seeIT"];
  }
}