import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/database.dart';

class CurrentAssignmentBloc extends ChangeNotifier {
  String textFieldKey = UniqueKey().toString();

  static final CurrentAssignmentBloc _singleton =
      CurrentAssignmentBloc._internal();

  factory CurrentAssignmentBloc() {
    return _singleton;
  }

  CurrentAssignmentBloc._internal();

  /// can create or update assignment
  bool _canUpdate = false;

  bool get canUpdate => _canUpdate;

  set canUpdate(bool value) {
    _canUpdate = value;
    notifyListeners();
  }

  /// assignments

  Assignment? _assignment;

  Assignment? get assignment => _assignment;

  void newAssignment(Student student) {
    _assignment = Assignment(
        student: student, id: DateTime.now().millisecondsSinceEpoch.toString());
    textFieldKey = UniqueKey().toString();
    notifyListeners();
  }

  void changeAssignment(Assignment assignment) {
    _assignment = assignment;
    textFieldKey = UniqueKey().toString();
    notifyListeners();
  }

  void onStudentDetailsUpdated(Student newStudentDetails) {
    if (_assignment != null &&
        _assignment!.student.studentId == newStudentDetails.studentId) {
      _assignment!.student = newStudentDetails;
      notifyListeners();
    } else {
      assert(_assignment != null, 'Student is updated in null Assignment');
      assert(_assignment!.student.studentId == newStudentDetails.studentId,
          'Student is updated but IDs are not equal');
    }
  }

  void onSubjectSelect(Subject subject) {
    if (_assignment != null) if (_assignment!.subject == null ||
        (_assignment!.subject != null &&
            _assignment!.subject!.id != subject.id)) {
      _assignment!.subject = subject;
      _canUpdate = true;
      notifyListeners();
    }
  }
}
