class SQL {
  static final String tableItem = "item";
  static final String tableCategory = "category";
  static final String tableTag = "tag";

  static String initItemTable = '''
    CREATE TABLE $tableItem (
    "id" INTEGER NOT NULL,
    "categoryId" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "account" TEXT NOT NULL,
    "tagIds" TEXT,
    "password" TEXT,
    "payPassword" TEXT,
    "description" TEXT,
    "imgs" TEXT,
    "extend1Key" TEXT,
    "extend1Value" TEXT,
    "extend2Key" TEXT,
    "extend2Value" TEXT,
    "extend3Key" TEXT,
    "extend3Value" TEXT,
    CONSTRAINT "id" PRIMARY KEY ("id")
    CONSTRAINT "index_title" UNIQUE ("title") ON CONFLICT ABORT
    );
  ''';

  static String initCategoryTable = '''
    CREATE TABLE $tableCategory (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "count" INTEGER NOT NULL,
    "sort" INTEGER NOT NULL,
    "type" INTEGER NOT NULL,
    CONSTRAINT "id" PRIMARY KEY ("id")
    CONSTRAINT "index_title" UNIQUE ("title") ON CONFLICT ABORT
    );
  ''';

  static String initTagTable = '''
    CREATE TABLE $tableTag (
    "id" INTEGER NOT NULL,
    "title" TEXT NOT NULL,
    "count" INTEGER NOT NULL,
    "sort" INTEGER NOT NULL,
    CONSTRAINT "id" PRIMARY KEY ("id")
    CONSTRAINT "index_title" UNIQUE ("title") ON CONFLICT ABORT
    );
  ''';

  static List<String> initCategoryList = [
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('邮箱', 0, 0, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('银行卡', 0, 1, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('手机号', 0, 2, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('工作', 0, 3, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('APPLE ID', 0, 4, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('网盘', 0, 5, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('网站', 0, 6, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('APP', 0, 7, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('游戏', 0, 8, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('其他', 0, 9, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('自拍', 0, 0, 1);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('华山', 0, 1, 1);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('电影', 0, 2, 1);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort', 'type') VALUES ('生活', 0, 3, 1);",
  ];

  static List<String> initTagList = [
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('电商', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('导航', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('营销', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('技术', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('开发', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('餐饮', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('教育', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('玩具', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('硬件', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('电脑', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('支付宝', 0, 0);",
    "INSERT INTO $tableTag ('title', 'count', 'sort') VALUES ('微信', 0, 0);",
  ];

  static List<String> initItemList = [
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (1, '英雄联盟12', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (2, '英雄联盟21', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (3, '英雄联盟22', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (4, '英雄联盟23', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (5, '英雄联盟4', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (6, '英雄联盟5', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (8, '英雄联盟6', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (9, '英雄联盟7', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (9, '英雄联盟8', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (9, '英雄联盟9', 'lol@qq.com', 'bbbbbb', '1231231', '英联联盟账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (7, '小红书', 'lol@qq.com', 'bbbbbb', '1231231', '小红书账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (7, '半糖', 'lol@qq.com', 'bbbbbb', '1231231', '半糖账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (7, '京东', 'lol@qq.com', 'bbbbbb', '1231231', '京东账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (7, '拼多多', 'lol@qq.com', 'bbbbbb', '1231231', '拼多多账号');",
    "INSERT INTO $tableItem ('categoryId', 'title', 'account', 'password', 'payPassword', 'description') VALUES (7, '淘宝', 'taobao@qq.com', 'bbbbbb', '1231231', '淘宝账号');",
  ];
}
