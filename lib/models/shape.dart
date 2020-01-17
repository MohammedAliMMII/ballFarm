class Shape{
  int _id;
  String _shCode;
  String _name;
  Shape(this._shCode,this._name);

  String get shCode => _shCode;
  int get id => _id;
  String get name => _name;

  set shCode(String value) {
    _shCode = value;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    map["id"] = _id;
    map["shCode"] = _shCode;
    map["name"] = _name;
    return map;
  }

  Shape.fromMap(Map<String,dynamic> map){
    this._id = map["id"];
    this._shCode = map["shCode"];
    this._name = map["name"];
  }
}