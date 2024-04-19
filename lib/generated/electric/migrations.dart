// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: depend_on_referenced_packages, prefer_double_quotes

import 'dart:collection';

import 'package:electricsql/electricsql.dart';

final kElectricMigrations = UnmodifiableListView<Migration>(<Migration>[
  Migration(
    statements: [
      'CREATE TABLE "issue" (\n  "id" TEXT NOT NULL,\n  "title" TEXT,\n  CONSTRAINT "issue_pkey" PRIMARY KEY ("id")\n) WITHOUT ROWID;\n',
      '\n    INSERT OR IGNORE INTO _electric_trigger_settings(tablename,flag) VALUES (\'main.issue\', 1);\n    ',
      '\n    DROP TRIGGER IF EXISTS update_ensure_main_issue_primarykey;\n    ',
      '\n    CREATE TRIGGER update_ensure_main_issue_primarykey\n      BEFORE UPDATE ON "main"."issue"\n    BEGIN\n      SELECT\n        CASE\n          WHEN old."id" != new."id" THEN\n		RAISE (ABORT, \'cannot change the value of column id as it belongs to the primary key\')\n        END;\n    END;\n    ',
      '\n    DROP TRIGGER IF EXISTS insert_main_issue_into_oplog;\n    ',
      '\n    CREATE TRIGGER insert_main_issue_into_oplog\n       AFTER INSERT ON "main"."issue"\n       WHEN 1 == (SELECT flag from _electric_trigger_settings WHERE tablename == \'main.issue\')\n    BEGIN\n      INSERT INTO _electric_oplog (namespace, tablename, optype, primaryKey, newRow, oldRow, timestamp)\n      VALUES (\'main\', \'issue\', \'INSERT\', json_object(\'id\', new."id"), json_object(\'id\', new."id", \'title\', new."title"), NULL, NULL);\n    END;\n    ',
      '\n    DROP TRIGGER IF EXISTS update_main_issue_into_oplog;\n    ',
      '\n    CREATE TRIGGER update_main_issue_into_oplog\n       AFTER UPDATE ON "main"."issue"\n       WHEN 1 == (SELECT flag from _electric_trigger_settings WHERE tablename == \'main.issue\')\n    BEGIN\n      INSERT INTO _electric_oplog (namespace, tablename, optype, primaryKey, newRow, oldRow, timestamp)\n      VALUES (\'main\', \'issue\', \'UPDATE\', json_object(\'id\', new."id"), json_object(\'id\', new."id", \'title\', new."title"), json_object(\'id\', old."id", \'title\', old."title"), NULL);\n    END;\n    ',
      '\n    DROP TRIGGER IF EXISTS delete_main_issue_into_oplog;\n    ',
      '\n    CREATE TRIGGER delete_main_issue_into_oplog\n       AFTER DELETE ON "main"."issue"\n       WHEN 1 == (SELECT flag from _electric_trigger_settings WHERE tablename == \'main.issue\')\n    BEGIN\n      INSERT INTO _electric_oplog (namespace, tablename, optype, primaryKey, newRow, oldRow, timestamp)\n      VALUES (\'main\', \'issue\', \'DELETE\', json_object(\'id\', old."id"), NULL, json_object(\'id\', old."id", \'title\', old."title"), NULL);\n    END;\n    ',
    ],
    version: '20240411054320',
  )
]);
