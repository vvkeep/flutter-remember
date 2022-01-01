import 'package:flutter/material.dart';
import 'package:iron_box/model/account_model.dart';

class AppFeatureItemModel {
  final Color color;
  final String image;
  final String text1;
  final String text2;

  AppFeatureItemModel(this.color, this.image, this.text1, this.text2);
}

class NavigationIconView {
  final BottomNavigationBarItem item;

  NavigationIconView({required String title, required IconData icon, required IconData activeIcon})
      : item = new BottomNavigationBarItem(
            icon: Icon(icon), activeIcon: Icon(activeIcon), label: title, backgroundColor: Colors.white);
}

class PhotoItemUIModel {
  FolderItemModel itemModel;
  bool isSelected = false;
  bool isEditMode = false;

  PhotoItemUIModel({required this.itemModel});
}

enum AccontSyncType { localExport, localImport, cloudUpload, cloudDownload }

class AccountSyncItemUIModel {
  final String image;
  final String title;
  final AccontSyncType type;

  AccountSyncItemUIModel(this.image, this.title, this.type);
}
