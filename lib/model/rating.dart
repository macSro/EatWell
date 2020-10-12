import 'package:flutter/foundation.dart';

class Rating {
  int points;
  int votes;
  double rating;

  Rating({@required this.points, @required this.votes}) {
    this.rating = this.votes != 0 ? this.points / this.votes : 0.0;
  }
}
