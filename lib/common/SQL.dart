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

  static String initTableData = '''
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('邮箱', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('银行卡', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('手机号', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('工作', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('APPLE ID', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('网盘', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('网站', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('APP', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('游戏', 0, 0);
    INSERT INTO $tableCategory ("title", "count", "sort") VALUES ('其他', 0, 0);

    INSERT INTO $tableTag ("title", "count") VALUES ('电商', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('导航', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('营销', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('技术', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('开发', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('餐饮', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('教育', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('玩具', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('硬件', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('电脑', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('支付宝', 0);
    INSERT INTO $tableTag ("title", "count") VALUES ('微信', 0);
  ''';
}
