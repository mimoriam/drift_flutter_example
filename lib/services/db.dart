import 'package:drift/drift.dart';
import 'package:drift_flutter_example/models/todo.dart';
import 'package:drift_flutter_example/daos/todo_dao.dart';

// These imports are only needed to open the database
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'dart:io';

part 'db.g.dart';

// Opens the connection to SQLite DB:
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

// Actual CRUD operation is here:
@DriftDatabase(tables: [Todos], daos: [TodosDao])
class MyDB extends _$MyDB {
  MyDB() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
      onCreate: (Migrator m) {
        return m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from == 1) {
          // we added the dueDate property in the change from version 1
          // Insert changes below:
          // await m.addColumn(todos, todos.dueDate);
        }
      }
  );

}
