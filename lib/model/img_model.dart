import 'dart:io';

import 'package:flutter/material.dart';

enum PickImageMediaType { add, temp, source }

class RMPickImageItem {
  String? path;
  File? file;
  PickImageMediaType type;

  RMPickImageItem({required this.type, this.path, this.file});
}
