import 'package:hive_flutter/hive_flutter.dart';

class DataBox {
  static Box<bool> boolBox = Hive.box<bool>('bool');

  // static Box<String> stringBox = Hive.box<String>('string');
  // static Box<int> intBox = Hive.box<int>('int');
  // static Box<double> doubleBox = Hive.box<double>('double');

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox<bool>('bool');
  }
}
