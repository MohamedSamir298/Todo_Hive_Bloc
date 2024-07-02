import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/view/widgets/todo_item_widget.dart';

class InProgressTasksTab extends StatelessWidget {
  const InProgressTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is TodosUpdated) {
          BlocProvider.of<TodosCubit>(context).getTodos();
        }
      },
      builder: (context, state) {
        List tasks = TodosCubit.get(context).inProgressTasks;
        return tasks.isNotEmpty
            ? Scaffold(
          body: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                child: TodoItemWidget(todo: tasks[index]),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(
                height: 5,
                thickness: 2,
                color: Colors.transparent,
              );
            },
            itemCount: tasks.length,
          ),
        )
            : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.menu,
                size: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              Text(
                "No Tasks Yet, Add Some Tasks",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
