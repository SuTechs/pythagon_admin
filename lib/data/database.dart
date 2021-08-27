import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/utils/NotificationSender.dart';

import '/data/utils/modal/collectionRef.dart';
import '/data/utils/modal/user.dart';
import '/widgets/showToast.dart';

class College {
  final String collegeName;
  final String collegeId;

  College({required this.collegeName, required this.collegeId});

  Map<String, dynamic> toJson() => {
        'collegeName': collegeName,
        'collegeId': collegeId,
        'createdAt': Timestamp.now(),
      };

  factory College.fromJson(Map<String, dynamic> json) => College(
        collegeName: json['collegeName'],
        collegeId: json['collegeId'],
      );

  Future<void> addCollege() async {
    await CollectionRef.colleges.doc(collegeId).set(toJson()).catchError((e) {
      print('Error #2526 $e');
    });
    _colleges.add(this);
  }

  static final List<College> _colleges = [];

  static Future<List<College>> getColleges() async {
    if (_colleges.isNotEmpty) return _colleges;

    final data = await CollectionRef.colleges.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      _colleges.add(College.fromJson(snapshot.data()));

    return _colleges;
  }
}

class Course {
  final String courseName;
  final String courseId;

  Course({required this.courseName, required this.courseId});

  Map<String, dynamic> toJson() => {
        'courseName': courseName,
        'courseId': courseId,
        'createdAt': Timestamp.now(),
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json['courseName'],
        courseId: json['courseId'],
      );

  Future<void> addCourse() async {
    _courses.add(this);
    await CollectionRef.courses.doc(courseId).set(toJson());
  }

  static final List<Course> _courses = [];

  static Future<List<Course>> getCourses() async {
    if (_courses.isNotEmpty) return _courses;

    final data = await CollectionRef.courses.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      _courses.add(Course.fromJson(snapshot.data()));

    return _courses;
  }
}

class Student {
  final String studentId;
  final String name;
  final String phone;
  final String profilePic;
  final String email;
  final String dateOfBirth;
  final String gender;
  final College college;
  final Course course;

  Student({
    required this.studentId,
    required this.name,
    required this.phone,
    required this.profilePic,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.college,
    required this.course,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'studentId': studentId,
        'name': name,
        'phone': phone,
        'profilePic': profilePic,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'college': college.collegeName,
        'course': course.courseId,
        isEdit ? 'updatedAt' : 'createdAt': Timestamp.now(),
      };

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentId: json['studentId'],
      name: json['name'],
      phone: json['phone'],
      profilePic: json['profilePic'],
      email: json['email'],
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      college:
          College(collegeId: json['college'], collegeName: json['college']),
      course: Course(courseId: json['course'], courseName: json['course']),
    );
  }

  Future<void> addOrUpdateStudent(bool isEdit) async {
    print('update student');
    await CollectionRef.students.doc(studentId).set(toJson(isEdit));
    _students.clear();
  }

  static final List<Student> _students = [];

  static Future<List<Student>> getStudents() async {
    if (_students.isNotEmpty) return _students;
    final data = await CollectionRef.students.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      _students.add(Student.fromJson(snapshot.data()));

    return _students;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Student &&
            runtimeType == other.runtimeType &&
            studentId == other.studentId &&
            name == other.name &&
            phone == other.phone &&
            profilePic == other.profilePic &&
            college.collegeId == other.college.collegeId &&
            course.courseId == other.course.courseId &&
            dateOfBirth == other.dateOfBirth &&
            gender == other.gender &&
            email == other.email;
  }

  @override
  int get hashCode => studentId.hashCode ^ name.hashCode;
}

class Subject {
  static final List<Subject> subjects = [];
  final String id;
  final String name;
  final String image;
  final bool isEnable;

  Subject({
    required this.id,
    required this.name,
    required this.image,
    required this.isEnable,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'name': name,
        'image': image,
        'isEnable': isEnable,
        if (isEdit)
          'updatedAt': Timestamp.now()
        else
          'createdAt': Timestamp.now(),
      };

  Future<void> addOrEditSubject(bool isEdit) async {
    try {
      if (isEdit) {
        await CollectionRef.subjects.doc(id).update(toJson(isEdit));
        subjects.remove(this);
      } else
        await CollectionRef.subjects.doc(id).set(toJson(isEdit));
      subjects.add(this);
    } catch (e) {
      print('Error #24351 = $e');
    }
  }

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      isEnable: json['isEnable'] ?? false,
    );
  }

  static Future<List<Subject>> getSubjects() async {
    if (subjects.isNotEmpty) return subjects;

    final data = await CollectionRef.subjects.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      subjects.add(Subject.fromJson(snapshot.data()));

    return subjects;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Subject && runtimeType == other.runtimeType && id == other.id;
  }

  @override
  int get hashCode => id.hashCode;
}

enum AssignmentType { Session, Assignment }

const kAssignmentTypeEnumMap = {
  AssignmentType.Assignment: 'Assignment',
  AssignmentType.Session: 'Session',
};

class Assignment {
  final String id;
  final String createdBy;
  Student student;
  String? name;
  String? description;
  Subject? subject;
  AssignmentType? assignmentType;
  Currency currency;
  DateTime? time;
  List<String> referenceFiles;
  List<String> assignmentFiles;
  double? totalAmount;
  double paidAmount;

  Assignment({
    required this.id,
    required this.createdBy,
    required this.student,
    this.name,
    this.description,
    this.subject,
    this.assignmentType,
    required this.currency,
    this.time,
    required this.referenceFiles,
    required this.assignmentFiles,
    this.totalAmount,
    this.paidAmount = 0,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'createdBy': createdBy,
        'student': student.studentId,
        'name': name,
        'description': description,
        'subject': subject != null ? subject!.id : null,
        'assignmentType': assignmentType != null
            ? kAssignmentTypeEnumMap[assignmentType]
            : null,
        'currency': kCurrencyEnumMap[currency],
        'time': time != null ? Timestamp.fromDate(time!) : null,
        'referenceFiles': referenceFiles,
        'assignmentFiles': assignmentFiles,
        'totalAmount': totalAmount,
        'paidAmount': paidAmount,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      };

  static Future<Assignment> getAssignmentFromData(
      Map<String, dynamic> json) async {
    final students = await Student.getStudents();
    final subjects = await Subject.getSubjects();

    return Assignment(
      id: json['id'],
      createdBy: json['createdBy'],
      student: students
          .where((element) => element.studentId == json['student'])
          .first,
      name: json['name'],
      description: json['description'],
      subject: subjects.where((element) => element.id == json['subject']).first,
      assignmentType: kAssignmentTypeEnumMap.entries
          .singleWhere((element) => element.value == json['assignmentType'])
          .key,
      currency: json['currency'] != null
          ? kCurrencyEnumMap.entries
              .singleWhere((element) => element.value == json['currency'])
              .key
          : Currency.INR,
      // ToDo: for now because there are assignment with no currency
      time: (json['time'] as Timestamp).toDate(),
      referenceFiles: json['referenceFiles'] != null
          ? (json['referenceFiles'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      assignmentFiles: json['assignmentFiles'] != null
          ? (json['assignmentFiles'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
      totalAmount: json['totalAmount'],
      paidAmount: json['paidAmount'],
    );
  }

  @override
  bool operator ==(Object other) {
    // if (other is Assignment) {
    //   print('\n\nidentical = ${identical(this, other)}');
    //   print('typeCast = ${other is Assignment}');
    //   print('runTimeType = ${runtimeType == other.runtimeType}');
    //   print('id = ${id == other.id}');
    //   print('name = ${name == other.name}');
    //   print('studentId = ${student.studentId == other.student.studentId}');
    //   print('desc = ${description == other.description}');
    //   print('subject = ${subject == other.subject}');
    //   print('assignType = ${assignmentType == other.assignmentType}');
    //   print('time = ${time == other.time}');
    //   print('files = ${listEquals(referenceFiles, other.referenceFiles)}');
    //   print('totalAmount = ${totalAmount == other.totalAmount}');
    //   print('paidAmount = ${paidAmount == other.paidAmount}\n\n');
    // }

    return identical(this, other) ||
        other is Assignment &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            student.studentId == other.student.studentId &&
            description == other.description &&
            subject == other.subject &&
            assignmentType == other.assignmentType &&
            currency == other.currency &&
            time == other.time &&
            listEquals(referenceFiles, other.referenceFiles) &&
            totalAmount == other.totalAmount &&
            paidAmount == other.paidAmount;
  }

  @override
  int get hashCode => id.hashCode;

  /// assignment logic
  Future<void> addOrUpdateAssignment(bool isEdit) async {
    print('${isEdit ? 'Update' : 'Create'} assignment');

    if (isEdit)
      await CollectionRef.assignments.doc(id).update(toJson(isEdit));
    else
      await CollectionRef.assignments.doc(id).set(toJson(isEdit));
  }

  Future<void> settleUp(double amount) async {
    await CollectionRef.assignments.doc(id).update({
      'paidAmount': paidAmount,
      'updatedAt': Timestamp.now(),
      'settleUps': FieldValue.arrayUnion([
        {'amount': amount, 'time': Timestamp.now()}
      ]),
    });
  }
}

/// teachers
enum TeacherAssignmentStatus {
  Sent,
  Interested,
  NotInterested,
  Assigned,
  NotAssigned,
  Completed,
  Rejected,
  Closed,
  Rated
}

const kTeacherAssignmentStatusEnumMap = {
  TeacherAssignmentStatus.Sent: 'Sent',
  TeacherAssignmentStatus.Interested: 'Interested',
  TeacherAssignmentStatus.NotInterested: 'Not Interested',
  TeacherAssignmentStatus.Assigned: 'Assigned',
  TeacherAssignmentStatus.NotAssigned: 'Not Assigned',
  TeacherAssignmentStatus.Completed: 'Completed',
  TeacherAssignmentStatus.Rejected: 'Rejected',
  TeacherAssignmentStatus.Closed: 'Closed',
  TeacherAssignmentStatus.Rated: 'Rated'
};

class TeacherRating {
  final double performance;
  final double accuracy;
  final double availability;

  double get avgRating => (performance + accuracy + availability) / 3;

  TeacherRating(
      {required this.performance,
      required this.accuracy,
      required this.availability});

  Map<String, dynamic> toJson() => {
        'performance': performance,
        'accuracy': accuracy,
        'availability': availability,
      };

  factory TeacherRating.fromJson(Map<String, dynamic> json) {
    return TeacherRating(
        performance: json['performance'],
        accuracy: json['accuracy'],
        availability: json['availability']);
  }
}

class Teacher {
  static final List<Teacher> _teachers = [];
  final String id;
  final String name;
  final String phone;
  final String profilePic;
  final String email;
  final TeacherRating rating;
  final int totalRating;
  final String dateOfBirth;
  final String gender;
  final College college;
  final List<String> subjectsIds;
  final double balance;
  final bool isVerified;
  final Course course;
  final String accountInfo;
  final List<String> tokens;

  Teacher({
    required this.id,
    required this.name,
    required this.phone,
    required this.profilePic,
    required this.email,
    required this.rating,
    required this.subjectsIds,
    required this.dateOfBirth,
    required this.gender,
    required this.college,
    required this.balance,
    required this.totalRating,
    required this.isVerified,
    required this.course,
    required this.accountInfo,
    required this.tokens,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Teacher &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            phone == other.phone &&
            email == other.email &&
            college.collegeId == other.college.collegeId &&
            listEquals(subjectsIds, other.subjectsIds) &&
            dateOfBirth == other.dateOfBirth &&
            gender == other.gender &&
            isVerified == other.isVerified &&
            course.courseId == other.course.courseId &&
            accountInfo == other.accountInfo &&
            email == other.email;
  }

  @override
  int get hashCode => id.hashCode ^ phone.hashCode;

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'name': name,
        'phone': phone,
        'profilePic': profilePic,
        'email': email,
        'subjects': subjectsIds,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'college': college.collegeName,
        'rating': rating.toJson(),
        'totalRating': totalRating,
        'balance': balance,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'isVerified': isVerified,
        'course': course.courseName,
        'accountInfo': accountInfo,
        'tokens': tokens,
      };

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      balance: json['balance'] ?? 0,
      profilePic: json['profilePic'],
      subjectsIds:
          (json['subjects'] as List<dynamic>).map((e) => e as String).toList(),
      rating: TeacherRating.fromJson(json['rating']),
      totalRating: json['totalRating'] ?? 0,
      dateOfBirth: json['dateOfBirth'],
      gender: json['gender'],
      college:
          College(collegeId: json['college'], collegeName: json['college']),
      course: Course(
          courseId: json['course'] ?? 'Select Course',
          courseName: json['course'] ?? 'Select Course'),
      isVerified: json['isVerified'] ?? false,
      accountInfo: json['accountInfo'] ?? '',
      tokens: json['tokens'] !=
              null // ToDo: remove this after every teacher can have token
          ? (json['tokens'] as List<dynamic>).map((e) => e as String).toList()
          : [],
    );
  }

  static Future<List<Teacher>> getTeachers() async {
    if (_teachers.isNotEmpty) return _teachers;

    final data = await CollectionRef.teachers.get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      _teachers.add(Teacher.fromJson(snapshot.data()));

    _teachers.sort((a, b) => a.name.compareTo(b.name));

    return _teachers;
  }

  static void resetTeachers() {
    _teachers.clear();
  }

  Future<void> addOrUpdateTeacher(bool isEdit) async {
    print('${isEdit ? 'Update' : 'Create'} teacher');

    if (isEdit) {
      await CollectionRef.teachers.doc(id).update(toJson(isEdit));
      _teachers.removeWhere((element) => element.id == id);
    } else
      await CollectionRef.teachers.doc(id).set(toJson(isEdit));

    _teachers.add(this);
  }
}

class TeachersAssignments {
  final String id;
  final String assignmentId;
  final Teacher teacher;
  final double amount;
  final DateTime time;
  final TeacherAssignmentStatus status;
  final TeacherRating? rating;
  final List<String> assignmentFiles;

  TeachersAssignments({
    required this.id,
    required this.assignmentId,
    required this.teacher,
    required this.amount,
    required this.time,
    required this.status,
    this.rating,
    required this.assignmentFiles,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'assignmentId': assignmentId,
        'teacher': teacher.id,
        'amount': amount,
        if (isEdit) 'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'status': kTeacherAssignmentStatusEnumMap[status],
        'rating': rating != null ? rating!.toJson() : null,
        'assignmentFiles': assignmentFiles,
      };

  factory TeachersAssignments.fromJson(
      Map<String, dynamic> json, List<Teacher> teachers) {
    return TeachersAssignments(
      id: json['id'],
      assignmentId: json['assignmentId'],
      teacher: teachers.firstWhere((element) => element.id == json['teacher']),
      amount: json['amount'],
      time: (json['updatedAt'] as Timestamp).toDate(),
      status: kTeacherAssignmentStatusEnumMap.entries
          .singleWhere((element) => element.value == json['status'])
          .key,
      rating: json['rating'] != null
          ? TeacherRating.fromJson(json['rating'])
          : null,
      assignmentFiles: json['assignmentFiles'] != null
          ? (json['assignmentFiles'] as List<dynamic>)
              .map((e) => e as String)
              .toList()
          : [],
    );
  }

  /// float assignments
  static Future<void> floatAssignments(
      List<String> selectedTeachers, String assignmentId, double amount) async {
    /// creating teachers assignments
    for (String teacherId in selectedTeachers) {
      final id = '${DateTime.now().millisecondsSinceEpoch}';

      await CollectionRef.teachersAssignments.doc(id).set({
        'id': id,
        'assignmentId': assignmentId,
        'teacher': teacherId,
        'amount': amount,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
        'status': kTeacherAssignmentStatusEnumMap[TeacherAssignmentStatus.Sent],
      });
    }

    // ToDO: change logic -> send notification to individual teacher and remove token on error

    /// send notification
    final allTeachers = await Teacher.getTeachers();
    final List<Teacher> sT = [];
    for (String teacherId in selectedTeachers) {
      final t = allTeachers.where((element) => element.id == teacherId).first;
      sT.add(t);
    }
    final List<String> allTokens = [];
    sT.forEach((element) {
      allTokens.addAll(element.tokens);
    });

    final n = NotificationModal(
        from: UserData.authData!.uid,
        to: 'tutors',
        title: 'New Assignment!',
        body: 'You have new assignment! Check Now.');
    n.send(allTokens);
  }

  /// change status
  static Future<void> changeStatus(TeacherAssignmentStatus status, String id,
      {required String teacherId,
      required double amount,
      required String assignmentId}) async {
    await CollectionRef.teachersAssignments.doc(id).update({
      'status': kTeacherAssignmentStatusEnumMap[status],
      'updatedAt': Timestamp.now(),
    });

    if (status == TeacherAssignmentStatus.Closed) {
      await Transaction.createTransaction(teacherId, amount, false,
          assignmentId: assignmentId);
    }
  }

  /// update files
  static Future<void> updateFiles(List<String> files, String id) async {
    await CollectionRef.teachersAssignments.doc(id).update({
      'assignmentFiles': files,
      'updatedAt': Timestamp.now(),
    });
  }

  /// rate
  static Future<void> rate(TeacherRating rating, String teacherId, String id,
      TeacherRating currentRating, int totalCurrentRating) async {
    /// adding rating in teacher assignment
    await CollectionRef.teachersAssignments.doc(id).update({
      'rating': rating.toJson(),
      'status': kTeacherAssignmentStatusEnumMap[TeacherAssignmentStatus.Rated],
      'updatedAt': Timestamp.now(),
    });

    /// adding rating in teacher
    totalCurrentRating += 1;
    final teacherRating = TeacherRating(
        performance: (rating.performance + currentRating.performance) /
            totalCurrentRating,
        accuracy: (rating.performance + currentRating.performance) /
            totalCurrentRating,
        availability: (rating.performance + currentRating.performance) /
            totalCurrentRating);

    await CollectionRef.teachers.doc(teacherId).update({
      'rating': teacherRating.toJson(),
      'totalRating': totalCurrentRating,
      'updatedAt': Timestamp.now(),
    }).then((value) {
      Teacher.resetTeachers();
    });
  }
}

/// transactions

class Transaction {
  final String id;
  final double amount;
  final double closingBalance;
  final String teacherId;
  final String adminId;
  final DateTime createdAt;
  final bool isWithdrawn;
  final String? assignmentId;

  Transaction({
    required this.id,
    required this.amount,
    required this.closingBalance,
    required this.teacherId,
    required this.adminId,
    required this.createdAt,
    required this.isWithdrawn,
    this.assignmentId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'closingBalance': closingBalance,
        'teacherId': teacherId,
        'adminId': adminId,
        'createdAt': Timestamp.fromDate(createdAt),
        'isWithdrawn': isWithdrawn,
        if (assignmentId != null) 'assignmentId': assignmentId,
      };

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: json['amount'],
      closingBalance: json['closingBalance'],
      teacherId: json['teacherId'],
      adminId: json['adminId'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      isWithdrawn: json['isWithdrawn'],
    );
  }

  static Future<List<Transaction>> getTransaction(String teacherId) async {
    final List<Transaction> _transactions = [];

    final data = await CollectionRef.transactions
        .where('teacherId', isEqualTo: teacherId)
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> snapshot in data.docs)
      _transactions.add(Transaction.fromJson(snapshot.data()));

    _transactions.sort((a, b) => a.createdAt.compareTo(b.createdAt));

    return _transactions;
  }

  static Future<Transaction?> createTransaction(
      String teacherId, double amount, bool isWithdrawn,
      {String? assignmentId}) async {
    final data = await CollectionRef.teachers.doc(teacherId).get();
    if (data.data() == null) {
      showToast('Teacher Not Found #32311');
      return null;
    }

    final teacher = Teacher.fromJson(data.data()!);
    final cb =
        isWithdrawn ? teacher.balance - amount : teacher.balance + amount;

    // adding transaction
    final transaction = Transaction(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      amount: amount,
      closingBalance: cb,
      teacherId: teacherId,
      adminId: UserData.authData!.email!,
      createdAt: DateTime.now(),
      isWithdrawn: isWithdrawn,
      assignmentId: assignmentId,
    );

    await CollectionRef.transactions
        .doc(transaction.id)
        .set(transaction.toJson());

    // updating teacher collection
    await CollectionRef.teachers.doc(teacherId).update({
      'balance': cb,
      'updatedAt': Timestamp.now(),
    }).then((value) {
      Teacher.resetTeachers();
    });

    return transaction;
  }
}

/// currency
enum Currency {
  USD,
  INR,
  CAD,
}

const kCurrencyEnumMap = {
  Currency.USD: 'USD',
  Currency.INR: 'INR',
  Currency.CAD: 'CAD',
};
