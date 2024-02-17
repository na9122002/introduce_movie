import 'package:flutter/material.dart';
import 'package:naflix_app/models/item_model.dart';
import 'package:naflix_app/models/trailer_model.dart';
import 'package:naflix_app/resources/respository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesBloc {
  final movieFetcher = PublishSubject<ItemModel>();
  Stream<ItemModel> get allMovies => movieFetcher.stream;
  final TrailermovieFetcher = PublishSubject<TrailerModel>();
  Stream<TrailerModel> get allTrailerMovies => TrailermovieFetcher.stream;
  final SearchmovieFetcher = PublishSubject<ItemModel>();
  Stream<ItemModel> get SearchTrailerMovies => SearchmovieFetcher.stream;

  fetchAllMovies() async {
    final repository = Respository();
    ItemModel itemModel = await repository.fetchAllMovie();
    movieFetcher.sink.add(itemModel);
  }

  fetchTrailerAllMovies(String idMovie) async {
    final repository = Respository();
    TrailerModel itemTrailerModel =
        await repository.fetchTrailerAllMovie(idMovie);
    TrailermovieFetcher.sink.add(itemTrailerModel);
  }

  fetchSearchAllMovies(String query) async {
    final repository = Respository();
    ItemModel itemSearchModel = await repository.fetchSearchAllMovie(query);
    SearchmovieFetcher.sink.add(itemSearchModel);
  }

  dispose() {
    movieFetcher.close();
  }
}

// final bloc = MoviesBloc();
