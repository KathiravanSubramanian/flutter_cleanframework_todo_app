import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/foundation.dart';

class TodoFormViewModel extends ViewModel {
  final FormController formController;
  final bool isLoading;
  final bool hasFailedLoading;
  final VoidCallback createTodo;
  final ValueChanged<String> updateById;

  const TodoFormViewModel({
    required this.formController,
    required this.isLoading,
    required this.hasFailedLoading,
    required this.createTodo,
    required this.updateById,
  });

  @override
  List<Object?> get props => [
        isLoading,
        hasFailedLoading,
      ];
}
