import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

class CourseData extends BaseData<CourseData> {
  CourseData({
    this.img = '',
    this.notes = '',
    this.visibility = 'None',
    this.isActive = false,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.courseRefName);

  String img;
  String notes;
  String visibility;
  bool isActive;

  CourseData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          name: json['name'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          img: json['img'] as String,
          notes: json['notes'] as String,
          visibility: json['visibility'] as String,
          isActive: json['isActive'] as bool,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'img': img,
        'notes': notes,
        'visibility': visibility,
        'isActive': isActive,
      };

  @override
  CourseData fromJson(Map<String, dynamic> json) => CourseData.fromJson(json);
}
