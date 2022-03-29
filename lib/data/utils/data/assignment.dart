import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

/// Teacher Basic Info Data
class AssignmentData extends BaseData<AssignmentData> {
  AssignmentData({
    this.createdBy,
    this.studentId,
    this.assignmentType,
    this.description,
    this.subjectID,
    this.dueDate,
    this.assignmentFiles,
    this.referenceFiles,
    this.dealAmount,
    this.taxAmount,
    this.totalAmount,
    this.dueAmount,
    this.status,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.assignmentRefName);

  String? createdBy;
  String? studentId;

  String? assignmentType;
  String? description;
  String? subjectID;
  DateTime? dueDate;
  List<String>? assignmentFiles;
  List<String>? referenceFiles;

  // payment
  double? dealAmount;
  double? taxAmount;
  double? totalAmount;
  double? dueAmount;

  String? status;

  AssignmentData.fromJson(Map<String, dynamic> json)
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

          createdBy: json['createdBy'] as String?,
          studentId: json['studentId'] as String?,
          assignmentType: json['assignmentType'] as String?,
          description: json['description'] as String?,
          subjectID: json['subjectID'] as String?,
          dueDate: json['dueDate'] != null
              ? json['dueDate'].runtimeType == Timestamp
                  ? (json['dueDate'] as Timestamp).toDate()
                  : json['dueDate'] as DateTime
              : null,
          assignmentFiles: json['assignmentFiles'] as List<String>?,
          referenceFiles: json['referenceFiles'] as List<String>?,
          dealAmount: json['dealAmount'] as double?,
          taxAmount: json['taxAmount'] as double?,
          totalAmount: json['totalAmount'] as double?,
          dueAmount: json['dueAmount'] as double?,
          status: json['status'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'createdBy': createdBy,
        'studentId': studentId,
        'assignmentType': assignmentType,
        'description': description,
        'subjectID': subjectID,
        'dueDate': dueDate,
        'assignmentFiles': assignmentFiles,
        'referenceFiles': referenceFiles,
        'dealAmount': dealAmount,
        'taxAmount': taxAmount,
        'totalAmount': totalAmount,
        'dueAmount': dueAmount,
        'status': status,
      };

  @override
  AssignmentData fromJson(Map<String, dynamic> json) =>
      AssignmentData.fromJson(json);
}

class AssignmentActivityData extends BaseData<AssignmentActivityData> {
  AssignmentActivityData({
    this.assignmentId,
    this.adminId,
    this.description,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(
            id, name, createdAt, updatedAt, BaseData.assignmentActivityRefName);

  String? assignmentId;
  String? adminId;
  String? description;

  AssignmentActivityData.fromJson(Map<String, dynamic> json)
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

          assignmentId: json['assignmentId'] as String?,
          adminId: json['adminId'] as String?,
          description: json['description'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'assignmentId': assignmentId,
        'adminId': adminId,
        'description': description,
      };

  @override
  AssignmentActivityData fromJson(Map<String, dynamic> json) =>
      AssignmentActivityData.fromJson(json);
}

class TeacherAssignmentData extends BaseData<TeacherAssignmentData> {
  TeacherAssignmentData({
    this.teacherId,
    this.assignmentId,
    this.displayAmount,
    this.payment,
    this.status,
    this.rating,
    this.ratingFeedback,
    this.files,

    ///

    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, null, createdAt, updatedAt, BaseData.teacherAssignmentRefName);

  String? teacherId;
  String? assignmentId;
  String? displayAmount;
  double? payment;
  String? status;
  double? rating;
  String? ratingFeedback;
  List<String>? files;

  TeacherAssignmentData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///
          teacherId: json['teacherId'] as String?,
          assignmentId: json['assignmentId'] as String?,
          displayAmount: json['displayAmount'] as String?,
          payment: json['payment'] as double?,
          status: json['status'] as String?,
          rating: json['rating'] as double?,
          ratingFeedback: json['ratingFeedback'] as String?,
          files: json['files'] as List<String>?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'teacherId': teacherId,
        'assignmentId': assignmentId,
        'displayAmount': displayAmount,
        'payment': payment,
        'status': status,
        'rating': rating,
        'ratingFeedback': ratingFeedback,
        'files': files,
      };

  @override
  TeacherAssignmentData fromJson(Map<String, dynamic> json) =>
      TeacherAssignmentData.fromJson(json);

  @override
  String toString() {
    return '_id: $id, teacherId: $teacherId assignmentId: $assignmentId status: $status';
  }
}
