import 'package:flutter/material.dart';
import 'package:naflix_app/home_screen.dart';
import 'package:naflix_app/login.dart';
import 'package:naflix_app/search_movie.dart';
import 'package:naflix_app/sign_up.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:naflix_app/body.dart';

class Bottombar_Screen extends StatefulWidget {
  const Bottombar_Screen({Key? key}) : super(key: key);
  static const routeName = 'home_screen';
  @override
  State<Bottombar_Screen> createState() => _Bottombar_ScreenState();
}

class _Bottombar_ScreenState extends State<Bottombar_Screen> {
  var size, height, width;
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return Scaffold(
      backgroundColor: Colors.red,
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(),
          Search_Movie_Screen(),
          Login_Screen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: height / 11,
        width: width,
        child: SalomonBottomBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Color.fromARGB(255, 241, 239, 240),
          unselectedItemColor: Color.fromARGB(255, 7, 6, 6),
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          items: [
            SalomonBottomBarItem(
              icon: Icon(
                Icons.home_max,
                size: 32,
              ),
              title: Text('Home'),
            ),
            SalomonBottomBarItem(
              icon: Icon(
                Icons.search_rounded,
                size: 32,
              ),
              title: Text('Search Movie'),
            ),
            SalomonBottomBarItem(
              icon: Icon(Icons.favorite),
              title: Text('Favourite'),
            ),
          ],
        ),
      ),
    );
  }
}
