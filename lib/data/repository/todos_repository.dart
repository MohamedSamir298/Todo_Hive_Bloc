import 'package:todo/data/services/hive_services.dart';

import '../model/todo.dart';

class TodosRepository {
  final TodoHiveServices hiveServices;
  TodosRepository(this.hiveServices);

  List<Todo> getTodos() {
    return hiveServices.getTodos();
  }

  Future<void> addTodo(Todo todo) async {
    await hiveServices.addTodo(todo);
  }

  Future<void> editTodo({required String title, required String description, required int key}) async {
    await hiveServices.editTodo(title: title, description: description, key: key);
  }

  Future<void> updateTodoStatus(int id , String status) async {
    await hiveServices.updateTodoStatus(id,status);
  }

  Future<void> deleteTodo(int id) async {
    await hiveServices.deleteTodo(id);
  }

  Future<void> clearAllTodos() async {
    await hiveServices.clearAllTodos();
  }

  // Future<void> close() async {
  //   await hiveServices.close();
  // }
}
