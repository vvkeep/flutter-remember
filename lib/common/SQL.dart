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
}
