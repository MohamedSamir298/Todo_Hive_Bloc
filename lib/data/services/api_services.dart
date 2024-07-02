import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:todo/helpers/exception_helper.dart';
import '../../utils/strings.dart';
import '../model/todo.dart';
class ApiService {
  Future<List<Todo>> fetchTodos(BuildContext context) async {
    try{

      final response = await http.get(Uri.parse('$baseUrl/todos'));
      if (response.statusCode == 200) {
        final List<dynamic> todoJson = json.decode(response.body);
        return todoJson.map((json) => Todo.fromJson(json)).toList();
      } else {
        ExceptionHelper(context, response.statusCode);
        return [];
      }
    }catch(e){
      print(e.toString());
      return [];
    }
  }

  Future<bool> addTodo(Todo todo, BuildContext context) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/todos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        ExceptionHelper(context, response.statusCode);
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }

  }

  Future<bool> updateTodo(Todo todo, BuildContext context) async {
    try{
      final response = await http.put(
        Uri.parse('$baseUrl/todos/${todo.id}'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(todo.toJson()),
      );
      if (response.statusCode == 200) {
        return true;
      }else{
        ExceptionHelper(context, response.statusCode);
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteTodo(String id, BuildContext context) async {
    try{
      final response = await http.delete(
        Uri.parse('$baseUrl/todos/$id'),
      );
      if (response.statusCode == 200) {
        return true;
      }else{
        ExceptionHelper(context, response.statusCode);
        return false;
      }
    }catch(e){
      print(e.toString());
      return false;
    }
  }

  Future<void> syncTodos(List<Todo> todos) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos/sync'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todos.map((todo) => todo.toJson()).toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to sync todos');
    }
  }
}
