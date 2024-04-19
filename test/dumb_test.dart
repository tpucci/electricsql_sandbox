import 'package:drift/drift.dart';
import 'package:electricsql_sandbox/database.dart';
import 'package:electricsql_sandbox/electric.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Start and stop db and electric', () async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
            const MethodChannel('plugins.flutter.io/path_provider'),
            (MethodCall methodCall) async {
      return '.';
    });

    final db = AppDatabase();
    await db.init();
    final electric = Electric(db);
    await electric.init();

    await db.issue.insertOne(IssueCompanion.insert(
        id: const Uuid().v4(), title: const Value("Test")));

    await db.transaction(() async {
      for (final table in db.allTables) {
        await db.delete(table).go();
      }
    });

    await electric.dispose();
    await db.dispose();
  });
}
