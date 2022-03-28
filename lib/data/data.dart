import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show UniqueKey;

abstract class BaseData {
  late final String id;
  late final DateTime createdAt;
  late DateTime updatedAt;

  BaseData(String? id, DateTime? createdAt, DateTime? updatedAt) {
    this.id = id ?? UniqueKey().hashCode.toString().substring(2, 7);
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? this.createdAt;
  }
}

class CollegeData extends BaseData {
  static final ref = FirebaseFirestore.instance
      .collection('CollegeData')
      .withConverter<CollegeData>(
        fromFirestore: (snapshot, _) => CollegeData.fromJson(snapshot.data()!),
        toFirestore: (collegeData, _) => collegeData.toJson(),
      );

  String name;
  String img;
  String address;
  String notes;
  String visibility;
  bool isActive;

  CollegeData({
    this.name = '',
    this.img = '',
    this.notes = '',
    this.address = '',
    this.visibility = 'None',
    this.isActive = false,

    ///
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, createdAt, updatedAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'name': name,
        'img': img,
        'address': address,
        'notes': notes,
        'visibility': visibility,
        'isActive': isActive,
      };

  CollegeData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          name: json['name'] as String,
          img: json['img'] as String,
          address: json['address'] as String,
          notes: json['notes'] as String,
          visibility: json['visibility'] as String,
          isActive: json['isActive'] as bool,
        );

  static Future<List<CollegeData>> getAll() async =>
      (await ref.orderBy('createdAt').get()).docs.map((e) => e.data()).toList();

  Future<void> add() async {
    updatedAt = DateTime.now();
    await ref.doc(id).set(this);
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}

class CourseData extends BaseData {
  static final ref = FirebaseFirestore.instance
      .collection('CourseData')
      .withConverter<CourseData>(
        fromFirestore: (snapshot, _) => CourseData.fromJson(snapshot.data()!),
        toFirestore: (course, _) => course.toJson(),
      );

  String name;
  String img;
  String notes;
  String visibility;
  bool isActive;

  CourseData({
    this.name = '',
    this.img = '',
    this.notes = '',
    this.visibility = 'None',
    this.isActive = false,

    ///
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, createdAt, updatedAt);

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'name': name,
        'img': img,
        'notes': notes,
        'visibility': visibility,
        'isActive': isActive,
      };

  CourseData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          name: json['name'] as String,
          img: json['img'] as String,
          notes: json['notes'] as String,
          visibility: json['visibility'] as String,
          isActive: json['isActive'] as bool,
        );

  static Future<List<CourseData>> getAll() async =>
      (await ref.get()).docs.map((e) => e.data()).toList();

  Future<void> add() async {
    updatedAt = DateTime.now();
    await ref.doc(id).set(this);
  }

  @override
  String toString() {
    return 'id: $id, name: $name';
  }
}
