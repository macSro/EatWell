import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Rating extends Equatable {
  int points;
  int votes;
  double rating;

  Rating({@required this.points, @required this.votes}) {
    this.rating = this.votes != 0 ? this.points / this.votes : 0.0;
  }

  @override
  List<Object> get props => [points, votes, rating];

  @override
  bool get stringify => true;
}
