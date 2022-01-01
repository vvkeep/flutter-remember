import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:iron_box/common/constant.dart';
import 'package:iron_box/manager/data_manager.dart';
import 'package:iron_box/model/models.dart';
import 'package:iron_box/pages/sync/widget/account_sync_item_widget.dart';
import 'package:iron_box/widget/other/widgets.dart';
import 'package:uuid/uuid.dart';

class AccountSyncPage extends StatefulWidget {
  AccountSyncPage({Key? key}) : super(key: key);

  @override
  _AccountSyncPageState createState() => _AccountSyncPageState();
}

class _AccountSyncPageState extends State<AccountSyncPage> {
  List<AccountSyncItemUIModel> _dataList = [
    AccountSyncItemUIModel("jz_dcsb_icon.png", "导出账号", AccontSyncType.localExport),
    AccountSyncItemUIModel("jz_drsb_icon.png", "导入账号", AccontSyncType.localImport),
    AccountSyncItemUIModel("jz_scfwq_icon.png", "上传到云服务", AccontSyncType.cloudUpload),
    AccountSyncItemUIModel("jz_bcdbj_icon.png", "云服务同步本机", AccontSyncType.cloudDownload),
  ];

  _exportLocalAccount() {
    // AppLoading.show(context);

    // final categoryList = DataManager.shared.accountCategoryList;
    // final tagList = DataManager.shared.accountTagList;
    // final accountList = DataManager.shared.accountList;

    // final salt = Uuid().v4();
    // final syncPasswodCode = EncryptUtil.encodeMd5(salt).toString();
    // AppLoading.hidden(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APPColors.mainBackgroundColor,
      appBar: AppBar(
        title: Text('同步管理', style: TextStyle(color: Colors.white)),
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0, // 去掉Appbar底部阴影
      ),
      body: Container(
        color: APPColors.mainBackgroundColor,
        padding: EdgeInsets.all(APPLayout.itemMargin),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            crossAxisSpacing: APPLayout.itemMargin,
            mainAxisSpacing: APPLayout.itemMargin,
            childAspectRatio: 1,
            maxCrossAxisExtent: APPLayout.albumMaxLength,
          ),
          itemCount: _dataList.length,
          itemBuilder: (context, index) {
            final model = _dataList[index];
            return GestureDetector(
              onTap: () {
                switch (model.type) {
                  case AccontSyncType.localExport:
                    this._exportLocalAccount();
                    break;
                  case AccontSyncType.localImport:
                    break;
                  case AccontSyncType.cloudDownload:
                    break;
                  case AccontSyncType.cloudUpload:
                    break;
                }
              },
              child: AccountSyncItemWidget(model: model),
            );
          },
        ),
      ),
    );
  }
}
