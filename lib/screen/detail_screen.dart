import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/model_movie.dart';

class DetailScreen extends StatefulWidget {
  final Movie? movie;
  DetailScreen({this.movie});

  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool like = false;

  @override
  void initState() {
    super.initState();
    like = widget.movie!.like;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: ListView(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.maxFinite,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.movie!.poster),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          alignment: Alignment.center,
                          color: Colors.black.withOpacity(0.1),
                          child: Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 45, 0, 10),
                                  child: Image.network(widget.movie!.poster),
                                  height: 300,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: AppBar(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
              Container(
                color: Colors.black26,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Text(
                        widget.movie!.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(7),
                      child: Row(
                        children: <Widget>[
                          Text(
                            '99% 일치',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '2022 18+ 시즌 1개',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.play_arrow),
                            Text('재생'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(3),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.download),
                            Text('저장'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      child: Text(widget.movie!.detail),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '출연: ' +
                            widget.movie!.starring +
                            '\n제작자: ' +
                            widget.movie!.maker,
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.black26,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  like = !like;
                                  widget.movie!.reference!
                                      .update({'like': like});
                                });
                              },
                              child: Column(
                                children: <Widget>[
                                  like ? Icon(Icons.check) : Icon(Icons.add),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Text(
                                    '내가 찜한 콘텐츠',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.thumb_up_alt_outlined),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Text(
                                    '평가',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.send),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                  ),
                                  Text(
                                    '공유',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white60,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
