import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_netflix/model/model_movie.dart';

class MovieProvider with ChangeNotifier {
  late CollectionReference moviesReference;
  List<Movie> movies = [];

  MovieProvider({reference}) {
    moviesReference =
        reference ?? FirebaseFirestore.instance.collection('movie');
  }

  Future<void> fetchMovieData() async {
    movies = await moviesReference.get().then((QuerySnapshot results) {
      return results.docs.map((DocumentSnapshot document) {
        return Movie.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }

  Future<void> updateMovieInfo(int idx, bool like) async {
    await movies[idx].reference.update({'like': like});
    notifyListeners();
  }
}
