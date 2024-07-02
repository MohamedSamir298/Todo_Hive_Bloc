import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/cubit/bloc_observer.dart';
import 'package:todo/utils/strings.dart';
import 'package:todo/view/screens/todos_screen.dart';

import 'cubit/cubit.dart';
import 'data/model/todo.dart';
import 'data/repository/todos_repository.dart';
import 'data/services/hive_services.dart';

void main() async {
  Bloc.observer = MyBLocObserver();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>(hiveBoxName);
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodosCubit(TodosRepository(TodoHiveServices())),
      child: const MaterialApp(home: TodosScreen()),
    );
  }
}
