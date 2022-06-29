import 'package:databaseapp/services/hive_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

extension HiveExtend on HiveInterface {
  Future<void> setDatabasePath([String? subDir]) async {
    WidgetsFlutterBinding.ensureInitialized();

    if (kIsWeb) return;

    var appDir = await getApplicationDocumentsDirectory();
    init(path.join(appDir.path, subDir));
  }
}

extension StringToInt on String {
  int toIntParse() {
    return int.parse(this);
  }
}

extension HiveDatabaseExtend on HiveDatabase {
  bool isNotNull() {
    return this != null;
  }
}
