import 'package:flutter/foundation.dart';

import '../utils/data/course.dart';

class CourseBloc extends ChangeNotifier {
  static final List<CourseData> _courses = [];

  static CourseData? getById(String id) {
    final matched = _courses.where((element) => element.id == id);
    if (matched.isNotEmpty) return matched.first;

    return null;
  }

  List<CourseData> get courses {
    _courses.sort((a, b) => a.name.compareTo(b.name));
    return _courses;
  }

  Future<void> get() async {
    final fetched = await CourseData().getAll();
    print('Courses = $fetched');

    _courses.clear();
    _courses.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(CourseData c) async {
    await c.add(c);

    if (_courses.where((element) => element.id == c.id).isNotEmpty)
      _courses.removeWhere((element) => element.id == c.id);

    _courses.add(c);
    notifyListeners();
  }
}
