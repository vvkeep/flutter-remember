import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class StorageUtils {
  static Future<String> get _localItemImgsPath async {
    final _path = await getTemporaryDirectory();
    return _path.path + "/item_imgs";
  }

  static Future<File> localItemImgFile(String name) async {
    final path = await _localItemImgsPath;
    return File("$path/name");
  }

  static Future<bool> isItemImgExists(String name) async {
    final file = await localItemImgFile(name);
    var exist = await file.exists();
    return exist;
  }

  static Future<String?> saveItemImg(Object val) async {
    try {
      var uuid = Uuid();
      String name = uuid.v1() + ".png";
      final file = await localItemImgFile(name);
      IOSink sink = file.openWrite();
      sink.write(val);
      sink.close();
      return name;
    } catch (e) {
      //写入错误
      print("文件写入错误: $e");
      return null;
    }
  }

  static Future<bool> delteItemImgs(List<String> names) async {
    for (var name in names) {
      await deleteItemImg(name);
    }
    return true;
  }

  static Future<bool> deleteItemImg(String name) async {
    final file = await _localItemImgFile(name);
    await file.delete(recursive: false);
    return true;
  }
}
