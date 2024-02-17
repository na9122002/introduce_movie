class ItemModel {
  int? page;
  int? total_page;
  int? total_results;
  List<Result> results = [];
  ItemModel.fromJson(Map<String, dynamic> parsedJson) {
    page = parsedJson['page'];
    total_results = parsedJson['total_results'];
    total_page = parsedJson['total_page'];
    List<Result> temp = [];
    for (var i = 0; i < parsedJson['results'].length; i++) {
      Result result = Result(parsedJson['results'][i]);
      temp.add(result);
    }
    results = temp;
  }
}

class Result {
  dynamic vote_count;
  dynamic id;
  dynamic video;
  dynamic vote_average;
  dynamic title;
  dynamic popularity;
  dynamic poster_path;
  List<int> genre_ids = [];
  dynamic backdrop_path;
  dynamic adult;
  dynamic overview;
  dynamic release_date;
  Result(result) {
    vote_count = result['vote_count'].toString();
    id = result['id'];
    video = result['video'];
    vote_average = result['vote_average'];
    title = result['title'].toString();
    popularity = result['popularity'];
    poster_path = result['poster_path'].toString();
    for (var i = 0; i < result['genre_ids'].length; i++) {
      genre_ids.add(result['genre_ids'][i]);
    }
    backdrop_path = result['backdrop_path'].toString();
    adult = result['adult'];
    overview = result['overview'].toString();
    release_date = result['release_date'].toString();
  }
  String get get_release_date => release_date;
  String get get_overview => overview;
  dynamic get get_adult => adult;
  String get get_backdrop_path => backdrop_path;
  List<int> get get_genre_ids => genre_ids;
  String get get_poster_path => poster_path;
  double get get_popularity => popularity;
  String get get_title => title;
  String get get_vote_average => vote_average;
  bool get is_video => video;
  String get get_vote_count => vote_count;
  int get get_id => id;
}
