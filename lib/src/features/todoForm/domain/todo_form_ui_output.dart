import 'package:clean_framework/clean_framework.dart';

import 'todo_form_entity.dart';

class TodoFormUIOutput extends Output {
  final TodoFormStatus status;
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final String createdAt;
  final String updatedAt;

  const TodoFormUIOutput({
    this.id = '',
    this.title = '',
    this.description = '',
    this.isCompleted = false,
    this.createdAt = '',
    this.updatedAt = '',
    this.status = TodoFormStatus.initial,
  });

  @override
  List<Object?> get props => [
        status,
        id,
        title,
        description,
        isCompleted,
        createdAt,
        updatedAt,
      ];
}
