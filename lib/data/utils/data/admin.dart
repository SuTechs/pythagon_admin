import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;

import 'abstract.dart';

class AdminData extends BaseData<AdminData> {
  AdminData({
    this.username,
    this.profilePic,
    this.bio,
    this.gender,
    this.phone,
    this.email,
    this.role,
    this.dateOfBirth,
    this.totalDealAmount,
    this.totalReceivedAmount,
    this.totalWork,
    this.totalPendingWork,
    this.status,

    ///

    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super(id, name, createdAt, updatedAt, BaseData.adminRefName);

  // basic info
  String? username;
  String? profilePic;
  String? bio;
  String? gender;
  String? phone;
  String? email;
  String? role;
  DateTime? dateOfBirth;
  String? status;

  // assignment & payment info
  double? totalDealAmount;
  double? totalReceivedAmount;
  int? totalWork;
  int? totalPendingWork;

  AdminData.fromJson(Map<String, dynamic> json)
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
          role: json['role'] as String?,
          dateOfBirth: json['dateOfBirth'] != null
              ? json['dateOfBirth'].runtimeType == Timestamp
                  ? (json['dateOfBirth'] as Timestamp).toDate()
                  : json['createdAt'] as DateTime
              : null,
          status: json['status'] as String?,
          totalDealAmount: json['totalDealAmount'] as double?,
          totalReceivedAmount: json['totalReceivedAmount'] as double?,
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
        'role': role,
        'dateOfBirth': dateOfBirth,
        'status': status,
        'totalDealAmount': totalDealAmount,
        'totalReceivedAmount': totalReceivedAmount,
        'totalWork': totalWork,
        'totalPendingWork': totalPendingWork,
      };

  @override
  AdminData fromJson(Map<String, dynamic> json) => AdminData.fromJson(json);
}
