import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'media.g.dart';

/*class Media extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  IntColumn get category =>
      integer().nullable().references(TodoCategory, #id)();
  DateTimeColumn get createdAt => dateTime().nullable()();
}*/

// Таблица локальных медиа, нужна для того, чтобы потом с ней работать при синхронизации с сервером
class LocalMedia extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get modifiedAt => dateTime()();
}

// Таблица, которая показывает
/*class ServerMedia extends Table {
  TextColumn get id => text()();
  IntColumn get type => integer()();
  TextColumn get name => text()();
  DateTimeColumn get datetime => dateTime()();
}*/

/*class TodoCategory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get description => text()();
}*/

@DriftDatabase(tables: [LocalMedia])
class MediaDatabase extends _$MediaDatabase {
  MediaDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    // `driftDatabase` from `package:drift_flutter` stores the database in
    // `getApplicationDocumentsDirectory()`.
    return driftDatabase(name: 'media_db');
  }
}