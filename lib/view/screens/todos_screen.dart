import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/view/widgets/pop_up_menu_widget.dart';
import 'package:todo/view/widgets/todo_bottom_sheet_widget.dart';
import '../../cubit/states.dart';
import '../../utils/keys.dart';

class TodosScreen extends StatefulWidget {
  const TodosScreen({super.key});

  @override
  State<TodosScreen> createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodosCubit>(context).getTodos();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }

  void clearControllersAfterTodoAdded() {
    Navigator.pop(context);
    titleController.clear();
    timeController.clear();
    descriptionController.clear();
    dateController.clear();
  }

  void showTodoBottomSheet(BuildContext context, TodosCubit cubit) {
    scaffoldKey.currentState?.showBottomSheet(
          (BuildContext context) {
        return TodoBottomSheet(
          titleController: titleController,
          descriptionController: descriptionController,
          dateController: dateController,
          timeController: timeController,
        );
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
    )
        .closed
        .whenComplete(() {
      cubit.changeBottomSheetState(isShown: false);
    });
    cubit.changeBottomSheetState(isShown: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodosCubit, TodosState>(
      listener: (context, state) {
        if (state is TodoAdded) {
          clearControllersAfterTodoAdded();
        }
      },
      builder: (context, state) {
        final cubit = TodosCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              cubit.titles[cubit.tabIndex],
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            actions: [
              AppBarPopUpMenu(onTap: () {
                cubit.clearAllTodos();
              })
            ],
          ),
          key: scaffoldKey,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState?.validate() ?? false) {
                  cubit.addTodo(
                    title: titleController.text,
                    description: descriptionController.text,
                  );
                  cubit.changeBottomSheetState(isShown: false);
                }
              } else {
                showTodoBottomSheet(context, cubit);
              }
            },
            child: Icon(cubit.fab),
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.grey.shade200,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            currentIndex: cubit.tabIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.checklist_rounded), label: "Tasks"),
              BottomNavigationBarItem(icon: Icon(Icons.access_time_sharp), label: "InProgress"),
              BottomNavigationBarItem(icon: Icon(Icons.task_alt), label: "Done"),
            ],
          ),
          body: state is! TodoLoading ? cubit.tabs[cubit.tabIndex] : const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}