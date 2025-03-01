import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoassessment/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController setActivityController = TextEditingController();
  TextEditingController setPriceController = TextEditingController();

  String setTypeValue = '';

  bool setBookingRequired = false;

  double setAccessbility = 0.0;

  List<TodoModel> _setListTodo = [];
  List<TodoModel> get getListTodo => _setListTodo;

  bool _setTodoLoading = false;
  bool get getTodoLoading => _setTodoLoading;

  List<String> setTodoType = [
    'Education',
    'Recreational',
    'Social',
    'DIY',
    'Charity',
    'Cooking',
    'Relaxation',
    'Music',
    'Busywork'
  ];

  void setBookingRequiredValue(bool value) {
    setBookingRequired = value;
    notifyListeners();
  }

  void setAccessbilityValue(double value) {
    setAccessbility = value;
    notifyListeners();
  }

  Future<void> addTodoList(TodoModel todo) async {
    setLoading(true);
    _setListTodo.add(todo);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList =
        _setListTodo.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todoList', todoList);
    setLoading(false);
  }

  Future<void> getTodoList() async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];
    _setListTodo =
        todoList.map((todo) => TodoModel.fromJson(jsonDecode(todo))).toList();
    setLoading(false);
  }

  Future<void> deleteSingleTodoList(int index) async {
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoList = prefs.getStringList('todoList') ?? [];
    _setListTodo =
        todoList.map((todo) => TodoModel.fromJson(jsonDecode(todo))).toList();
    _setListTodo.removeAt(index);
    List<String> newTodoList =
        _setListTodo.map((todo) => jsonEncode(todo.toJson())).toList();
    await prefs.setStringList('todoList', newTodoList);
    setLoading(false);
  }

  void setLoading(bool value) {
    _setTodoLoading = value;
    notifyListeners();
  }

  @override
  void dispose() {
    setActivityController.dispose();
    setPriceController.dispose();
    super.dispose();
  }
}
