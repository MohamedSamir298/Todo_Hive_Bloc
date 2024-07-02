import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/utils/strings.dart';
import '../model/todo.dart';

class TodoHiveServices {
  Box<Todo> todoBox = Hive.box<Todo>(hiveBoxName);

  List<Todo> getTodos() {
    return todoBox.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    todo.needsSync = true;
    await todoBox.add(todo);
    //trySync();
  }

  Future<void> updateTodoStatus(int id , String status) async {
    final oldTodo = todoBox.get(id);
    if (oldTodo != null && oldTodo.status != status) {
      oldTodo.needsSync = true;
      oldTodo.status = status;
      await oldTodo.save();
    }
    //trySync();
  }
  Future<void> editTodo({required String title, required String description, required int key}) async {
    final oldTodo = todoBox.get(key);
    if (oldTodo != null) {
      oldTodo.needsSync = true;
      oldTodo.title = title;
      oldTodo.description = description;
      await oldTodo.save();
    }
    //trySync();
  }

  Future<void> deleteTodo(int id) async {
    await todoBox.delete(id);
    //trySync();
  }

  Future<void> close() async {
    await todoBox.compact();
    await todoBox.close();
  }

  Future<void> clearAllTodos() async {
    await todoBox.clear();
    //trySync();
  }

// Future<void> syncWithServer() async {
//   final todos = await _apiService.fetchTodos();
//   await _todoBox.clear();
//   for (var todo in todos) {
//     await _todoBox.put(todo.id, todo);
//   }
// }

// Future<void> syncTodos() async {
//   final todosToSync = _todoBox.values.where((todo) => todo.needsSync).toList();
//   if (todosToSync.isNotEmpty) {
//     await _apiService.syncTodos(todosToSync);
//     for (var todo in todosToSync) {
//       todo.needsSync = false;
//       await todo.save();
//     }
//   }
// }

// void trySync() async {
//   final connectivityResult = await (Connectivity().checkConnectivity());
//   if (connectivityResult != ConnectivityResult.none) {
//     await syncTodos();
//   }
// }
}
