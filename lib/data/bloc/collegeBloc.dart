import 'package:flutter/foundation.dart';

import '../utils/data/college.dart';

class CollegeBloc extends ChangeNotifier {
  static final List<CollegeData> _colleges = [];

  List<CollegeData> get colleges {
    _colleges.sort((a, b) => a.name.compareTo(b.name));
    return _colleges;
  }

  Future<void> get() async {
    final fetchedCollege = await CollegeData().getAll();
    print('Colleges = $fetchedCollege');

    _colleges.clear();
    _colleges.addAll(fetchedCollege);
    notifyListeners();
  }

  Future<void> add(CollegeData c) async {
    await c.add(c);

    if (_colleges.where((element) => element.id == c.id).isNotEmpty)
      _colleges.removeWhere((element) => element.id == c.id);

    _colleges.add(c);
    notifyListeners();
  }
}
