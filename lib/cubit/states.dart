import '../data/model/todo.dart';

abstract class TodosState{
  const TodosState();
}
class TodoInitial extends TodosState {}
class TodoLoading extends TodosState {}
class TodoLoaded extends TodosState {
  final List<Todo> todos;
  const TodoLoaded(this.todos);
}
class TodoAdded extends TodosState {}
class TodosUpdated extends TodosState {}
class TodosDeleted extends TodosState {}

class TodoError extends TodosState {
  final String message;
  const TodoError(this.message);
}
class TodoChangeStateBottomNavBar extends TodosState {}
class TodosCleared extends TodosState {}
class TodoEdited extends TodosState {}

