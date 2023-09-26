import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/model_movie.dart';
import 'package:flutter_netflix/provider/provider.dart';
import 'package:flutter_netflix/screen/detail_screen.dart';
import 'package:provider/provider.dart';

class LikeScreen extends StatelessWidget {
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
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(26),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(
                        './images/bbongflix_logo.png',
                        fit: BoxFit.contain,
                        height: 25,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          '내가 찜한 콘텐츠',
                          style: TextStyle(fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                movieList(
                    context,
                    _movieProvider.movies
                        .where((e) => e.like == true)
                        .toList()),
              ],
            ),
          );
        }
      },
    );
  }

  Widget movieList(BuildContext context, List<Movie> list) {
    if (list.isEmpty) {
      return Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '아직은 비어 있습니다.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '내가 찜한 콘텐츠에 추가해 다음에 보고싶은\n 시리즈&영화를 기록해 두세요.',
                style: TextStyle(fontSize: 15, color: Colors.white60),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {},
                  child: Text(
                    '시리즈&영화 둘러보기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Expanded(
        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1 / 1.5,
          padding: EdgeInsets.all(3),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: list.map((e) => movieItem(context, e)).toList(),
        ),
      );
    }
  }

  Widget movieItem(BuildContext context, Movie movie) {
    return InkWell(
      child: Image.network(movie.poster),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<Null>(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return DetailScreen(movie: movie);
            },
          ),
        );
      },
    );
  }
}
