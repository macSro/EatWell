import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'diet.dart';

class User extends Equatable {
  final String id;
  final String displayName;
  final Diet diet;

  User({@required this.id, @required this.displayName, @required this.diet});

  User copyWith({
    id,
    displayName,
    diet,
  }) {
    return User(
      id: id ?? this.id,
      displayName: displayName ?? this.displayName,
      diet: diet ?? this.diet,
    );
  }

  @override
  List<Object> get props => [id, displayName, diet];
}
