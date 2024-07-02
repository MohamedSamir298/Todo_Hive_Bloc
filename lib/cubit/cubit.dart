import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/states.dart';
import '../data/model/todo.dart';
import '../data/repository/todos_repository.dart';
import '../view/tabs/inprogress_tab.dart';
import '../view/tabs/done_tab.dart';
import '../view/tabs/tasks_tab.dart';

class TodosCubit extends Cubit<TodosState> {
  final TodosRepository todosRepository;
  TodosCubit(this.todosRepository) : super(TodoInitial());
  static TodosCubit get(context) => BlocProvider.of(context);

  List<Todo> currentTasks = [];
  List<Todo> inProgressTasks = [];
  List<Todo> doneTasks = [];

  List<Widget> tabs = [const NewTasksTab(), const InProgressTasksTab(), const DoneTasksTab()];
  List<String> titles = ["New Tasks", "InProgress Tasks", "Done Tasks"];
  int tabIndex = 0;

  void changeIndex(int index) {
    tabIndex = index;
    emit(TodoChangeStateBottomNavBar());
  }

  List<Todo> getTodos() {
    currentTasks = [];
    inProgressTasks = [];
    doneTasks = [];
    emit(TodoLoading());
    try {
      final todos = todosRepository.getTodos();
      todos.forEach((element) {
        if (element.status == "new") {
          currentTasks.add(element);
        } else if (element.status == "inprogress") {
          inProgressTasks.add(element);
        } else if (element.status == "done") {
          doneTasks.add(element);
        }
      });
      emit(TodoLoaded(todos));
      print('todos: $todos');
      return todos;
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
      return [];
    }
  }

  void addTodo({
    required String title,
    required String description,
  }) async {
    currentTasks = [];
    inProgressTasks = [];
    doneTasks = [];
    emit(TodoLoading());
    try {
      final todo = Todo(
        title: title,
        description: description,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );
      await todosRepository.addTodo(todo).then((value) {
        todo.id = todo.key;
        emit(TodoAdded());
        getTodos();
      });
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }

  Future<void> updateTodoStatus({required int id, required String status}) async {
    emit(TodoLoading());
    try {
      await todosRepository.updateTodoStatus(id, status).then((value) {
        emit(TodosUpdated());
      });
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }

  Future<void> deleteTodo(int id) async {
    emit(TodoLoading());
    try {
      await todosRepository.deleteTodo(id).then((value) {
        emit(TodosDeleted());
        getTodos();
      });
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }

  bool isBottomSheetShown = false;
  IconData fab = Icons.add;

  void changeBottomSheetState({required bool isShown}) {
    isBottomSheetShown = isShown;
    if (isBottomSheetShown) {
      fab = Icons.edit;
    } else {
      fab = Icons.add;
    }

    emit(TodoChangeStateBottomNavBar());
  }

  void clearAllTodos() {
    emit(TodoLoading());
    try {
      todosRepository.clearAllTodos().then((value) {
        emit(TodosCleared());
        getTodos();
      });
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }

  editTodo({required String title, required String description, required int key}) async {
    emit(TodoLoading());
    try {
      await todosRepository.editTodo(title: title, description: description, key: key).then((value) {
        emit(TodoEdited());
        getTodos();
      });
    } catch (e) {
      print(e.toString());
      emit(TodoError(e.toString()));
    }
  }
}
