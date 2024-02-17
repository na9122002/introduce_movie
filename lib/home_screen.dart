import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:naflix_app/blocs/movies_bloc.dart';
import 'package:naflix_app/detail_screen.dart';
import 'package:naflix_app/helpers/asset_helper.dart';
import 'package:naflix_app/models/item_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var size, height, width;
final controller = CarouselController();
final urlImages = [
  AssetHelper.Poster_1,
  AssetHelper.Poster_2,
  AssetHelper.Poster_3,
  AssetHelper.Poster_4,
];
int activeIndex = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    int activeIndex = 0;
    final bloc = MoviesBloc();
    bloc.fetchAllMovies();
    return Container(
      color: Colors.black,
      child: Column(children: [
        CarouselSlider.builder(
            carouselController: controller,
            itemCount: urlImages.length,
            itemBuilder: (context, index, realIndex) {
              final urlImage = urlImages[index];
              return buildImage(urlImage, index, width);
            },
            options: CarouselOptions(
                height: height / 3.5,
                viewportFraction: 1,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                enlargeCenterPage: true,
                onPageChanged: (index, reason) =>
                    setState(() => activeIndex = index))),
        buildIndicator(),
        StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<ItemModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: 230,
                child: ItemsLoad(snapshot),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
        StreamBuilder(
          stream: bloc.allMovies,
          builder: (context, AsyncSnapshot<ItemModel> snapshot) {
            if (snapshot.hasData) {
              return Container(
                height: height - height / 3.5 - height / 11 - 230 - 28,
                child: ListMoviePopular(snapshot: snapshot),
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

class ItemsLoad extends StatefulWidget {
  AsyncSnapshot<ItemModel> snapshot;
  ItemsLoad(this.snapshot);
  @override
  State<ItemsLoad> createState() => _ItemsLoadState();
}

class _ItemsLoadState extends State<ItemsLoad> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.only(top: 8, left: 8, right: 8),
        scrollDirection: Axis.horizontal,
        itemCount: widget.snapshot.data!.results.length,
        itemBuilder: (context, int index) {
          return Row(
            children: [
              Container(
                width: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      height: 160,
                      width: 130,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              fit: BoxFit.cover,
                              'https://image.tmdb.org/t/p/original/${widget.snapshot.data!.results[index].poster_path}')),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.snapshot.data!.results[index].title,
                      style: TextStyle(color: Colors.white),
                      softWrap: true,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
            ],
          );
        });
  }
}

Widget buildImage(String urlImage, int index, dynamic width) =>
    // Container(child: Image.asset(urlImage),

    // )

    Container(
      width: width,
      decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage(urlImage), fit: BoxFit.fill)),
    );
Widget buildIndicator() => AnimatedSmoothIndicator(
      onDotClicked: animateToSlide,
      effect: ExpandingDotsEffect(dotWidth: 15, activeDotColor: Colors.red),
      activeIndex: activeIndex,
      count: urlImages.length,
    );

void animateToSlide(int index) => controller.animateToPage(index);

class ListMoviePopular extends StatefulWidget {
  final snapshot;
  ListMoviePopular({super.key, this.snapshot});

  @override
  State<ListMoviePopular> createState() => _ListMoviePopularState();
}

class _ListMoviePopularState extends State<ListMoviePopular> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: widget.snapshot.data!.results.length,
        itemBuilder: (context, int index) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 250,
                    width: width / 2 - 10,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            fit: BoxFit.cover,
                            'https://image.tmdb.org/t/p/original/${widget.snapshot.data!.results[index].poster_path}')),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: width / 2 - 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                        snapshot: widget.snapshot,
                                        index: index,
                                      )),
                            );
                          },
                          child: Text(
                            widget.snapshot.data!.results[index].title,
                            style: TextStyle(color: Colors.white, fontSize: 28),
                            softWrap: true,
                          ),
                        ),
                        Text(
                          widget.snapshot.data!.results[index].release_date,
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.red,
                            ),
                            Text(
                              widget.snapshot.data.results[index].release_date,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
            ],
          );
        });
  }
}
