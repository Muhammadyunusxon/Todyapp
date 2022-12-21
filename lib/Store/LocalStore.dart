import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/Model/TodoModel.dart';

class LocalStore {
  LocalStore._();

  static setTodo(TodoModel todo) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    String todoJson = jsonEncode(todo.toJson());
    list.add(todoJson);
    store.setStringList('todo', list);
  }

  static setChangeStatus(TodoModel todo, int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    List<TodoModel> listOfTodo = [];
    list.forEach((element) {
      listOfTodo.add(TodoModel.fromJson(jsonDecode(element)));
    });
    listOfTodo.removeAt(index);
    listOfTodo.insert(index, todo);
    list.clear();
    listOfTodo.forEach((element) {
      list.add(jsonEncode(element.toJson()));
    });
    store.setStringList('todo', list);
  }

  static Future<List<TodoModel>> getListTodo() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    List<TodoModel> listOfTodo = [];
    list.forEach((element) {
      listOfTodo.add(TodoModel.fromJson(jsonDecode(element)));
    });
    return listOfTodo;
  }
  static removeTodo(int index) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('todo') ?? [];
    list.removeAt(index);
    store.setStringList('todo', list);
  }
}