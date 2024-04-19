import 'dart:async';
import 'dart:io';

import 'package:drift/drift.dart';
// Import the generated Drift schema, which contains your electrified tables
import 'package:electricsql_sandbox/generated/electric/drift_schema.dart';
// [IMPORTANT] Add this line to enable the import of electric types for Drift
// You can also import them from `electricsql_flutter`
// ignore: unused_import
import 'package:electricsql/drivers/drift.dart';
import 'package:electricsql_sandbox/connection/connection.dart' as impl;

part 'database.g.dart';

// [IMPORTANT LINE!!!] kElectrifiedTables comes from the generated file
// The rest is regular drift code
@DriftDatabase(tables: kElectrifiedTables)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(impl.connect());

  Future<void> init() async {
    await customSelect("SELECT 1").get();
  }

  @override
  int get schemaVersion => 1;

  // [IMPORTANT CHANGE!!!]
  // Drift by default creates the local database tables. This is done by electric in
  // this situation, so we provide an empty onCreate callback
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async {},
    );
  }

  FutureOr dispose() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      await close();
      await impl.deleteDbFile();
    }
    return close();
  }
}
