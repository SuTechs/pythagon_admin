import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

class StudentData extends BaseData<StudentData> {
  StudentData({
    this.username,
    this.profilePic,
    this.bio,
    this.gender,
    this.phone,
    this.email,
    this.collegeId,
    this.dateOfBirth,
    this.totalPaidAmount,
    this.totalDueAmount,
    this.totalWork,
    this.totalPendingWork,
    this.status,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.studentRefName);

  // basic info
  String? username;
  String? profilePic;
  String? bio;
  String? gender;
  String? phone;
  String? email;
  String? collegeId;
  DateTime? dateOfBirth;
  String? status;

  // assignment & payment info
  double? totalPaidAmount;
  double? totalDueAmount;
  int? totalWork;
  int? totalPendingWork;

  StudentData.fromJson(Map<String, dynamic> json)
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

          username: json['username'] as String?,
          profilePic: json['profilePic'] as String?,
          bio: json['bio'] as String?,
          gender: json['gender'] as String?,
          phone: json['phone'] as String?,
          email: json['email'] as String?,
          collegeId: json['collegeId'] as String?,
          dateOfBirth: json['dateOfBirth'] != null
              ? json['dateOfBirth'].runtimeType == Timestamp
                  ? (json['dateOfBirth'] as Timestamp).toDate()
                  : json['createdAt'] as DateTime
              : null,
          status: json['status'] as String?,
          totalPaidAmount: json['totalPaidAmount'] as double?,
          totalDueAmount: json['totalDueAmount'] as double?,
          totalWork: json['totalWork'] as int?,
          totalPendingWork: json['totalPendingWork'] as int?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'username': username,
        'profilePic': profilePic,
        'bio': bio,
        'gender': gender,
        'phone': phone,
        'email': email,
        'collegeId': collegeId,
        'dateOfBirth': dateOfBirth,
        'status': status,
        'totalPaidAmount': totalPaidAmount,
        'totalDueAmount': totalDueAmount,
        'totalWork': totalWork,
        'totalPendingWork': totalPendingWork,
      };

  @override
  StudentData fromJson(Map<String, dynamic> json) => StudentData.fromJson(json);
}
