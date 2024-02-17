import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:naflix_app/models/trailer_model.dart';

import '../models/item_model.dart';

class MovieApiProvider {
  Client client = Client();
  final apikey = "";
  final baseUrl = "";

  Future<ItemModel> fetchMovieList() async {
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=802b2c4b88ea1183e50e6b285a27696e'));
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailesMovieList(String idMovie) async {
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/$idMovie/videos?api_key=802b2c4b88ea1183e50e6b285a27696e'));
    print('nnnnn:${response.body.toString()}');
    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> fetchSearchMovieList(String query) async {
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/search/movie?api_key=802b2c4b88ea1183e50e6b285a27696e&language=en-US&query=$query=1&include_adult=false'));
    print('nnnnn:${response.body.toString()}');
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
