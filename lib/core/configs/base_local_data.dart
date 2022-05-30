import 'package:assignment_manabie/core/constant/storage_key.dart';
import 'package:assignment_manabie/core/utils/path_helper.dart';
import 'package:hive/hive.dart';

class BaseLocalData {
  static Future<void> initialBox() async {
    var path = await PathHelper.appDir;
    Hive..init(path.path);
    await Hive.openBox(StorageKey.todos);
  }
}
