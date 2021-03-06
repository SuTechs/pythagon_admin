import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:pythagon_admin/screens/assignmentDetails.dart';
import 'package:pythagon_admin/widgets/showToast.dart';

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
  bool _isEdit = false;

  Assignment? get assignment => _assignment;

  void _copyAssignment() {
    _initialAssignment = Assignment(
      id: _assignment!.id,
      student: _assignment!.student,
      name: _assignment!.name,
      description: _assignment!.description,
      subject: _assignment!.subject,
      assignmentType: _assignment!.assignmentType,
      time: _assignment!.time,
      referenceFiles: List<String>.from(_assignment!.referenceFiles),
      totalAmount: _assignment!.totalAmount,
      paidAmount: _assignment!.paidAmount,
    );
  }

  void newAssignment(Student student) {
    final id = DateTime.now();

    _isEdit = false;
    _assignment = Assignment(
      // id: DateTime.now().millisecondsSinceEpoch.toString() +
      //     student.studentId.substring(4) +
      //     textFieldKey.substring(2, 7),
      id: '${id.year}${id.month}${id.day} ${textFieldKey.hashCode}',
      student: student,
      referenceFiles: [],
    );
    _copyAssignment();

    textFieldKey = UniqueKey().toString();
    notifyListeners();
    SideSheet.closeIfOpen();
  }

  void changeAssignment(Assignment assignment) {
    _isEdit = true;

    _assignment = Assignment(
      id: assignment.id,
      student: assignment.student,
      name: assignment.name,
      description: assignment.description,
      subject: assignment.subject,
      assignmentType: assignment.assignmentType,
      time: assignment.time,
      referenceFiles: List<String>.from(assignment.referenceFiles),
      totalAmount: assignment.totalAmount,
      paidAmount: assignment.paidAmount,
    );

    _copyAssignment();
    textFieldKey = UniqueKey().toString();
    notifyListeners();
    SideSheet.closeIfOpen();
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

  ///  logic

  void updateAssignment() async {
    if (!_canCreateOrUpdateAssignment()) return; // can not create or update

    _copyAssignment();
    notifyListeners();
    await _assignment!.addOrUpdateAssignment(_isEdit);
    _isEdit = true;
  }

  Future<void> settleUp(double amount) async {
    _assignment!.paidAmount += amount;
    _initialAssignment!.paidAmount += amount;
    notifyListeners();
    await _assignment!.settleUp(amount);
  }

  bool _canCreateOrUpdateAssignment() {
    // name
    if (assignment!.name == null || assignment!.name == '') {
      showToast('Name is required!');
      return false;
    }

    // subject
    if (assignment!.subject == null) {
      showToast('Subject is required!');
      return false;
    }

    // time
    if (assignment!.time == null) {
      showToast('Time is required!');
      return false;
    }

    // type
    if (assignment!.assignmentType == null) {
      showToast('Type is required!');
      return false;
    }

    // description
    if (assignment!.description == null || assignment!.description == '') {
      showToast('Description is required!');
      return false;
    }

    // total amount
    if (assignment!.totalAmount == null) {
      showToast('Total amount is required!');
      return false;
    }

    if (assignment!.totalAmount! <= 100) {
      showToast('Total amount should be greater than 100');
      return false;
    }

    return true;
  }
}
