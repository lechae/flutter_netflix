import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/model_movie.dart';
import 'package:flutter_netflix/provider/provider.dart';
import 'package:flutter_netflix/screen/detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchScreenState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

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
                  color: Colors.black,
                  height: 55,
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 6,
                        child: TextField(
                          focusNode: focusNode,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          autofocus: false,
                          controller: _filter,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white12,
                            prefixIcon: Icon(
                              Icons.search,
                              color: Colors.white60,
                              size: 20,
                            ),
                            suffixIcon: focusNode.hasFocus
                                ? IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _filter.clear();
                                        _searchText = "";
                                      });
                                    },
                                    icon: Icon(
                                      Icons.cancel,
                                      size: 20,
                                    ),
                                  )
                                : Container(),
                            hintText: '검색',
                            labelStyle: TextStyle(color: Colors.white),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      focusNode.hasFocus
                          ? Expanded(
                              flex: 1,
                              child: TextButton(
                                child: Text('취소'),
                                onPressed: () {
                                  setState(() {
                                    _filter.clear();
                                    _searchText = "";
                                    focusNode.unfocus();
                                  });
                                },
                              ),
                            )
                          : Expanded(
                              flex: 0,
                              child: Container(),
                            )
                    ],
                  ),
                ),
                movieList(
                  context,
                  _movieProvider.movies,
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget movieList(BuildContext context, List<Movie> list) {
    List<Movie> searchResults = [];
    for (Movie movie in list) {
      if (movie.title.contains(_searchText)) {
        searchResults.add(movie);
      }
    }

    return Expanded(
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1 / 1.5,
        padding: EdgeInsets.all(3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        children: searchResults.map((e) => movieItem(context, e)).toList(),
      ),
    );
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
