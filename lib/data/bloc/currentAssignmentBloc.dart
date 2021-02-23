import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/database.dart';

class CurrentAssignmentBloc extends ChangeNotifier {
  static final CurrentAssignmentBloc _singleton =
      CurrentAssignmentBloc._internal();

  factory CurrentAssignmentBloc() {
    return _singleton;
  }

  CurrentAssignmentBloc._internal();

  Student? _currentStudent;

  Student? get currentStudent => _currentStudent;

  set currentStudent(Student? value) {
    if (_currentStudent == value) return;

    if (_currentStudent != null &&
        value != null &&
        _currentStudent!.studentId != value.studentId)
      print('Reset the Assignment!\nNew Assignment');

    _currentStudent = value;
    notifyListeners();
  }
}
