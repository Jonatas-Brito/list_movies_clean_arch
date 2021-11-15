import 'dart:convert';

import 'package:equatable/equatable.dart';

class PeopleCredits extends Equatable {
  final int? id;
  final String? department;
  final String? name;
  final String? imagePath;

  PeopleCredits({
    required this.id,
    required this.department,
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [
        id,
        department,
        name,
        imagePath,
      ];
}
