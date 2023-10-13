import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import '../domain/todo_list_entity.dart';
import '../domain/todo_list_ui_output.dart';
import '../domain/todo_list_use_case.dart';
import '../providers/todo_list_use_case_providers.dart';
import 'todo_list_view_model.dart';

class TodoListPresenter
    extends Presenter<TodoListViewModel, TodoListUIOutput, TodoListUseCase> {
  TodoListPresenter({
    super.key,
    required super.builder,
  }) : super(provider: todoListUseCaseProvider);

  @override
  TodoListViewModel createViewModel(
      TodoListUseCase useCase, TodoListUIOutput output) {
    return TodoListViewModel(
      todoList: output.todoList,
      isLoading: output.status == TodoListStatus.loading,
      hasFailedLoading: false,
      onRefresh: () => useCase.fetchData(isRefresh: true),
      onRetry: useCase.fetchData,
      deleteById: (id) => useCase.deleteById(id),
    );
  }

  @override
  onLayoutReady(BuildContext context, TodoListUseCase useCase) {
    useCase.fetchData();
  }

  @override
  void onOutputUpdate(BuildContext context, TodoListUIOutput output) {
    if (output.isRefresh) {
      showSnackbar(
        output.status == TodoListStatus.failed
            ? 'Sorry, failed refreshing Todo`s!'
            : 'Refreshed Todo`s successfully!',
        context,
      );
    }

    if (output.isDeleted) {
      showSnackbar(
        output.status == TodoListStatus.failed
            ? 'Sorry, failed to delete this todo!'
            : 'Deleted successfully!',
        context,
      );
    }
  }

  showSnackbar(String message, context) {
    final snackbar = SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
