import 'package:flutter/material.dart';
import 'package:flutter_netflix/provider/provider.dart';
import 'package:flutter_netflix/widget/box_slider.dart';
import 'package:flutter_netflix/widget/carousel_slider.dart';
import 'package:flutter_netflix/widget/circle_slider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _movieProvider = Provider.of<MovieProvider>(context);
    return FutureBuilder(
      future: _movieProvider.fetchMovieData(),
      builder: (context, snapshots) {
        if (_movieProvider.movies.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CarouselImage(provider: _movieProvider),
                  TopBar(),
                ],
              ),
              CircleSlider(
                movies: _movieProvider.movies,
              ),
              BoxSlider(
                movies: _movieProvider.movies,
              ),
            ],
          );
        }
      },
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Image.asset(
            'images/bbongflix_logo.png',
            fit: BoxFit.contain,
            height: 25,
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              'TV 프로그램',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '영화',
              style: TextStyle(fontSize: 14),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 1),
            child: Text(
              '내가 찜한 콘텐츠',
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}
