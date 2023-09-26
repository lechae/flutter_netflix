import 'package:cloud_firestore/cloud_firestore.dart';

class Movie {
  final String title;
  final String keyword;
  final String poster;
  final String maker;
  final String starring;
  final String detail;
  final bool like;
  late final DocumentReference reference;

  Movie.fromMap(Map<String, dynamic> map, {required this.reference})
      : title = map['title'],
        keyword = map['keyword'],
        poster = map['poster'],
        maker = map['maker'],
        starring = map['starring'],
        detail = map['detail'],
        like = map['like'];

  Movie.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  Map<String, dynamic> toSnapshot() {
    return {
      'title': title,
      'keyword': keyword,
      'poster': poster,
      'maker': maker,
      'starring': starring,
      'detail': detail,
      'like': like
    };
  }

  @override
  String toString() => "Movie<$title>";
}
