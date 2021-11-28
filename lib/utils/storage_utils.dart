import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';

class StorageUtils {
  Future<String> get _localPath async {
    final _path = await getTemporaryDirectory();
    return _path.path;
  }

  Future<File> localFile(String name) async {
    final path = await _localPath;
    return File('$path/cname');
  }

  Future<bool> saveFile(String name, Object val) async {
    try {
      final file = await localFile(name);
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
}
