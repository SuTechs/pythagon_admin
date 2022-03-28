import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

class CollegeData extends BaseData<CollegeData> {
  CollegeData({
    this.img = '',
    this.address = '',
    this.notes = '',
    this.visibility = 'None',
    this.isActive = false,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.collegeRefName);

  String img;
  String address;
  String notes;
  String visibility;
  bool isActive;

  CollegeData.fromJson(Map<String, dynamic> json)
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
          address: json['address'] as String,
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
        'address': address,
        'notes': notes,
        'visibility': visibility,
        'isActive': isActive,
      };

  @override
  CollegeData fromJson(Map<String, dynamic> json) => CollegeData.fromJson(json);
}
