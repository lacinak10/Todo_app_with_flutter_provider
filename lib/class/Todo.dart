import 'package:flutter/foundation.dart';

class Todo extends ChangeNotifier {
  List<String> todos = [];

  void addTask(String value) {
    todos.add(value);
    notifyListeners();
  }

  void removeTask(String value){
    todos.remove(value);
    notifyListeners();
  }

}
