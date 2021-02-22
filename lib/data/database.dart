class College {
  final String collegeName;
  final String collegeId;

  College({required this.collegeName, required this.collegeId});

  Map<String, dynamic> toJson() => {
        'collegeName': collegeName,
        'collegeId': collegeId,
      };

  factory College.fromJson(Map<String, dynamic> json) => College(
        collegeName: json['collegeName'],
        collegeId: json['collegeId'],
      );
}

class Course {
  final String courseName;
  final String courseId;

  Course({required this.courseName, required this.courseId});

  Map<String, dynamic> toJson() => {
        'collegeName': courseName,
        'collegeId': courseId,
      };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        courseName: json['courseName'],
        courseId: json['collegeId'],
      );
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

  Map<String, dynamic> toJson() => {
        'studentId': studentId,
        'name': name,
        'phone': phone,
        'profilePic': profilePic,
        'email': email,
        'dateOfBirth': dateOfBirth,
        'gender': gender,
        'college': college,
        'course': course,
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
      college: College.fromJson(json['college']),
      course: Course.fromJson(json['course']),
    );
  }
}

class Subject {
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
}

enum AssignmentType { Session, Assignment }

const _AssignmentTypeEnumMap = {
  AssignmentType.Assignment: 'Assignment',
  AssignmentType.Session: 'Session',
};

class Assignment {
  final String id;
  final Student student;
  final String name;
  final String description;
  final Subject subject;
  final AssignmentType assignmentType;
  final DateTime time;
  final List<String> referenceFiles;
  final double totalAmount;
  final double paidAmount;

  Assignment({
    required this.id,
    required this.student,
    required this.name,
    required this.description,
    required this.subject,
    required this.assignmentType,
    required this.time,
    required this.referenceFiles,
    required this.totalAmount,
    required this.paidAmount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'student': student.toJson(),
        'name': name,
        'description': description,
        'subject': subject.toJson(),
        'assignmentType': _AssignmentTypeEnumMap[assignmentType],
        'time': time.toIso8601String(),
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
      assignmentType: _AssignmentTypeEnumMap.entries
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
}
