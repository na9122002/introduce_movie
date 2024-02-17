import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naflix_app/blocs/movies_bloc.dart';
import 'package:naflix_app/detail_screen.dart';
import 'package:naflix_app/models/item_model.dart';

class Search_Movie_Screen extends StatefulWidget {
  const Search_Movie_Screen({super.key});

  @override
  State<Search_Movie_Screen> createState() => _Search_Movie_ScreenState();
}

class _Search_Movie_ScreenState extends State<Search_Movie_Screen> {
  // This list holds the data for the list view
  List<Result> _foundUsers = [];
  String query = 'a';
  @override
  initState() {
    // at the beginning, all users are shown

    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword, List<Result> _allMovie) {
    List<Result> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allMovie;
    } else {
      results = _allMovie
          .where((user) =>
              user.title.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
      query = enteredKeyword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MoviesBloc();
    bloc.fetchSearchAllMovies(query);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            StreamBuilder(
              stream: bloc.SearchTrailerMovies,
              builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                if (snapshot.hasData) {
                  _foundUsers = snapshot.data!.results;

                  return Container(
                    child: TextField(
                      onChanged: (value) =>
                          _runFilter(value, snapshot.data!.results),
                      decoration: const InputDecoration(
                          labelText: 'Search', suffixIcon: Icon(Icons.search)),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: _foundUsers.isNotEmpty
                  ? StreamBuilder(
                      stream: bloc.SearchTrailerMovies,
                      builder: (context, AsyncSnapshot<ItemModel> snapshot) {
                        return Container(
                          height: 230,
                          child: ListView.builder(
                            itemCount: _foundUsers.length,
                            itemBuilder: (context, index) => Card(
                              key: ValueKey(_foundUsers[index].id),
                              color: Colors.white,
                              elevation: 4,
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              snapshot: snapshot,
                                              index: index,
                                            )),
                                  );
                                },
                                child: ListTile(
                                  leading: Image.network(_foundUsers[index]
                                              .poster_path
                                              .toString() ==
                                          'null'
                                      ? 'https://1.bp.blogspot.com/-D2I7Z7-HLGU/Xlyf7OYUi8I/AAAAAAABXq4/jZ0035aDGiE5dP3WiYhlSqhhMgGy8p7zACNcBGAsYHQ/w1200-h630-p-k-no-nu/no_image_square.jpg'
                                      : 'https://image.tmdb.org/t/p/original/${_foundUsers[index].poster_path.toString()}'),
                                  title: Text(_foundUsers[index].title),
                                  subtitle: Text(
                                      '${_foundUsers[index].get_release_date.toString()} years old'),
                                ),
                              ),
                            ),
                          ),
                        );
                      })
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
