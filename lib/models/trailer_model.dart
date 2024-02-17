class TrailerModel {
  int? id;

  List<Result> results = [];
  TrailerModel.fromJson(Map<String, dynamic> parsedJson) {
    id = parsedJson['id'];
    List<Result> temp = [];
    for (var i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    results = temp;
  }
}

class Result {
  dynamic iso_639_1;
  dynamic id;
  dynamic iso_3166_1;
  dynamic name;
  dynamic key;
  dynamic site;
  dynamic size;
  dynamic type;
  dynamic published_at;

  Result(result) {
    iso_639_1 = result['iso_639_1'].toString();
    id = result['id'];
    iso_3166_1 = result['iso_3166_1'];
    name = result['name'].toString();
    key = result['key'].toString();
    site = result['site'].toString();
    size = result['size'].toString();
    type = result['type'].toString();
    published_at = result['published_at'].toString();
  }
  String get get_iso_639_1 => iso_639_1;
  String get get_iso_3166_1 => iso_3166_1;
  dynamic get get_name => name;
  String get get_key => key;
  List<int> get get_site => site;
  String get get_size => size;
  double get get_type => type;
  String get get_published_at => published_at;
  String get get_id => id;
}
