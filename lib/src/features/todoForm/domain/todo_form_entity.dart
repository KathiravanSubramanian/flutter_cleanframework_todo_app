// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean_framework/clean_framework.dart';

enum TodoFormTags { title, description, isCompleted }

enum TodoFormStatus { initial, loading, loaded, failed }

class TodoFormEntity extends Entity {
  final TodoFormStatus status;
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final FormController formController;

  const TodoFormEntity({
    this.id = '',
    this.status = TodoFormStatus.initial,
    this.title = '',
    this.description = '',
    this.isCompleted = false,
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

  @override
  TodoFormEntity copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    TodoFormStatus? status,
    FormController? formController,
  }) {
    return TodoFormEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
      formController: formController ?? this.formController,
    );
  }
}
