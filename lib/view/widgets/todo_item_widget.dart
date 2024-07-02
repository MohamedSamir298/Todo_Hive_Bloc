import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../cubit/cubit.dart';
import '../../data/model/todo.dart';
import 'edit_todo_widget.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;

  const TodoItemWidget({required this.todo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TodosCubit cubit = TodosCubit.get(context);
    return Slidable(
      key: Key("${todo.key}"),
      startActionPane: ActionPane(
        dismissible: DismissiblePane(onDismissed: () {
          cubit.deleteTodo(todo.key);
        }),
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              cubit.deleteTodo(todo.key);
            },
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
          SlidableAction(
            onPressed: (context) {
              cubit.updateTodoStatus(id: todo.key, status: "inprogress");
            },
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            icon: Icons.done_outline_rounded,
            label: 'In Progress',
          ),
          SlidableAction(
            onPressed: (context) {
              cubit.updateTodoStatus(id: todo.key, status: "done");
            },
            backgroundColor: Colors.black54,
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Done',
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35.0,
                backgroundColor: Colors.blueGrey.shade100,
                child: Text(
                  todo.status.toUpperCase(),
                  style: const TextStyle(fontSize: 10, color: Colors.white),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      todo.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      todo.createdAt.toIso8601String().substring(0, 10),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      todo.createdAt.toIso8601String().substring(11, 16),
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(child: const Icon(Icons.sync, color: Colors.grey), onTap: ()  {
              },),
              const SizedBox(width: 10),
              GestureDetector(child: const Icon(Icons.edit, color: Colors.grey), onTap: () async {
                await editTodoWidget(context: context, todo: todo);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
