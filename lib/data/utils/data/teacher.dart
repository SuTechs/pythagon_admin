import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

/// Teacher Basic Info Data
class TeacherData extends BaseData<TeacherData> {
  TeacherData({
    this.username,
    this.profilePic,
    this.bio,
    this.gender,
    this.phone,
    this.email,
    this.collegeId,
    this.panNumber,
    this.dateOfBirth,
    this.totalPaidAmount,
    this.totalDueAmount,
    this.totalWork,
    this.totalPendingWork,
    this.totalAvgRating,
    this.status,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.teacherRefName);

  // basic info
  String? username;
  String? profilePic;
  String? bio;
  String? gender;
  String? phone;
  String? email;
  String? collegeId;
  String? panNumber;
  DateTime? dateOfBirth;
  String? status;

  // assignment & payment info
  double? totalPaidAmount;
  double? totalDueAmount;
  int? totalWork;
  int? totalPendingWork;
  double? totalAvgRating;

  TeacherData.fromJson(Map<String, dynamic> json)
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
          panNumber: json['panNumber'] as String?,
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
          totalAvgRating: json['totalAvgRating'] as double?,
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
        'panNumber': panNumber,
        'dateOfBirth': dateOfBirth,
        'status': status,
        'totalPaidAmount': totalPaidAmount,
        'totalDueAmount': totalDueAmount,
        'totalWork': totalWork,
        'totalPendingWork': totalPendingWork,
        'totalAvgRating': totalAvgRating,
      };

  @override
  TeacherData fromJson(Map<String, dynamic> json) => TeacherData.fromJson(json);
}

/// Teacher Account Info Data
class TeacherAccountData extends BaseData<TeacherAccountData> {
  TeacherAccountData({
    this.accountNumber,
    this.ifsc,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.teacherAccountRefName);

  String? accountNumber;
  String? ifsc;

  TeacherAccountData.fromJson(Map<String, dynamic> json)
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

          accountNumber: json['accountNumber'] as String?,
          ifsc: json['ifsc'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'accountNumber': accountNumber,
        'ifsc': ifsc,
      };

  @override
  TeacherAccountData fromJson(Map<String, dynamic> json) =>
      TeacherAccountData.fromJson(json);
}

class TeacherDocData extends BaseData<TeacherDocData> {
  TeacherDocData({
    this.panUrl,
    this.idUrl,
    this.marksSheetUrl,

    ///

    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, null, createdAt, updatedAt, BaseData.teacherDocRefName);

  String? panUrl;
  String? idUrl;
  String? marksSheetUrl;

  TeacherDocData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          panUrl: json['panUrl'] as String?,
          idUrl: json['idUrl'] as String?,
          marksSheetUrl: json['marksSheetUrl'] as String?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///

        'panUrl': panUrl,
        'idUrl': idUrl,
        'marksSheetUrl': marksSheetUrl,
      };

  @override
  TeacherDocData fromJson(Map<String, dynamic> json) =>
      TeacherDocData.fromJson(json);

  @override
  String toString() {
    return '_id: $id, id: $idUrl pan: $panUrl marksSheet: $marksSheetUrl';
  }
}

class TeacherSubjectData extends BaseData<TeacherSubjectData> {
  TeacherSubjectData({
    this.teacherID,
    this.subjectId,
    this.status,
    this.rating,
    this.noOfWork,
    this.comment,

    ///

    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, null, createdAt, updatedAt, BaseData.teacherSubjectRefName);

  String? teacherID;
  String? subjectId;
  String? status;
  double? rating;
  int? noOfWork;
  String? comment;

  TeacherSubjectData.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          createdAt: json['createdAt'].runtimeType == Timestamp
              ? (json['createdAt'] as Timestamp).toDate()
              : json['createdAt'] as DateTime,
          updatedAt: json['updatedAt'].runtimeType == Timestamp
              ? (json['updatedAt'] as Timestamp).toDate()
              : json['updatedAt'] as DateTime,

          ///

          teacherID: json['teacherID'] as String?,
          subjectId: json['subjectId'] as String?,
          status: json['status'] as String?,
          comment: json['comment'] as String?,
          rating: json['rating'] as double?,
          noOfWork: json['noOfWork'] as int?,
        );

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt,
        'updatedAt': updatedAt,

        ///
        'teacherID': teacherID,
        'subjectId': subjectId,
        'status': status,
        'comment': comment,
        'rating': rating,
        'noOfWork': noOfWork,
      };

  @override
  TeacherSubjectData fromJson(Map<String, dynamic> json) =>
      TeacherSubjectData.fromJson(json);

  @override
  String toString() {
    return '_id: $id teacherId: $teacherID subjectId: $subjectId';
  }
}
