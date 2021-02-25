import 'package:cloud_firestore/cloud_firestore.dart';
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'student': student.studentId,
        'name': name,
        'description': description,
        'subject': subject!.id,
        'assignmentType': kAssignmentTypeEnumMap[assignmentType],
        'time': time!.toIso8601String(),
        'referenceFiles': referenceFiles,
        'totalAmount': totalAmount,
        'paidAmount': paidAmount,
      };

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json['id'] as String,
      student: Student.fromJson(json['student'] as Map<String, dynamic>),
      name: json['name'] as String,
      description: json['description'] as String,
      subject: Subject.fromJson(json['subject'] as Map<String, dynamic>),
      assignmentType: kAssignmentTypeEnumMap.entries
          .singleWhere((element) => element.value == json['assignmentType'])
          .key,
      time: DateTime.parse(json['time'] as String),
      referenceFiles: (json['referenceFiles'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      totalAmount: (json['totalAmount'] as num).toDouble(),
      paidAmount: (json['paidAmount'] as num).toDouble(),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Assignment &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            name == other.name &&
            student == other.student &&
            description == other.description &&
            subject == other.subject &&
            assignmentType == other.assignmentType &&
            time == other.time &&
            referenceFiles == other.referenceFiles &&
            totalAmount == other.totalAmount &&
            paidAmount == other.paidAmount;
  }

  @override
  int get hashCode => id.hashCode;
}
