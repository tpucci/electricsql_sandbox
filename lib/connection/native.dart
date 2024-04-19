import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid().v4();

Future<String> getDatabasePath() async {
  final appDocsDir = await getApplicationDocumentsDirectory();
  final appDir = switch (Platform.environment.containsKey('FLUTTER_TEST')) {
    true => Directory(join(appDocsDir.path, 'test', '.drift', uuid)),
    false => Directory(join(appDocsDir.path, ".drift")),
  };

  if (!await appDir.exists()) {
    await appDir.create(recursive: true);
  }

  final cadenceDbPath = join(appDir.path, "cadence.db");

  return cadenceDbPath;
}

/// Obtains a database connection for running drift in a Dart VM.
DatabaseConnection connect() {
  return DatabaseConnection.delayed(Future(() async {
    final dbPath = await getDatabasePath();

    return NativeDatabase.createBackgroundConnection(File(dbPath));
  }));
}

Future<void> deleteDbFile() async {
  final dbFile = File(await getDatabasePath());
  if (dbFile.existsSync()) {
    await dbFile.delete();
  }
  final appDir = Directory(dirname(dbFile.path));
  if (await appDir.list().isEmpty) {
    await appDir.delete(recursive: true);
  }
}
