import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

class ItemImgCacheUtils {
  static Future<String> get _imgsDirectory async {
    final _path = await getApplicationDocumentsDirectory();
    String itemImgsPath = _path.path + "/item_imgs";
    var file = Directory(itemImgsPath);

    try {
      bool exist = await file.exists();
      if (!exist) {
        await file.create();
      }
    } catch (e) {
      print('create item image path error: ' + e.toString());
    }

    return itemImgsPath;
  }

  static Future<File> imgFile(String name) async {
    final path = await _imgsDirectory;
    return File("$path/$name");
  }

  static Future<String?> save(Uint8List bytes, String suffix) async {
    try {
      var uuid = Uuid();
      String name = uuid.v1() + '.' + suffix;
      final file = await imgFile(name);
      await file.writeAsBytes(bytes);
      return name;
    } catch (e) {
      //写入错误
      print("文件写入错误: $e");
      return null;
    }
  }

  static Future<bool> deleteImgs(List<String> names) async {
    for (var name in names) {
      await delete(name);
    }
    return true;
  }

  static Future<bool> delete(String name) async {
    final file = await imgFile(name);
    await file.delete(recursive: false);
    return true;
  }
}
