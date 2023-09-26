import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix/firebase_options.dart';
import 'package:flutter_netflix/provider/provider.dart';
import 'package:flutter_netflix/screen/home_screen.dart';
import 'package:flutter_netflix/screen/like_screen.dart';
import 'package:flutter_netflix/screen/more_screen.dart';
import 'package:flutter_netflix/screen/search_screen.dart';
import 'package:flutter_netflix/widget/bottom_bar.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Netflix 따라하기',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
      ),
      home: ChangeNotifierProvider(
        create: (_) => MovieProvider(),
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                HomeScreen(),
                SearchScreen(),
                LikeScreen(),
                MoreScreen(),
              ],
            ),
            bottomNavigationBar: Bottom(),
          ),
        ),
      ),
    );
  }
}
