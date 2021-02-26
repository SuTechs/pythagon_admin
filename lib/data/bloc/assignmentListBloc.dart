import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pythagon_admin/data/database.dart';
import 'package:flutter/foundation.dart';

class AssignmentListBloc extends ChangeNotifier {
  static final AssignmentListBloc _singleton = AssignmentListBloc._internal();
  factory AssignmentListBloc() {
    return _singleton;
  }
  AssignmentListBloc._internal();

  final List<Assignment> _assignments = [];
  String _searchText = '';

  List<Assignment> get assignments => _assignments.where((e) {
        return e.name!.toLowerCase().contains(_searchText) ||
            e.description!.toLowerCase().contains(_searchText) ||
            e.student.name.toLowerCase().contains(_searchText) ||
            e.student.phone.toLowerCase().contains(_searchText) ||
            e.subject!.name.toLowerCase().contains(_searchText);
      }).toList();

  void onSearch(String v) {
    _searchText = v;
    notifyListeners();
  }

  void onDataUpdate(QuerySnapshot snapshot) async {
    _assignments.clear();
    for (QueryDocumentSnapshot v in snapshot.docs) {
      try {
        final a = await Assignment.getAssignmentFromData(v.data()!);
        _assignments.add(a);
        notifyListeners();
      } catch (e) {
        print('\nError while parsing assignment = $e');
        continue;
      }
    }
  }
}
