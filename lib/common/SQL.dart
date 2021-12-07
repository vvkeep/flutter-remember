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
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('邮箱', 0, 0);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('银行卡', 0, 1);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('手机号', 0, 2);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('工作', 0, 3);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('APPLE ID', 0, 4);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('网盘', 0, 5);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('网站', 0, 6);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('APP', 0, 7);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('游戏', 0, 8);",
    "INSERT INTO $tableCategory ('title', 'count', 'sort') VALUES ('其他', 0, 9);']"
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
}
