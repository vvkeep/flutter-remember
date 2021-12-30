import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/common/event_bus.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/account_model.dart';
import 'package:iron_box/pages/album/widget/album_list_item_widget.dart';
import 'package:iron_box/router/routers.dart';
import 'package:iron_box/widget/other/widget.dart';

class AlbumListPage extends StatefulWidget {
  AlbumListPage({Key? key}) : super(key: key);

  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  List<FolderModel> albumList = DataManager.shared.albumList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    setState(() {
      this.albumList = DataManager.shared.albumList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.white,
      appBar: AppBar(
        title: Text('相簿管理', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        actions: [
          IconButton(
            tooltip: '添加相簿',
            icon: Icon(Icons.add),
            onPressed: () {
              Map<String, Object> args = {
                "callback": () {
                  this.loadData();
                },
              };

              Get.toNamed(APPRouter.newAlbumPage, arguments: args);
            },
          )
        ],
      ),
      body: ReorderableListView(
        children: albumList.map((album) {
          return Dismissible(
            key: Key('key_${album.id}'),
            direction: DismissDirection.endToStart,
            background: Container(
              width: 55,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.delete, color: Colors.white),
                  SizedBox(width: 15),
                ],
              ),
            ),
            child: GestureDetector(
              onTap: () {
                Map<String, Object> args = {
                  "callback": () {
                    this.loadData();
                  },
                  "album": album
                };
                Get.toNamed(APPRouter.newAlbumPage, arguments: args);
              },
              child: AlbumListItemWidget(folderModel: album),
            ),
            confirmDismiss: (direction) {
              return deleteAlbum(album);
            },
            onDismissed: (direction) async {
              await DataManager.shared.removeCategory(album.id);
              eventBus.fire(AlbumListEvent());
              AppToast.showSuccess('删除成功');
            },
          );
        }).toList(),
        onReorder: (oldIndex, newIndex) async {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            var item = albumList.removeAt(oldIndex);
            albumList.insert(newIndex, item);
          });

          await DataManager.shared.reorderFolderSort(0, albumList);
          eventBus.fire(AlbumListEvent());
        },
      ),
    );
  }

  Future<bool> deleteAlbum(FolderModel folderModel) async {
    if (folderModel.count > 0) {
      AppToast.showError('该相簿下还有${folderModel.count}项，不允许删除');
      return false;
    } else {
      return true;
    }
  }
}
