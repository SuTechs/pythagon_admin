import 'package:cloud_firestore/cloud_firestore.dart';

///  College course subject

class College {
  static final ref =
      FirebaseFirestore.instance.collection('College').withConverter<College>(
            fromFirestore: (snapshot, _) => College.fromJson(snapshot.data()!),
            toFirestore: (college, _) => college.toJson(),
          );

  late final String id;
  late String name;
  late String img;

  // subjects
  late List<String> subjectsIds;

  /// String -> Student, Teacher, Both
  late String visibility;
  late bool isActive;

  // timeStamp

  late final Timestamp createdAt;
  late Timestamp updatedAt;

  College({
    required this.id,
    required this.name,
    required this.img,
    required this.subjectsIds,
    required this.visibility,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'subjectsIds': subjectsIds,
        'visibility': visibility,
        'isActive': isActive,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  College.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          img: json['img'],
          subjectsIds: json['subjectsIds'],
          visibility: json['visibility'],
          isActive: json['isActive'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class Course {
  static final ref =
      FirebaseFirestore.instance.collection('Course').withConverter<Course>(
            fromFirestore: (snapshot, _) => Course.fromJson(snapshot.data()!),
            toFirestore: (course, _) => course.toJson(),
          );

  late final String id;
  late String name;
  late String img;
  late String location;

  /// String -> Student, Teacher, Both
  late String visibility;
  late bool isActive;

  // timeStamp

  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Course({
    required this.id,
    required this.name,
    required this.img,
    required this.location,
    required this.visibility,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'location': location,
        'visibility': visibility,
        'isActive': isActive,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Course.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          img: json['img'],
          location: json['location'],
          visibility: json['visibility'],
          isActive: json['isActive'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class Subject {
  static final ref =
      FirebaseFirestore.instance.collection('Subject').withConverter<Subject>(
            fromFirestore: (snapshot, _) => Subject.fromJson(snapshot.data()!),
            toFirestore: (subject, _) => subject.toJson(),
          );

  late final String id;
  late String name;
  late String img;

  /// String -> Student, Teacher, Both
  late String visibility;
  late bool isActive;

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Subject({
    required this.id,
    required this.name,
    required this.img,
    required this.visibility,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'img': img,
        'visibility': visibility,
        'isActive': isActive,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Subject.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          img: json['img'],
          visibility: json['visibility'],
          isActive: json['isActive'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

/// Student
///
/// [totalPaidAmount] this need to be handle cuz theres payment made
/// in different currency
///

class Student {
  static final ref =
      FirebaseFirestore.instance.collection('Student').withConverter<Student>(
            fromFirestore: (snapshot, _) => Student.fromJson(snapshot.data()!),
            toFirestore: (student, _) => student.toJson(),
          );

  late final String id;
  late String username;

  // basic info
  late String name;
  late String profilePic;
  late String bio;
  late String dateOfBirth;
  late String gender;
  late String phone;
  late String email;

  // course detail
  late String courseId;
  late String collegeId;

  // assignment & payment info

  late double totalPaidAmount;
  late double totalDueAmount;
  late String totalWork;
  late String totalPendingWork;

  // timeStamp

  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Student({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
    required this.bio,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.courseId,
    required this.collegeId,
    required this.totalPaidAmount,
    required this.totalDueAmount,
    required this.totalWork,
    required this.totalPendingWork,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'profilePic': profilePic,
        'bio': bio,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phone': phone,
        'email': email,
        'courseId': courseId,
        'collegeId': collegeId,
        // ToDO: Something need to be done about amount
        'totalPaidAmount': totalPaidAmount,
        'totalDueAmount': totalDueAmount,
        'totalWork': totalWork,
        'totalPendingWork': totalPendingWork,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Student.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          username: json['username'],
          name: json['name'],
          profilePic: json['profilePic'],
          bio: json['bio'],
          dateOfBirth: json['dateOfBirth'],
          gender: json['gender'],
          phone: json['phone'],
          email: json['email'],
          courseId: json['courseId'],
          collegeId: json['collegeId'],
          totalPaidAmount: json['totalPaidAmount'],
          totalDueAmount: json['totalDueAmount'],
          totalWork: json['totalWork'],
          totalPendingWork: json['totalPendingWork'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

/// Admin

class Admin {
  static final adminRef =
      FirebaseFirestore.instance.collection('Admin').withConverter<Admin>(
            fromFirestore: (snapshot, _) => Admin.fromJson(snapshot.data()!),
            toFirestore: (admin, _) => admin.toJson(),
          );

  late final String id;
  late String username;

  // basic info
  late String name;
  late String profilePic;
  late String bio;
  late String dateOfBirth;
  late String gender;
  late String phone;
  late String email;

  // admin role
  late String role;

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Admin({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
    required this.bio,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'profilePic': profilePic,
        'bio': bio,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phone': phone,
        'email': email,
        'role': role,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Admin.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          username: json['username'],
          name: json['name'],
          profilePic: json['profilePic'],
          bio: json['bio'],
          dateOfBirth: json['dateOfBirth'],
          gender: json['gender'],
          phone: json['phone'],
          email: json['email'],
          role: json['role'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

/// Transaction

class Transaction {
  static final ref = FirebaseFirestore.instance
      .collection('Transaction')
      .withConverter<Transaction>(
        fromFirestore: (snapshot, _) => Transaction.fromJson(snapshot.data()!),
        toFirestore: (transaction, _) => transaction.toJson(),
      );

  late final String id;
  late double amount;
  late String attachment;
  late String comment;
  late String type; // transaction type
  late bool isExpense;
  late bool isCredit;
  late String adminId;
  late String? assignmentId;
  late String? teacherId;

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.attachment,
    required this.comment,
    required this.isCredit,
    required this.adminId,
    this.assignmentId,
    this.teacherId,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'type': type,
        'attachment': attachment,
        'comment': comment,
        'isCredit': isCredit,
        'adminId': adminId,
        'assignmentId': assignmentId,
        'teacherId': teacherId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Transaction.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          amount: json['amount'],
          type: json['type'],
          attachment: json['attachment'],
          comment: json['comment'],
          isCredit: json['isCredit'],
          adminId: json['adminId'],
          assignmentId: json['assignmentId'],
          teacherId: json['teacherId'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

///
///
/// Teacher
///
///

class Teacher {
  static final ref =
      FirebaseFirestore.instance.collection('Teacher').withConverter<Teacher>(
            fromFirestore: (snapshot, _) => Teacher.fromJson(snapshot.data()!),
            toFirestore: (teacher, _) => teacher.toJson(),
          );

  late final String id;

  // basic info
  late String name;
  late String username;
  late String profilePic;
  late String bio;
  late String dateOfBirth;
  late String gender;
  late String phone;
  late String email;
  late String panNumber;
  late String collegeId;

  // work info
  late double totalPaidAmount;
  late double totalDueAmount;
  late int totalWork;
  late int totalPendingWork;
  late double totalAvgRating;

  // status
  late String status; // teacher status

  // timeStamp

  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Teacher({
    required this.id,
    required this.username,
    required this.name,
    required this.profilePic,
    required this.bio,
    required this.dateOfBirth,
    required this.gender,
    required this.phone,
    required this.email,
    required this.panNumber,
    required this.collegeId,
    required this.totalPaidAmount,
    required this.totalDueAmount,
    required this.totalWork,
    required this.totalPendingWork,
    required this.totalAvgRating,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'name': name,
        'profilePic': profilePic,
        'bio': bio,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'phone': phone,
        'email': email,
        'collegeId': collegeId,
        'panNumber': panNumber,

        // ToDO: Something need to be done about amount
        'totalPaidAmount': totalPaidAmount,
        'totalDueAmount': totalDueAmount,
        'totalWork': totalWork,
        'totalPendingWork': totalPendingWork,
        'totalAvgRating': totalAvgRating,

        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Teacher.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          username: json['username'],
          name: json['name'],
          profilePic: json['profilePic'],
          bio: json['bio'],
          dateOfBirth: json['dateOfBirth'],
          gender: json['gender'],
          phone: json['phone'],
          email: json['email'],
          panNumber: json['panNumber'],
          collegeId: json['collegeId'],
          totalPaidAmount: json['totalPaidAmount'],
          totalDueAmount: json['totalDueAmount'],
          totalWork: json['totalWork'],
          totalPendingWork: json['totalPendingWork'],
          totalAvgRating: json['totalAvgRating'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class TeacherAccountInfo {
  static final ref = FirebaseFirestore.instance
      .collection('TeacherAccountInfo')
      .withConverter<TeacherAccountInfo>(
        fromFirestore: (snapshot, _) =>
            TeacherAccountInfo.fromJson(snapshot.data()!),
        toFirestore: (teacherAccountInfo, _) => teacherAccountInfo.toJson(),
      );

  late final String id;
  late String name;
  late String accountNumber;
  late String ifsc;
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  TeacherAccountInfo({
    required this.id,
    required this.name,
    required this.accountNumber,
    required this.ifsc,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': accountNumber,
        'ifsc': ifsc,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  TeacherAccountInfo.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          name: json['name'],
          accountNumber: json['accountNumber'],
          ifsc: json['ifsc'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class TeacherDocInfo {
  static final ref = FirebaseFirestore.instance
      .collection('TeacherDocInfo')
      .withConverter<TeacherDocInfo>(
        fromFirestore: (snapshot, _) =>
            TeacherDocInfo.fromJson(snapshot.data()!),
        toFirestore: (teacherDocInfo, _) => teacherDocInfo.toJson(),
      );

  late final String id;
  late String panUrl;
  late String idUrl;
  late String marksSheetUrl;
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  TeacherDocInfo({
    required this.id,
    required this.panUrl,
    required this.idUrl,
    required this.marksSheetUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'panUrl': panUrl,
        'idUrl': idUrl,
        'marksSheetUrl': marksSheetUrl,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  TeacherDocInfo.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          panUrl: json['panUrl'],
          idUrl: json['idUrl'],
          marksSheetUrl: json['marksSheetUrl'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class TeacherSubject {
  static final ref = FirebaseFirestore.instance
      .collection('TeacherSubject')
      .withConverter<TeacherSubject>(
        fromFirestore: (snapshot, _) =>
            TeacherSubject.fromJson(snapshot.data()!),
        toFirestore: (teacherSubject, _) => teacherSubject.toJson(),
      );

  late final String id;
  late final String teacherID;
  late final String courseId;
  late final String subjectId;
  late String status; // TeacherSubjectStatus
  late double rating;
  late int noOfWork;
  late String comment;

  // Time Stamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  TeacherSubject({
    required this.id,
    required this.teacherID,
    required this.courseId,
    required this.subjectId,
    required this.status,
    required this.rating,
    required this.noOfWork,
    required this.comment,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'teacherID': teacherID,
        'courseId': courseId,
        'subjectId': subjectId,
        'status': status,
        'rating': rating,
        'noOfWork': noOfWork,
        'comment': comment,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  TeacherSubject.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          teacherID: json['teacherID'],
          courseId: json['courseId'],
          subjectId: json['subjectId'],
          status: json['status'],
          rating: json['rating'],
          noOfWork: json['noOfWork'],
          comment: json['comment'],
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

///
/// Assignment
///

class Assignment {
  static final ref = FirebaseFirestore.instance
      .collection('Assignment')
      .withConverter<Assignment>(
        fromFirestore: (snapshot, _) => Assignment.fromJson(snapshot.data()!),
        toFirestore: (assignment, _) => assignment.toJson(),
      );

  late final String id;
  late final String createdBy; // adminId
  late final String studentId;

  // info
  late String assignmentType;
  late String title;
  late String description;
  late String subjectID;
  late String courseId;
  late Timestamp dueDate;
  late List<String> files;

  // payment
  late double dealAmount;
  late double taxAmount;
  late double totalAmount;
  late double dueAmount;

  // status
  late String status; // assignment status

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  Assignment({
    required this.id,
    required this.createdBy,
    required this.studentId,
    //
    required this.assignmentType,
    required this.title,
    required this.description,
    required this.subjectID,
    required this.courseId,
    required this.dueDate,
    required this.files,
    //
    required this.dealAmount,
    required this.taxAmount,
    required this.totalAmount,
    required this.dueAmount,
    //
    required this.status,
    //
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdBy': createdBy,
        'studentId': studentId,
        //
        'assignmentType': assignmentType,
        'title': title,
        'description': description,
        'subjectID': subjectID,
        'courseId': courseId,
        'dueDate': dueDate,
        'files': files,
        //
        'dealAmount': dealAmount,
        'taxAmount': taxAmount,
        'totalAmount': totalAmount,
        'dueAmount': dueAmount,
        //
        'status': status,
        //
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  Assignment.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          createdBy: json['createdBy'],
          studentId: json['studentId'],
          //
          assignmentType: json['assignmentType'],
          title: json['title'],
          description: json['description'],
          subjectID: json['subjectID'],
          courseId: json['courseId'],
          dueDate: json['dueDate'],
          files: json['files'],
          //
          dealAmount: json['dealAmount'],
          taxAmount: json['taxAmount'],
          totalAmount: json['totalAmount'],
          dueAmount: json['dueAmount'],
          //
          status: json['status'],
          //
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

class AssignmentActivity {
  static final ref = FirebaseFirestore.instance
      .collection('AssignmentActivity')
      .withConverter<AssignmentActivity>(
        fromFirestore: (snapshot, _) =>
            AssignmentActivity.fromJson(snapshot.data()!),
        toFirestore: (a, _) => a.toJson(),
      );

  late final String id;
  late final String assignmentId; // adminId
  late final String adminId;

  // info
  late final String title;
  late final String description;

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  AssignmentActivity({
    required this.id,
    required this.assignmentId,
    required this.adminId,
    //
    required this.title,
    required this.description,
    //
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'assignmentId': assignmentId,
        'adminId': adminId,
        //
        'title': title,
        'description': description,
        //
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  AssignmentActivity.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          assignmentId: json['assignmentId'],
          adminId: json['adminId'],
          //
          title: json['title'],
          description: json['description'],
          //
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}

/// TeacherAssignment
class TeacherAssignment {
  static final ref = FirebaseFirestore.instance
      .collection('TeacherAssignment')
      .withConverter<TeacherAssignment>(
        fromFirestore: (snapshot, _) =>
            TeacherAssignment.fromJson(snapshot.data()!),
        toFirestore: (teacherAssignment, _) => teacherAssignment.toJson(),
      );

  late final String id;
  late final String teacherId; // adminId
  late final String assignmentId;

  // payment
  late String displayAmount;
  late double payment;

  // status
  late String status; // teacher assignment status

  // rating
  late double rating;
  late String ratingFeedback;

  // files
  late List<String> files;

  // timeStamp
  late final Timestamp createdAt;
  late Timestamp updatedAt;

  TeacherAssignment({
    required this.id,
    required this.teacherId,
    required this.assignmentId,
    //
    required this.displayAmount,
    required this.payment,
    //
    required this.status,
    //
    required this.files,
    //
    required this.rating,
    required this.ratingFeedback,
    //
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'teacherId': teacherId,
        'assignmentId': assignmentId,
        //
        'displayAmount': displayAmount,
        'payment': payment,
        //
        'status': status,
        //
        'files': files,
        //
        'rating': rating,
        'ratingFeedback': ratingFeedback,
        //
        'createdAt': createdAt,
        'updatedAt': updatedAt,
      };

  TeacherAssignment.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'],
          teacherId: json['teacherId'],
          assignmentId: json['assignmentId'],
          //
          displayAmount: json['displayAmount'],
          payment: json['payment'],
          //
          status: json['status'],
          //
          files: json['files'],
          //
          rating: json['rating'],
          ratingFeedback: json['ratingFeedback'],
          //
          createdAt: json['createdAt'],
          updatedAt: json['updatedAt'],
        );
}
