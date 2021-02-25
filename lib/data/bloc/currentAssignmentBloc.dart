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

  bool get canUpdate => _initialAssignment != _assignment;
  void notifyAssignmentUpdate() {
    notifyListeners();
  }

  /// assignments

  Assignment? _initialAssignment;
  Assignment? _assignment;

  Assignment? get assignment => _assignment;

  void newAssignment(Student student) {
    _assignment = Assignment(
      student: student,
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          student.studentId.substring(4) +
          textFieldKey.substring(2, 7),
      totalAmount: 500,
    );
    _initialAssignment = Assignment(
      student: student,
      id: DateTime.now().millisecondsSinceEpoch.toString() +
          student.studentId.substring(4) +
          textFieldKey.substring(2, 7),
      totalAmount: 500,
    );

    textFieldKey = UniqueKey().toString();
    notifyListeners();
  }

  void changeAssignment(Assignment assignment) {
    _assignment = assignment;
    _initialAssignment = assignment;
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
      notifyListeners();
    }
  }

  void updateAssignment() {
    print('AssignmentId = ${_assignment!.id}');
    _initialAssignment = Assignment(
      id: _assignment!.id,
      student: _assignment!.student,
      name: _assignment!.name,
      description: _assignment!.description,
      subject: _assignment!.subject,
      assignmentType: _assignment!.assignmentType,
      time: _assignment!.time,
      referenceFiles: _assignment!.referenceFiles,
      totalAmount: _assignment!.totalAmount,
      paidAmount: _assignment!.paidAmount,
    );
    notifyListeners();
  }

  Future<void> settleUp(double amount) async {
    await Future.delayed(Duration(seconds: 1));
    _assignment!.paidAmount += amount;
    _initialAssignment!.paidAmount += amount;
    notifyListeners();
  }
}
