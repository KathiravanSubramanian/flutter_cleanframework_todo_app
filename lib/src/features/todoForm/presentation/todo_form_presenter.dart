import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import '../domain/todo_form_entity.dart';
import '../domain/todo_form_ui_output.dart';
import '../domain/todo_form_use_case.dart';
import '../providers/todo_form_use_case_providers.dart';
import 'todo_form_view_model.dart';

class TodoFormPresenter
    extends Presenter<TodoFormViewModel, TodoFormUIOutput, TodoFormUseCase> {
  TodoFormPresenter({
    super.key,
    required super.builder,
    required this.inputType,
  }) : super(provider: todoFormUseCaseProvider);

  final Map<String, dynamic> inputType;

  @override
  void onLayoutReady(BuildContext context, TodoFormUseCase useCase) {
    if (inputType['id'] != '') {
      useCase.loadData(inputType);
    }
  }

  @override
  TodoFormViewModel createViewModel(
      TodoFormUseCase useCase, TodoFormUIOutput output) {
    return TodoFormViewModel(
      isLoading: output.status == TodoFormStatus.loading,
      hasFailedLoading: output.status == TodoFormStatus.failed,
      formController: useCase.todoFormController,
      updateById: (id) => useCase.updateById(id),
      createTodo: () => useCase.createTodo(),
    );
  }

  @override
  void onOutputUpdate(BuildContext context, TodoFormUIOutput output) {
    if (output.status == TodoFormStatus.failed) {
      inputType['id'] == ''
          ? showSnackbar('Sorry, failed to create todo!', context)
          : showSnackbar('Sorry, failed to update todo!', context);
    }

    if (output.status == TodoFormStatus.loaded) {
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Todo'),
            content: Text(inputType['id'] == ''
                ? 'Has been added successfully'
                : 'Has been updated successfully'),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: const Text('Done'),
              ),
            ],
          );
        },
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
