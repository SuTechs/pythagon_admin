import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionRef {
  static final colleges = FirebaseFirestore.instance.collection('Colleges');
  static final courses = FirebaseFirestore.instance.collection('Courses');
  static final students = FirebaseFirestore.instance.collection('Students');
  static final subjects = FirebaseFirestore.instance.collection('Subjects');
  static final assignments =
      FirebaseFirestore.instance.collection('Assignments');

  static final teachers = FirebaseFirestore.instance.collection('Teachers');
  static final teachersAssignments =
      FirebaseFirestore.instance.collection('TeachersAssignments');
  static final admins = FirebaseFirestore.instance.collection('Admins');

  static final transactions =
      FirebaseFirestore.instance.collection('Transactions');
}
