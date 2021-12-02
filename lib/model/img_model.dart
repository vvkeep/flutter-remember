import 'dart:io';

enum PickImageMediaType { add, temp, source }

class RMPickImageItem {
  // 添加图片使用
  String? path;

  // 真正的图片文件
  File? file;
  PickImageMediaType type;

  RMPickImageItem({required this.type, this.path, this.file});
}
