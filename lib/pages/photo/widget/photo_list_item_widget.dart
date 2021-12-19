import 'dart:io';

import 'package:flutter/material.dart';

class PhotoListItemWidget extends StatelessWidget {
  final VoidCallback onTap;

  final File file;

  const PhotoListItemWidget({Key? key, required this.file, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        child: Image.file(
          this.file,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
