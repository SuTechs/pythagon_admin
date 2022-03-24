import 'package:flutter/foundation.dart';

import '/data/data.dart';

class CollegeBloc extends ChangeNotifier {
  static final List<CollegeData> _colleges = [];

  List<CollegeData> get colleges {
    _colleges.sort((a, b) => a.name.compareTo(b.name));
    return _colleges;
  }

  Future<void> getCollege() async {
    final fetchedCollege = await CollegeData.getAll();
    print('Colleges = $fetchedCollege');

    _colleges.clear();
    _colleges.addAll(fetchedCollege);
    notifyListeners();
  }

  Future<void> addCollege(CollegeData c) async {
    await c.add();

    if (_colleges.where((element) => element.id == c.id).isNotEmpty)
      _colleges.removeWhere((element) => element.id == c.id);

    _colleges.add(c);
    notifyListeners();
  }
}
