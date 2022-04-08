import 'package:flutter/foundation.dart';

import '../utils/data/student.dart';

class StudentBloc extends ChangeNotifier {
  static final List<StudentData> _students = [];

  static StudentData? getById(String id) {
    final matched = _students.where((element) => element.id == id);
    if (matched.isNotEmpty) return matched.first;

    return null;
  }

  List<StudentData> get courses {
    _students.sort((a, b) => a.name.compareTo(b.name));
    return _students;
  }

  Future<void> get() async {
    final fetched = await StudentData().getAll();
    print('Courses = $fetched');

    _students.clear();
    _students.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(StudentData c) async {
    await c.add(c);

    if (_students.where((element) => element.id == c.id).isNotEmpty)
      _students.removeWhere((element) => element.id == c.id);

    _students.add(c);
    notifyListeners();
  }
}
