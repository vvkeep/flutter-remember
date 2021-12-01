import 'dart:io';
import 'package:path_provider/path_provider.dart';

class StorageUtils {
  static Future<String> get _localItemImgsPath async {
    final _path = await getTemporaryDirectory();
    return _path.path + "/item_imgs";
  }

  static Future<File> _localItemImgFile(String name) async {
    final path = await _localItemImgsPath;
    return File("$path/name");
  }

  static Future<bool> isItemImgExists(String name) async {
    final file = await _localItemImgFile(name);
    var exist = await file.exists();
    return exist;
  }

  static Future<bool> saveItemImg(String name, Object val) async {
    try {
      final file = await _localItemImgFile(name);
      IOSink sink = file.openWrite();
      sink.write(val);
      sink.close();
      return true;
    } catch (e) {
      //写入错误
      print("文件写入错误: $e");
      return false;
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
