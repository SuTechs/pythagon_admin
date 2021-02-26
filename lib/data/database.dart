import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/utils/modal/collectionRef.dart';

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

    for (QueryDocumentSnapshot snapshot in data.docs)
      if (snapshot.data() != null)
        _colleges.add(College.fromJson(snapshot.data()!));

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

    for (QueryDocumentSnapshot snapshot in data.docs)
      if (snapshot.data() != null)
        _courses.add(Course.fromJson(snapshot.data()!));

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

    for (QueryDocumentSnapshot snapshot in data.docs)
      if (snapshot.data() != null)
        _students.add(Student.fromJson(snapshot.data()!));

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
  static final List<Subject> _subjects = [];
  final String id;
  final String name;
  final String image;

  Subject({required this.id, required this.name, required this.image});

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
      };

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }

  static Future<List<Subject>> getSubjects() async {
    if (_subjects.isNotEmpty) return _subjects;

    final data = await CollectionRef.subjects.get();

    for (QueryDocumentSnapshot snapshot in data.docs)
      if (snapshot.data() != null)
        _subjects.add(Subject.fromJson(snapshot.data()!));

    return _subjects;
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
  Student student;
  String? name;
  String? description;
  Subject? subject;
  AssignmentType? assignmentType;
  DateTime? time;
  List<String> referenceFiles;
  double? totalAmount;
  double paidAmount;
  double? get dueAmount {
    if (totalAmount == null) return null;
    return totalAmount! - paidAmount;
  }

  Assignment({
    required this.id,
    required this.student,
    this.name,
    this.description,
    this.subject,
    this.assignmentType,
    this.time,
    required this.referenceFiles,
    this.totalAmount,
    this.paidAmount = 0,
  });

  Map<String, dynamic> toJson(bool isEdit) => {
        'id': id,
        'student': student.studentId,
        'name': name,
        'description': description,
        'subject': subject != null ? subject!.id : null,
        'assignmentType': assignmentType != null
            ? kAssignmentTypeEnumMap[assignmentType]
            : null,
        'time': time != null ? Timestamp.fromDate(time!) : null,
        'referenceFiles': referenceFiles,
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
      student: students
          .where((element) => element.studentId == json['student'])
          .first,
      name: json['name'],
      description: json['description'],
      subject: subjects.where((element) => element.id == json['subject']).first,
      assignmentType: kAssignmentTypeEnumMap.entries
          .singleWhere((element) => element.value == json['assignmentType'])
          .key,
      time: (json['time'] as Timestamp).toDate(),
      referenceFiles: (json['referenceFiles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
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
