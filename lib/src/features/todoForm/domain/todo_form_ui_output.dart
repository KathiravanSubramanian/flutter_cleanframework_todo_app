// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_framework/clean_framework.dart';

import 'todo_form_entity.dart';

class TodoFormUIOutput extends Output {
  final TodoFormStatus status;
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final FormController formController;

  const TodoFormUIOutput({
    this.id = '',
    this.title = '',
    this.description = '',
    this.isCompleted = false,
    this.status = TodoFormStatus.initial,
    required this.formController,
  });

  @override
  List<Object?> get props => [
        status,
        id,
        title,
        description,
        isCompleted,
        formController,
      ];
}
