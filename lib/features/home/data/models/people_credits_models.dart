import 'package:movies_list/features/home/domain/entities/cast_people.dart';

class CastPeopleModel extends CastPeople {
  CastPeopleModel({
    required int id,
    required String department,
    required String name,
    required String imagePath,
  }) : super(
          id: id,
          department: department,
          imagePath: imagePath,
          name: name,
        );

  factory CastPeopleModel.fromJson(Map<String, dynamic> map) {
    return CastPeopleModel(
      id: map['id'] != null ? map['id'] : null,
      department: map['known_for_department'] != null
          ? map['known_for_department']
          : null,
      name: map['name'] != null ? map['name'] : null,
      imagePath: map['profile_path'] != null ? map['profile_path'] : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'known_for_department': department,
      'name': name,
      'profile_path': imagePath,
    };
  }
}
