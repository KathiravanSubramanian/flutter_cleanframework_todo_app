import 'package:clean_framework/clean_framework.dart';

import '../model/todo_model.dart';
import 'todo_list_entity.dart';

class TodoListUIOutput extends Output {
  final List<TodoModel> todoList;
  final TodoListStatus status;
  final bool isRefresh;
  final bool isDeleted;
  const TodoListUIOutput({
    required this.todoList,
    required this.status,
    required this.isRefresh,
    required this.isDeleted,
  });

  @override
  List<Object?> get props => [
        todoList,
        status,
        isRefresh,
        isDeleted,
      ];
}
