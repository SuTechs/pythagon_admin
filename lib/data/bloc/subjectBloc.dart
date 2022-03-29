import 'package:flutter/foundation.dart';

import '../utils/data/subject.dart';

class SubjectBloc extends ChangeNotifier {
  static final List<SubjectData> _subjects = [];

  List<SubjectData> get subjects {
    _subjects.sort((a, b) => a.name.compareTo(b.name));
    return _subjects;
  }

  Future<void> get() async {
    final fetched = await SubjectData().getAll();
    print('Subjects = $fetched');

    _subjects.clear();
    _subjects.addAll(fetched);
    notifyListeners();
  }

  Future<void> add(SubjectData s) async {
    await s.add(s);

    if (_subjects.where((element) => element.id == s.id).isNotEmpty)
      _subjects.removeWhere((element) => element.id == s.id);

    _subjects.add(s);
    notifyListeners();
  }
}
