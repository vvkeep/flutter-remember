import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

enum CacheType { ACCOUNT_IMGS, PHTOT_IMGS }

class CacheUtils {
  static Future<Directory> _folderDirectory(CacheType type) async {
    final _path = await getApplicationDocumentsDirectory();
    final folder = type == CacheType.ACCOUNT_IMGS ? '/account_imgs' : '/photo_imgs';
    String path = _path.path + folder;
    var dir = Directory(path);

    try {
      bool exist = await dir.exists();
      if (!exist) {
        await dir.create(recursive: true);
      }
    } catch (e) {
      print('create item image path error: ' + e.toString());
    }

    return dir;
  }

  static Future<File> fileWithType(CacheType type, String fileName) async {
    final folderDir = await _folderDirectory(type);
    final fullPath = folderDir.path + "/$fileName";
    final file = File(fullPath);
    return file;
  }

  static Future<List<String?>> saveFiles(CacheType type, List<File> files) async {
    List<String?> names = [];
    for (var file in files) {
      final name = await save(type, file);
      names.add(name);
    }
    return names;
  }

  static Future<String?> save(CacheType type, File file) async {
    try {
      Uint8List bytes = await file.readAsBytes();
      String suffix = file.path.split(".").last;
      var uuid = Uuid();
      String fileName = uuid.v1() + '.' + suffix;
      final folderDir = await _folderDirectory(type);
      final fullPath = folderDir.path + "/$fileName";
      var newfile = File(fullPath);
      await newfile.writeAsBytes(bytes);
      return fileName;
    } catch (e) {
      //写入错误
      print("文件写入错误: ${e.toString()}");
      return null;
    }
  }

  static Future<bool> deleteList(CacheType type, List<String> names) async {
    for (var name in names) {
      await delete(type, name);
    }
    return true;
  }

  static Future<bool> delete(CacheType type, String fileName) async {
    final folderDir = await _folderDirectory(type);
    final fullPath = folderDir.path + "/$fileName";
    var file = File(fullPath);
    await file.delete(recursive: false);
    return true;
  }
}
