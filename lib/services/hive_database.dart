import 'dart:async';

import 'package:databaseapp/models/person.dart';
import 'package:databaseapp/services/extension.dart';
import 'package:databaseapp/utils/constants.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  bool isInitialse = false;
  StreamController? streamController;

  Future<void> databaseInit() async {
    await Hive.setDatabasePath();
    streamController = StreamController();
    isInitialse = true;
    await initialiseBoxAndGetBox(boxName);
    sinkDataToStream();
  }

  /// Open and return hive box
  Future<Box> initialiseBoxAndGetBox(String boxName) async {
    if (!isInitialse) await databaseInit();
    Box? box;
    if (!Hive.isBoxOpen(boxName)) {
      box = await Hive.openBox(boxName);
    } else {
      box = Hive.box(boxName);
    }

    return box;
  }

  sinkDataToStream() async {
    List<dynamic> data = await read(boxName);
    streamController?.sink.add(Data(isInitialise: isInitialse, value: data));
  }

  void insert(Person person) async {
    if (!isInitialse) {
      await databaseInit();
    }
    Box box = await initialiseBoxAndGetBox(boxName);
    var uuid = box.length + 1;
    var data = person.toJson();
    box.put(uuid, data);

    sinkDataToStream();
  }

  void delete(key) async {
    Box box = await initialiseBoxAndGetBox(boxName);
    await box.delete(key);
    sinkDataToStream();
  }

  Future<List<dynamic>> read(String boxName) async {
    if (!isInitialse) {
      await databaseInit();
    }
    Box box = await initialiseBoxAndGetBox(boxName);
    var boxData = box.toMap();
    return boxData.entries
        .map((MapEntry mapEntry) => {mapEntry.key: mapEntry.value})
        .toList();
  }

  void clear() async {
    if (!isInitialse) {
      Box box = await initialiseBoxAndGetBox(boxName);
      streamController?.close();
      box.clear();
    }
  }
}
