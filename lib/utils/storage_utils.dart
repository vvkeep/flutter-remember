import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class StorageUtils {
  Future<String> get _localItemImgsPath async {
    final _path = await getTemporaryDirectory();
    return _path.path + "/item_imgs";
  }

  Future<File> _localItemImgFile(String name) async {
    final path = await _localItemImgsPath;
    return File("$path/name");
  }

  Future<bool> isItemImgExists(String name) async {
    final file = await _localItemImgFile(name);
    var exist = await file.exists();
    return exist;
  }

  Future<bool> saveItemImg(String name, Object val) async {
    try {
      final file = await _localItemImgFile(name);
      IOSink sink = file.openWrite();
      sink.write(val);
      sink.close();
      return true;
    } catch (e) {
      //写入错误
      printError(info: "文件写入错误: $e");
      return false;
    }
  }

  Future<bool> deleteItemImg(String name) async {
    final file = await _localItemImgFile(name);
    await file.delete(recursive: false);
    return true;
  }
}
