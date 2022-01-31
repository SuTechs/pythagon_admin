import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:pythagon_admin/data/database.dart';

class NotificationBloc extends ChangeNotifier {
  static final NotificationBloc _singleton = NotificationBloc._internal();

  factory NotificationBloc() {
    return _singleton;
  }

  NotificationBloc._internal();

  final List<NotificationData> notifications = [];

  void onDataUpdate(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> docs) async {
    final List<NotificationData> a = [];

    /// parsing and fetching data
    try {
      for (QueryDocumentSnapshot<Map<String, dynamic>> q in docs) {
        final t = NotificationData.fromJson(q.data());
        a.add(t);
      }
    } catch (e) {
      print('Error #23221 $e');
    }

    /// adding data

    if (notifications.isNotEmpty) notifications.clear();
    notifications.addAll(a);

    notifyListeners();
  }
}
