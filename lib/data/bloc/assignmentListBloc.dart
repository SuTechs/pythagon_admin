import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/database.dart';

class AssignmentListBloc extends ChangeNotifier {
  static final AssignmentListBloc _singleton = AssignmentListBloc._internal();
  factory AssignmentListBloc() {
    return _singleton;
  }
  AssignmentListBloc._internal();

  final List<Assignment> _assignments = [];
  String _searchText = '';
  bool _isFetching = false;
  bool _isSortByTime = false;

  bool get isSortByTime => _isSortByTime;

  List<Assignment> get assignments {
    final a = _assignments.where((e) {
      return e.name!.toLowerCase().contains(_searchText) ||
          e.id.toLowerCase().contains(_searchText) ||
          e.description!.toLowerCase().contains(_searchText) ||
          e.student.name.toLowerCase().contains(_searchText) ||
          e.student.phone.toLowerCase().contains(_searchText) ||
          e.subject!.name.toLowerCase().contains(_searchText);
    }).toList();

    if (_isSortByTime) a.sort((x, y) => x.time!.compareTo(y.time!));

    return a;
  }

  void onSearch(String v) {
    _searchText = v;
    notifyListeners();
  }

  void toggleSortByTime() {
    _isSortByTime = !_isSortByTime;
    notifyListeners();
  }

  void onDataUpdate(QuerySnapshot<Map<String, dynamic>> snapshot) async {
    if (_isFetching) return;
    _isFetching = true;

    _assignments.clear();
    for (QueryDocumentSnapshot<Map<String, dynamic>> v in snapshot.docs) {
      try {
        final a = await Assignment.getAssignmentFromData(v.data());
        _assignments.add(a);
        notifyListeners();
      } catch (e) {
        print('\nError while parsing assignment = $e');
        continue;
      }
    }

    _isFetching = false;
  }
}
