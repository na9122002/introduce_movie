import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:naflix_app/blocs/movies_bloc.dart';
import 'package:naflix_app/home_screen.dart';
import 'package:naflix_app/models/trailer_model.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final index;
  final snapshot;
  DetailScreen({super.key, this.snapshot, this.index});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    dynamic size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final Trailerbloc = MoviesBloc();
    Trailerbloc.fetchTrailerAllMovies(
        widget.snapshot.data.results[widget.index].id.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        foregroundColor: Colors.red,
        backgroundColor: Colors.black,
        toolbarHeight: height / 3,
        flexibleSpace: Stack(children: [
          Container(
            height: height / 3,
            width: width,
            child: Image.network(
              widget.snapshot.data.results[widget.index].poster_path == 'null'
                  ? 'https://1.bp.blogspot.com/-D2I7Z7-HLGU/Xlyf7OYUi8I/AAAAAAABXq4/jZ0035aDGiE5dP3WiYhlSqhhMgGy8p7zACNcBGAsYHQ/w1200-h630-p-k-no-nu/no_image_square.jpg'
                  : 'https://image.tmdb.org/t/p/original/${widget.snapshot.data.results[widget.index].poster_path}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            child: Text(
              widget.snapshot.data.results[widget.index].title,
              style: TextStyle(
                  color: Colors.red, fontSize: 35, fontWeight: FontWeight.w800),
              softWrap: true,
            ),
          )
        ]),
      ),
      body: ListView(padding: EdgeInsets.all(8), children: [
        Row(
          children: [
            Container(
              width: (width - 16) / 3,
              child: Column(
                children: [
                  Text(
                    widget.snapshot.data.results[widget.index].popularity
                        .toString(),
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Popularity',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              width: (width - 16) / 3,
              child: Column(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.red,
                    size: 28,
                  ),
                  Text(
                    '${widget.snapshot.data.results[widget.index].vote_average.toString()}/10',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
            Container(
              width: (width - 16) / 3,
              child: Column(
                children: [
                  Text(
                    widget.snapshot.data.results[widget.index].vote_count
                        .toString(),
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Vote count',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Description',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          widget.snapshot.data.results[widget.index].overview,
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Trailers',
          style: TextStyle(
              color: Colors.white, fontSize: 28, fontWeight: FontWeight.w700),
        ),
        StreamBuilder(
          stream: Trailerbloc.allTrailerMovies,
          builder: (context, AsyncSnapshot<TrailerModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: height - height / 3.5 - height / 11 - 230 - 28,
                child: TrailerDetail(
                  snapshotTrailer: snapshot,
                  backdrop_path:
                      widget.snapshot.data.results[widget.index].backdrop_path,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ]),
    );
  }
}

class TrailerDetail extends StatefulWidget {
  final snapshotTrailer;
  final backdrop_path;
  const TrailerDetail({super.key, this.snapshotTrailer, this.backdrop_path});

  @override
  State<TrailerDetail> createState() => _TrailerDetailState();
}

class _TrailerDetailState extends State<TrailerDetail> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemCount: widget.snapshotTrailer.data.results.length,
        itemBuilder: (BuildContext ctx, index) {
          _launchURL(url) async {
            if (await canLaunch(url)) {
              await launch(url);
            } else {
              throw 'Could not launch $url';
            }
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  final url =
                      'https://www.youtube.com/watch?v=${widget.snapshotTrailer.data.results[index].key}';

                  launch(url, forceSafariVC: false);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    children: [
                      Image.network(
                          fit: BoxFit.cover,
                          widget.backdrop_path == 'null'
                              ? 'https://1.bp.blogspot.com/-D2I7Z7-HLGU/Xlyf7OYUi8I/AAAAAAABXq4/jZ0035aDGiE5dP3WiYhlSqhhMgGy8p7zACNcBGAsYHQ/w1200-h630-p-k-no-nu/no_image_square.jpg'
                              : 'https://image.tmdb.org/t/p/original/${widget.backdrop_path}'),
                      Container(
                        padding: EdgeInsets.only(
                            top: width / 9.8, left: width / 4 - 28),
                        child: Icon(
                          Icons.play_circle,
                          size: 34,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.snapshotTrailer.data.results[index].name,
                style: TextStyle(
                  color: Colors.white,
                ),
                softWrap: true,
              )
            ],
          );
        });
  }
}
