// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: depend_on_referenced_packages, prefer_double_quotes

import 'package:drift/drift.dart';
import 'package:electricsql/drivers/drift.dart';

const kElectrifiedTables = [Issue];

class Issue extends Table {
  TextColumn get id => customType(ElectricTypes.uuid).named('id')();

  TextColumn get title => text().named('title').nullable()();

  @override
  String? get tableName => 'issue';

  @override
  Set<Column<Object>>? get primaryKey => {id};

  @override
  bool get withoutRowId => true;
}
