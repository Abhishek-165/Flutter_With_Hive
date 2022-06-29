import 'package:databaseapp/services/hive_database.dart';

class HiveProvider {
  static final HiveProvider _singleton = HiveProvider._internal();
  late HiveDatabase _hiveDatabase;

  factory HiveProvider() {
    return _singleton;
  }

  Future<HiveDatabase> getDatabaseInstance() async {
    await _hiveDatabase.databaseInit();
    return _hiveDatabase;
  }

  HiveDatabase getInstance() {
    return _hiveDatabase;
  }

  HiveProvider._internal() {
    _hiveDatabase = HiveDatabase();
  }
}
