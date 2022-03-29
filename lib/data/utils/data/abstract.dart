import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart' show UniqueKey;

abstract class BaseData<T extends BaseData<T>> {
  late final CollectionReference<T> _ref;

  late final String id;
  late String name;
  late final DateTime createdAt;
  late DateTime updatedAt;

  BaseData(String? id, String? name, DateTime? createdAt, DateTime? updatedAt,
      String ref) {
    this.id = id ?? UniqueKey().hashCode.toString().substring(2, 7);
    this.createdAt = createdAt ?? DateTime.now();
    this.updatedAt = updatedAt ?? this.createdAt;
    this.name = name ?? '';

    _ref = FirebaseFirestore.instance.collection(ref).withConverter<T>(
          fromFirestore: (snapshot, _) => fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }

  Map<String, dynamic> toJson();

  T fromJson(Map<String, dynamic> json);

  @override
  String toString() {
    return 'id: $id, name: $name';
  }

  Future<void> add(T data) async {
    updatedAt = DateTime.now();
    await _ref.doc(id).set(data);
  }

  Future<List<T>> getAll() async {
    return (await _ref.orderBy('createdAt').get())
        .docs
        .map((e) => e.data())
        .toList();
  }

  /// static declaration of all ref name

  static const adminRefName = 'AdminDataClass';

  /// assignment
  static const assignmentRefName = 'AssignmentDataClass';
  static const assignmentActivityRefName = 'AssignmentActivityDataDataClass';
  static const teacherAssignmentRefName = 'TeacherAssignmentDataClass';

  ///
  static const collegeRefName = 'CollegeDataClass';
  static const courseRefName = 'CourseDataClass';
  static const studentRefName = 'StudentDataClass';
  static const subjectRefName = 'SubjectDataClass';

  /// teacher
  static const teacherRefName = 'TeacherDataClass';
  static const teacherAccountRefName = 'TeacherAccountDataClass';
  static const teacherDocRefName = 'TeacherDocDataClass';
  static const teacherSubjectRefName = 'TeacherSubjectDataClass';

  static const transactionRefName = 'TransactionDataClass';
}
