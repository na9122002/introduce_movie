import 'package:naflix_app/models/item_model.dart';
import 'package:naflix_app/models/trailer_model.dart';
import 'package:naflix_app/resources/movie_api_provider.dart';

class Respository {
  Future<ItemModel> fetchAllMovie() => MovieApiProvider().fetchMovieList();
  Future<TrailerModel> fetchTrailerAllMovie(String idMovie) =>
      MovieApiProvider().fetchTrailesMovieList(idMovie);
  Future<ItemModel> fetchSearchAllMovie(String query) =>
      MovieApiProvider().fetchSearchMovieList(query);
}
