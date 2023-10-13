import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

import '../model/todo_model.dart';

class TodoListViewModel extends ViewModel {
  final List<TodoModel> todoList;
  final bool isLoading;
  final bool hasFailedLoading;

  final VoidCallback onRetry;
  final AsyncCallback onRefresh;

  final ValueChanged<String> deleteById;

  const TodoListViewModel({
    required this.todoList,
    required this.isLoading,
    required this.hasFailedLoading,
    required this.onRetry,
    required this.onRefresh,
    required this.deleteById,
  });

  @override
  List<Object?> get props => [todoList, isLoading, hasFailedLoading];
}
