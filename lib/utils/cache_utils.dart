import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class CacheUtils {
  static Future<Directory> _folderDirectory(String folder) async {
    final _path = await getApplicationDocumentsDirectory();
    String path = _path.path + "/photos/$folder";
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

  static Future<List<String?>> saveFiles(List<File> files, String folder) async {
    List<String?> names = [];
    for (var file in files) {
      Uint8List bytes = await file.readAsBytes();
      String suffix = file.path.split(".").last;
      final name = await save(bytes, suffix, folder);
      names.add(name);
    }
    return names;
  }

  static Future<List<File>> getFiles(String folder) async {
    final folderDir = await _folderDirectory(folder);
    List<FileSystemEntity> entityList = await folderDir.list().toList();
    List<File> files = [];
    for (var entity in entityList) {
      final file = File(entity.path);
      files.add(file);
    }

    return files;
  }

  static Future<String?> save(Uint8List bytes, String suffix, String folder) async {
    try {
      var uuid = Uuid();
      String fileName = uuid.v1() + '.' + suffix;
      final folderDir = await _folderDirectory(folder);
      final fullPath = folderDir.path + "/$fileName";
      var file = File(fullPath);
      await file.writeAsBytes(bytes);
      return fileName;
    } catch (e) {
      //写入错误
      print("文件写入错误: ${e.toString()}");
      return null;
    }
  }

  static Future<bool> deleteList(String folder, List<String> names) async {
    for (var name in names) {
      await delete(folder, name);
    }
    return true;
  }

  static Future<bool> delete(String folder, String fileName) async {
    final folderDir = await _folderDirectory(folder);
    final fullPath = folderDir.path + "/$folder";
    var file = File(fullPath);
    await file.delete(recursive: false);
    return true;
  }
}
