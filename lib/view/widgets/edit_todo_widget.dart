import 'package:flutter/material.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/data/model/todo.dart';

TextEditingController titleFieldController = TextEditingController();
TextEditingController descriptionFieldController = TextEditingController();

Future<void> editTodoWidget({required BuildContext context, required Todo todo}) async {
  TodosCubit cubit = TodosCubit.get(context);

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleFieldController,
              decoration: InputDecoration(
                labelText: todo.title,
                hintText: "Title",
                helperText: "Enter a title",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionFieldController,
              decoration: InputDecoration(
                labelText: todo.description,
                hintText: "Description",
                helperText: "Enter a description",
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('CANCEL'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              String title = titleFieldController.text.trim();
              String description = descriptionFieldController.text.trim();

              if (title.isNotEmpty && description.isNotEmpty) {
                cubit.editTodo(
                  title: title,
                  description: description,
                  key: todo.key,
                );
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please fill out all fields.'),
                  ),
                );
              }
            },
          ),
        ],
      );
    },
  );
}
