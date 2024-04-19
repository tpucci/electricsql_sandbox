import 'dart:async';

import 'package:electricsql_sandbox/generated/electric/migrations.dart';
import 'package:electricsql_sandbox/database.dart';
import 'package:electricsql/drivers/drift.dart';
import 'package:electricsql/electricsql.dart';

class Electric {
  final AppDatabase db;

  late ElectricClient electricClient;

  Electric(this.db);

  Future<void> init() async {
    // ##### IMPORTANT #####
    // If you are running the app on a physical device or emulator, localhost
    // won't work, you need to use the IP address of your computer when developing
    // locally. (192.168.x.x:5133)
    const String electricURL = 'http://localhost:5133';

    electricClient = await electrify<AppDatabase>(
      dbName: "cadence-db",
      db: db,
      migrations: kElectricMigrations,
      config: ElectricConfig(
        url: electricURL,
        logger: LoggerConfig(
          level: Level.debug,
        ),
      ),
    );
  }

  FutureOr dispose() async {
    await electricClient.close();
  }
}
