import 'package:drift/drift.dart';
import 'package:drift_flutter_example/models/todo.dart';
import '../services/db.dart';

part 'todo_dao.g.dart';

@DriftAccessor(tables: [Todos])
class TodosDao extends DatabaseAccessor<MyDB> with _$TodosDaoMixin {
  TodosDao(MyDB db) : super(db);

  Future<List<Todo>> getAllTodoEntries() => select(todos).get();
  Stream<List<Todo>> watchAllTodoEntries() => select(todos).watch();

  Future insertTodo(TodosCompanion todo) => into(todos).insert(todo);

  // Future updateTodo(TodosCompanion todo) => (update(todos)..where((t) => t.id.equals(todo.id)))
  //     .write(TodosCompanion(title: todo.title, content: todo.content));

  Future updateTodo(Todo entry) => update(todos).replace(entry);

  // Future createOrUpdateTodo(Todo todo) => into(todos).insertOnConflictUpdate(todo);
  Future deleteTodo(int id) => (delete(todos)..where((t) => t.id.equals(id))).go();
}